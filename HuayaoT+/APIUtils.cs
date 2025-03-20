using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.IO;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading;

namespace JiandaoyunAPI
{
    class APIUtils
    {
        private static bool RETRY_IF_LIMITED = true;
        private static string WEBSITE = "https://api.jiandaoyun.com";
        private string urlGetWidgets;
        private string urlGetData;
        private string urlRetrieveData;
        private string urlCreateData;
        private string urlUpdateData;
        private string urlDeleteData;
        private string apiKey;
        private string appId;
        private string entryId;

        public APIUtils(string appId, string entryId, string apiKey)
        {
            this.urlGetWidgets = WEBSITE + "/api/v5/app/entry/widget/list"; //查询表单字段
            this.urlGetData = WEBSITE + "/api/v5/app/entry/data/list"; //查询多条
            this.urlRetrieveData = WEBSITE + "/api/v5/app/entry/data/get";//查询单条
            this.urlCreateData = WEBSITE + "/api/v5/app/entry/data/create"; //单条
            this.urlUpdateData = WEBSITE + "/api/v5/app/entry/data/update"; //单条
            this.urlDeleteData = WEBSITE + "/api/v5/app/entry/data/delete"; //单条
            this.apiKey = apiKey;
            this.appId = appId;
            this.entryId = entryId;
        }


        private static bool CheckValidationResult(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors errors)
        {
            return true; //总是接受  
        }

        /**
         * 发送HTTP请求
         **/
        public dynamic SendRequest(string method, string url, JObject data)
        {
            method = method.ToUpper();
            HttpWebRequest req;
            // HTTPS
            ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(CheckValidationResult);
            if (method.Equals("GET"))
            {
                StringBuilder builder = new StringBuilder();
                builder.Append(url);
                builder.Append("?");
                int i = 0;
                foreach (var item in data)
                {
                    if (i > 0)
                        builder.Append("&");
                    builder.AppendFormat("{0}={1}", item.Key, item.Value.ToString());
                    i++;
                }
                req = (HttpWebRequest)WebRequest.Create(builder.ToString());
                req.Method = "GET";
            }
            else
            {
                req = (HttpWebRequest)WebRequest.Create(url);
                req.Method = "POST";
                req.ContentType = "application/json;charset=utf-8";
                req.Headers["Authorization"] = "Bearer " + this.apiKey;
                byte[] bytes = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(data));
                req.ContentLength = bytes.Length;
                Stream stream = req.GetRequestStream();
                stream.Write(bytes, 0, bytes.Length);
                stream.Close();
            }
            JObject result = new JObject();
            try
            {
                using (Stream responsestream = req.GetResponse().GetResponseStream())
                {
                    using (StreamReader sr = new StreamReader(responsestream, Encoding.UTF8))
                    {
                        string content = sr.ReadToEnd();
                        result = JsonConvert.DeserializeObject<JObject>(content);
                    }
                }
            }
            catch (WebException ex)
            {
                HttpWebResponse response = (HttpWebResponse)ex.Response;

                if (response.StatusCode == HttpStatusCode.BadRequest || response.StatusCode == HttpStatusCode.Forbidden)
                {
                    using (Stream responsestream = response.GetResponseStream())
                    {
                        using (StreamReader sr = new StreamReader(responsestream, Encoding.UTF8))
                        {
                            string content = sr.ReadToEnd();
                            result = JsonConvert.DeserializeObject<JObject>(content);
                            if ((int)result["code"] == 8303 && RETRY_IF_LIMITED)
                            {
                                Thread.Sleep(5000);
                                return SendRequest(method, url, data);
                            }
                            else
                            {
                                throw new Exception("请求错误 Error Code: " + result["code"] + " Error Msg: " + result["msg"]);
                            }
                        }
                    }
                }
            }
            return result;
        }

        public JArray GetFormWidgets()
        {
            JObject data = new JObject
            {
                ["app_id"] = this.appId,
                ["entry_id"] = this.entryId
            };
            JObject result = SendRequest("POST", urlGetWidgets, data);
            return (JArray)result["widgets"];
        }

        public JArray GetFormData(string dataId, int limit, JArray fields, JObject filter)
        {
            JObject data = new JObject
            {
                ["app_id"] = this.appId,
                ["entry_id"] = this.entryId,
                ["data_id"] = dataId,
                ["limit"] = limit,
                ["fields"] = fields,
                ["filter"] = filter
            };
            JObject result = SendRequest("POST", urlGetData, data);
            return (JArray)result["data"];
        }

        private void GetNextPage(JArray formData, int limit, JArray fields, JObject filter, string dataId)
        {
            JArray data = GetFormData(dataId, limit, fields, filter);
            if (data != null && data.Count != 0)
            {
                foreach (var item in data)
                {
                    formData.Add(item);
                }
                string lastDataId = (string)data.Last["_id"];
                GetNextPage(formData, limit, fields, filter, lastDataId);
            }
        }

        public JArray GetAllFormData(JArray fields, JObject filter)
        {
            JArray formData = new JArray();
            GetNextPage(formData, 100, fields, filter, "");
            return formData;
        }

        public JObject RetrieveData(string dataId)
        {
            JObject data = new JObject
            {
                ["app_id"] = this.appId,
                ["entry_id"] = this.entryId,
                ["data_id"] = dataId
            };
            JObject result = SendRequest("POST", urlRetrieveData, data);
            return (JObject)result["data"];
        }

        public JObject UpdateData(string dataId, JObject update)
        {
            JObject data = new JObject
            {
                ["app_id"] = this.appId,
                ["entry_id"] = this.entryId,
                ["data_id"] = dataId,
                ["data"] = update
            };
            JObject result = SendRequest("POST", urlUpdateData, data);
            return (JObject)result["data"];
        }

        public JObject CreateData(JObject data)
        {
            JObject reqData = new JObject
            {
                ["app_id"] = this.appId,
                ["entry_id"] = this.entryId,
                ["data"] = data
            };
            JObject result = SendRequest("POST", urlCreateData, reqData);
            return (JObject)result["data"];
        }

        public JObject DeleteData(string dataId)
        {
            JObject data = new JObject
            {
                ["app_id"] = this.appId,
                ["entry_id"] = this.entryId,
                ["data_id"] = dataId
            };
            return SendRequest("POST", urlDeleteData, data);
        }
    }
}

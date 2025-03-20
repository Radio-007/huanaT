using System;
using System.Windows.Forms;
using System.Diagnostics;
using DevExpress.LookAndFeel;

namespace VirtuaAttendance
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            DevExpress.Skins.SkinManager.EnableFormSkins();
            DevExpress.UserSkins.BonusSkins.Register();
            //UserLookAndFeel.Default.SetSkinStyle("Xmas 2008 Blue");

            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo("zh-CN");

            //日志配置
            //string log4netfilename = Path.Combine(Application.StartupPath, "log4net.config");
            //log4net.Config.XmlConfigurator.ConfigureAndWatch(new FileInfo(log4netfilename));

            if (IsAlreadyRunning())
            {
                MessageBox.Show("系统已经启动，请不要重复运行。", "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
                Application.Exit();
            }
            else
            {
                Application.Run(new Main());
            }
        }

        static bool IsAlreadyRunning()
        {
            bool b = false;
            string pName = Process.GetCurrentProcess().ProcessName;
            Process[] mProcs = Process.GetProcessesByName(pName);
            if (mProcs.Length > 1)
                b = true;
            return b;
        }
    }
}

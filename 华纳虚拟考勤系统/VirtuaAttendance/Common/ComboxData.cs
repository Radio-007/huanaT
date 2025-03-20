using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GxRadio.Common
{
    public class ComboxData
    {
        public ComboxData()
        {
        }

        public ComboxData(string Text, string Value)
        {
            this.Text = Text;
            this.Value = Value;
        }

        public string Text {set;get;}
        public string Value { set; get; }
        public override string ToString()
        {
            return Text;
        }
    }
}

using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.IO;
using System.Drawing;

public partial class Contents_Pages_HistogramOnlineInquiry : System.Web.UI.Page
{
    ArrayList count = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {
        GetVote();
        Response.ContentType = "gif";

        int maxInt = 0, maxHeight = 0, rectWidth = 0, sper = 0;
        Bitmap img = new Bitmap(400, 300);
        Graphics gra = Graphics.FromImage(img);
        gra.Clear(Color.White);

        Font font14 = new Font("黑体", 14);
        Font font9 = new Font("宋体", 9);
        Brush blackBrush = Brushes.Black;

        int left = 10, top = 10, width = 400 - 20, height = 300 - 30, bottom = 300 - 20;

        gra.DrawRectangle(Pens.Black, left, top, width, height);

        string strTitle = "你通过那些途径学习ASP.NET技术";
        gra.DrawString(strTitle, font14, Brushes.Black, left + (width / 2 - gra.MeasureString(strTitle, font14).Width / 2), top + 10);

        //数据来源
        int num=count.Count;  
        int[] a = (int[])count.ToArray(typeof(int));

        string[] str = new string[] { "张雨杰", "李明达", "王玉兰", "马伟明", "王子文", "黄渤", "王宝强", "张群英" }; 

        //求最高票数
        for (int i = 0; i <num; i++)
            if (maxInt < a[i])
                maxInt = a[i];
        //设置柱状图的最大高度、宽度、间隔
        maxHeight = 200;
        rectWidth = width /num/ 2;
        sper = width / num;

        string s, strCatalogue;

        for (int i = 0; i < num; i++)
        {
            Brush colorBrush = Brushes.BlueViolet;
            s = a[i].ToString();
            strCatalogue = str[i].ToString();

            gra.FillRectangle(colorBrush, left + 10 + i * sper, bottom - (a[i] * maxHeight / maxInt), rectWidth, a[i] * maxHeight / maxInt);
            gra.DrawString(s, font9, blackBrush, left + 10 + i * sper + rectWidth / 2 - gra.MeasureString(s, font9).Width / 2, bottom - (a[i] * maxHeight / maxInt) - gra.MeasureString(s, font9).Height);
            gra.DrawString(strCatalogue, font9, blackBrush, left + 10 + i * sper + rectWidth / 2 - gra.MeasureString(strCatalogue, font9).Width / 2, bottom + 2);
        }
        img.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Gif);
        //img.Save(Server.MapPath(@"~/Images/") + "Voting.gif", System.Drawing.Imaging.ImageFormat.Gif);
        //Img_Voting.ImageUrl = @"~/Images/Voting.gif";
        gra.Dispose();
        img.Dispose();
    }
    private void GetVote()
    {
        string filepath = Server.MapPath("~/Contents/Txt/OnlineVoting.txt");
        StreamReader sr = File.OpenText(filepath);
        while (sr.Peek() != -1)
        {
            string str = sr.ReadLine();
            string[] strvote = str.Split('|');
            foreach (string ss in strvote)
                count.Add(int.Parse(ss));
        }
        sr.Close();
    }
}

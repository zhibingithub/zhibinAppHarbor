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

public partial class OnlineVoting : System.Web.UI.Page
{

    ArrayList count = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {
        Lab_View.Text = "";
            HttpCookie getCookie=Request.Cookies["Vote"];
        if (getCookie == null)
            Lab_State.Text = "您还未投过票";
        else
            Lab_State.Text = "您已经投过票了";
        GetVote();
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
    protected void PutVote()
    {
        string filepath = Server.MapPath("~/Contents/Txt/OnlineVoting.txt");
        StreamWriter sw = new StreamWriter(filepath,false);
        string str = count[0].ToString();
        for (int i = 1; i < count.Count; i++)
            str += "|" + count[i].ToString();
        sw.WriteLine(str);
        sw.Close();
    }
 
    protected void Btn_Look_Click(object sender, EventArgs e)
    {
        Lab_View.Text = "各候选人票数;";
        for (int i = 0; i < Radio_Vote.Items.Count; i++)
            Lab_View.Text += Radio_Vote.Items[i].Value + ": " + count[i] + "票" + "<br/>";
    }
    protected void Btn_Vote_Click(object sender, EventArgs e)
    {
        if (Radio_Vote.SelectedIndex != -1)
        {
            //防止重复投票
            HttpCookie getCookie = Request.Cookies["Vote"];
            if (getCookie == null)
            {
                int k = Radio_Vote.SelectedIndex;

                count[k] = int.Parse(count[k].ToString()) + 1;
                PutVote();
                HttpCookie vCookie = new HttpCookie("Vote");
                vCookie.Value = "vote";
                vCookie.Expires = DateTime.Now.AddDays(1);
                Response.Cookies.Add(vCookie);
                Response.Write("<script>alert('投票成功！');</script>");
            }
            else
            { Response.Write("<script>alert('您已经投过票了，不能重复投票！');</script>"); }
        }
        else
        { Response.Write("<script>alert('请选择投票项！');</script>"); }
    }
}

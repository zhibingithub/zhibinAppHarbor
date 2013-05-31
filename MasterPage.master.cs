using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Data.SqlClient;

public partial class MasterPage : System.Web.UI.MasterPage
{
    //public string name { get; set; }
    int UserID;
    int ScarID;
    string connstr = ConfigurationManager.ConnectionStrings["SqlConnStr"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Text_Name.Text;
        string pwd = Text_Pwd.Text;
        if (Request.Cookies["UserInfo"]!=null)
        {
            if ( Request.Cookies["UserInfo"]["UserName"] != null && Request.Cookies["UserInfo"]["UserPwd"]!=null)
            {
                HttpCookie aCookie = Request.Cookies["UserInfo"];
                string myname = aCookie.Values["UserName"];
                //string mypwd = aCookie.Values["UserPwd"];
                //Response.Write("Cookie[用户名]" + name);
                //Response.Write("Cookie[密码]" + pwd);
                Text_Name.Visible = false;
                Text_Pwd.Visible = false;
                Btn_Login.Visible = false;
                Btn_Logout.Visible = true;
                Btn_Reg.Visible = false;
                if (Session["ScarID"] != null)
                {
                    ScarID =Convert.ToInt16( Session["ScarID"] );
                }
                else {
                    GetScarID(name, pwd);
                    ScarID = Convert.ToInt16(Session["ScarID"]);
                }
                Lab_LogState.Text = "欢迎" + myname + ScarID;
            }
        }
        else
        {
            Page.RegisterStartupScript("", "<script>alert('请登录！');</script>");
        }
    }
    //登录
    protected void Btn_Login_Click(object sender, EventArgs e)
    {
        string name = Text_Name.Text;
        string pwd = Text_Pwd.Text;
        SqlConnection conn = new SqlConnection(connstr);
        //string sqlstr = "SELECT COUNT(*) FROM Web_User WHERE User_Name='" + Text_Name.Text + "' AND User_PassWord='" + Text_Pwd.Text + "'";
        //SqlCommand cmd = new SqlCommand(sqlstr, conn);
        //int count = Convert.ToInt32(cmd.ExecuteScalar());
        //if (count > 0)
        //{
        //}
        //else
        //{
        //}
        if (name == "" || pwd == "")
        {
            Page.RegisterStartupScript("", "<script>alert('请输入用户名和密码');</script>");
        }
        else
        {
            conn.Open();

        
                
                //
                HttpCookie vCookie = new HttpCookie("UserInfo");
                vCookie.Values["UserName"] = Server.UrlEncode(name);
                vCookie.Values["UserPwd"] = Server.UrlEncode(pwd);
                vCookie.Expires = DateTime.Now.AddDays(1);
                Response.Cookies.Add(vCookie);

                Text_Name.Visible = false;
                Text_Pwd.Visible = false;
                Btn_Login.Visible = false;
                Btn_Logout.Visible = true;
                Btn_Reg.Visible = false;

                Lab_LogState.Text = "欢迎" + vCookie.Values["UserName"];

                ScarID=GetScarID(name, pwd);
                conn.Close();
                Session["UserID"] = UserID;
                Session["ScarID"] = ScarID;
                Lab_Scar.Text = "购物车" + ScarID;

        }
    }
    //注册
    protected void Btn_Reg_Click(object sender, EventArgs e)
    {
        Response.Redirect("Register.aspx");
    }
    //退出
    protected void Btn_Logout_Click(object sender, EventArgs e)
    {
        HttpCookie aCookie;
        string cookieName;
        int maxNum = Request.Cookies.Count;
        for (int i = 0; i < maxNum; i++)
        {
            cookieName = Request.Cookies[i].Name;
            aCookie = new HttpCookie(cookieName);
            aCookie.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(aCookie);
        }
        Session.Clear();
        Response.Write("<script>window.location.href='Default.aspx'</script>");
    }
    protected int RegScarID(int User_ID)
    {
        SqlConnection conn = new SqlConnection(connstr);
        conn.Open();
        string sqlstr = "insert into Web_ShoppingCar(Scar_UserID,Scar_Time) values(@User_ID,@Scar_Time)";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlParameter para1 = new SqlParameter("@User_ID", UserID);
        cmd.Parameters.Add(para1);
        SqlParameter para2 = new SqlParameter("@Scar_Time", DateTime.Now.ToString());
        cmd.Parameters.Add(para2);
        cmd.ExecuteNonQuery();

        sqlstr = "select Scar_ID from Web_ShoppingCar where Scar_UserID=@User_ID";
        cmd = new SqlCommand(sqlstr, conn);
        para1 = new SqlParameter("@User_ID", UserID);
        cmd.Parameters.Add(para1);

        int ScarID = Convert.ToInt16(cmd.ExecuteScalar());
        return ScarID;
    }
    protected int GetScarID(string name,string pwd)
    {
        SqlConnection conn = new SqlConnection(connstr);
        string sqlstr = "select * from Web_User where User_Name=@name and User_PassWord=@pwd";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        conn.Open();
        SqlParameter para1 = new SqlParameter("@name", name);
        cmd.Parameters.Add(para1);
        SqlParameter para2 = new SqlParameter("@pwd", pwd);
        cmd.Parameters.Add(para2);
        SqlDataReader sdr = cmd.ExecuteReader();

        if (sdr.Read())
        {
            UserID = Convert.ToInt16(sdr["User_ID"]);
        }
        else
        {
            Page.RegisterStartupScript("", "<script>alert('用户名和密码输入错误');</script>");
        }
        sdr.Close();

        sqlstr = "select * from Web_ShoppingCar where Scar_UserID=@User_ID";
        cmd = new SqlCommand(sqlstr, conn);
        para1 = new SqlParameter("@User_ID", UserID);
        cmd.Parameters.Add(para1);
        sdr = cmd.ExecuteReader();

        if (sdr.Read())
        {
            ScarID = Convert.ToInt16(sdr["Scar_ID"]);
            sdr.Close();
        }
        else
        {
            sdr.Close();

            ScarID = RegScarID(UserID);

        }
        conn.Close();
        return ScarID;
    }
}

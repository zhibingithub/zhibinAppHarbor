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
using System.Data.SqlClient;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void But_Login_Click(object sender, EventArgs e)
    {
        string name = Text_Name.Text;
        string pwd = Text_Pwd.Text;
        if (name == "" || pwd == "")
        {
            Page.RegisterStartupScript("", "<script>alert('请输入用户名和密码');</script>");
        }
        else {
            string connstr = ConfigurationManager.ConnectionStrings["SqlConnStr"].ConnectionString;
            SqlConnection conn = new SqlConnection(connstr);
            conn.Open();
            //string sqlstr = "SELECT COUNT(*) FROM Web_User WHERE User_Name='" + Text_Name.Text + "' AND User_PassWord='" + Text_Pwd.Text + "'";
            //SqlCommand cmd = new SqlCommand(sqlstr, conn);

            //int count = Convert.ToInt32(cmd.ExecuteScalar());
            //if (count > 0)
            //{
            //    Response.Redirect("Default.aspx");
            //}
            //else
            //{
            //    Response.Write("用户名或密码错误");
            //}
            string sqlstr = "select User_ID from Web_User where User_Name=@name and User_PassWord=@pwd";
            SqlCommand cmd = new SqlCommand(sqlstr,conn);
            SqlParameter para1 = new SqlParameter("@name",name);
            cmd.Parameters.Add(para1);
            SqlParameter para2 = new SqlParameter("@pwd",pwd);
            cmd.Parameters.Add(para2);
            SqlDataReader sdr=cmd.ExecuteReader();

            if (sdr.Read())
            {
                int User_ID = Convert.ToInt16(sdr["User_ID"]);
                int Scar_ID;
                sdr.Close();

                sqlstr = "select * from Web_ShoppingCar where Scar_UserID=@User_ID";
                cmd = new SqlCommand(sqlstr, conn);
                para1 = new SqlParameter("@User_ID", User_ID);
                cmd.Parameters.Add(para1);
                sdr = cmd.ExecuteReader();

                if (sdr.Read())
                {
                    Scar_ID = Convert.ToInt16(sdr["Scar_ID"]);
                    sdr.Close();
                }
                else
                {
                    sdr.Close();

                    sqlstr = "insert into Web_ShoppingCar(Scar_UserID,Scar_Time) values(@User_ID,@Scar_Time)";
                    cmd = new SqlCommand(sqlstr, conn);
                    para1 = new SqlParameter("@User_ID", User_ID);
                    cmd.Parameters.Add(para1);
                    para2 = new SqlParameter("@Scar_Time", DateTime.Now.ToString());
                    cmd.Parameters.Add(para2);
                    cmd.ExecuteNonQuery();

                    sqlstr = "select Scar_ID from Web_ShoppingCar where Scar_UserID=@User_ID";
                    cmd = new SqlCommand(sqlstr, conn);
                    para1 = new SqlParameter("@User_ID", User_ID);
                    cmd.Parameters.Add(para1);
                    Scar_ID = Convert.ToInt16(cmd.ExecuteScalar());
                }

                Session["User_ID"] = User_ID;
                Session["Scar_ID"] = Scar_ID;
                Response.Redirect("Default.aspx");
            }
            else {
                Page.RegisterStartupScript("","<script>alert('用户名和密码输入错误');</script>");
            }
       
        }
    }
}

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

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Btn_Reg_Click(object sender, EventArgs e)
    {
        if(Page.IsValid){
            string name = Text_Name.Text;
            string pwd = Text_Pwd.Text;

            string connstr = ConfigurationManager.ConnectionStrings["SqlConnStr"].ConnectionString;
            Response.Write(connstr);
            SqlConnection conn = new SqlConnection(connstr);
            conn.Open();
            string sqlstr = "INSERT INTO Web_User(User_Name,User_PassWord) VALUES(@User_Name,@User_PassWord)";
            SqlParameter[] prams ={ new SqlParameter("@User_Name",name),
                                   new SqlParameter("@User_PassWord",pwd)};
            SqlCommand cmd = new SqlCommand(sqlstr,conn);
            
            if (prams != null)
            {
                foreach (SqlParameter para in prams)
                    cmd.Parameters.Add(para);
            }
            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('注册成功')</script>");
        }
    }
}

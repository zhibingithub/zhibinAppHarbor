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

public partial class WareShow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (Session["UserID"] != null && e.CommandName == "AddShop")
        {
            int wareID = Convert.ToInt16(DataList1.DataKeys[e.Item.ItemIndex]);
            string connstr = ConfigurationManager.ConnectionStrings["SqlConnStr"].ConnectionString;
            SqlConnection conn = new SqlConnection(connstr);
            conn.Open();

            string sqlstr = "insert into Web_ShoppingInfo(Sinfo_ScarID,Sinfo_WareID) values(@ScarID,@WareID)";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlParameter para3 = new SqlParameter("@ScarID", SqlDbType.Int);
            para3.Value = Convert.ToInt16(Session["ScarID"]);
            SqlParameter para4 = new SqlParameter("@WareID", SqlDbType.Int);
            para4.Value = wareID;
            cmd.Parameters.Add(para3);
            cmd.Parameters.Add(para4);
            cmd.ExecuteNonQuery();

            Response.Redirect("WareShoppingCart.aspx?ScarID=" + Convert.ToInt16(Session["ScarID"]));
        }
        else {
            Page.RegisterStartupScript("","<script>alert('请先登录！')</script>");
        }
    }
}

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

public partial class WareManage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.SelectedIndex = -1;
    }
    protected string ImageUpload(FileUpload fUpload)
    {
        bool fileValid = false;
        string strImage = "";
        if (fUpload.HasFile)
        {
            //获取
            String fileExtension = Path.GetExtension(fUpload.FileName).ToLower();
            //过滤
            String[] allowExtension = { ".gif",".jpg",".bmp",".png" };
            for(int i=0;i<allowExtension.Length;i++){
                if (fileExtension == allowExtension[i]) {
                    fileValid = true;
                    break;
                }
            }
            if (fileValid == true)
            {
                try
                {
                    fUpload.SaveAs(Server.MapPath("~\\Images\\Ware") + fUpload.FileName);
                    strImage = "~\\Images\\Ware" + fUpload.FileName.ToString();
                }
                catch (Exception ee)
                {
                    Response.Write("<script>alert(ee.Message)</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('请上传.gif, .jpg, .png格式的文件')</script>");
            }
        }
        return strImage;
    }
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        DropDownList DropDownList2 = (DropDownList)FormView1.FindControl("DropDownList2");
        SqlDataSource1.InsertParameters["Ware_TypeID"].DefaultValue = DropDownList2.SelectedValue;
        FileUpload file1 = (FileUpload)FormView1.FindControl("FileUpload3");
        SqlDataSource1.InsertParameters["Ware_Image"].DefaultValue = ImageUpload(file1);
    }
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        DropDownList DropDownList1 = (DropDownList)FormView1.FindControl("DropDownList1");
        SqlDataSource1.UpdateParameters["Ware_TypeID"].DefaultValue = DropDownList1.SelectedValue;
        FileUpload file1 = (FileUpload)FormView1.FindControl("FileUpload1");
        SqlDataSource1.UpdateParameters["Ware_Image"].DefaultValue = ImageUpload(file1);
    }
    protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
    {
        SqlDataSource3.SelectParameters[0].DefaultValue = FormView1.DataKey.Value.ToString();
        DataView dv = (DataView)SqlDataSource3.Select(DataSourceSelectArguments.Empty);
        if (dv.Count != 0) {
            Page.RegisterStartupScript("", "<script>alert('该商品不能删除！')</script>");
            e.Cancel = true;
        }
    }
    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        FormView1.PageIndex = e.NewSelectedIndex + GridView1.PageIndex * GridView1.PageSize;
    }
}

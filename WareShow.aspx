<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="WareShow.aspx.cs" Inherits="WareShow" Title="商品展示" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<form action="#">
    <div class="container">
            <div class="row">
                <div class="span3">
                    <ul class="nav nav-pills nav-stacked">
                      <li class="nav-header"></li>
                      <li class="active"><a href="#">所有图书<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">ASP.NET<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">Python<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">Hadoop<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">OpenStack<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">虚拟化<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">云计算<i class="icon-chevron-right pull-right"></i></a></li>
                    </ul>
                </div>
                <div class="span9"><div class="span6 shoppingshow">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:SqlConnStr %>" 
                        SelectCommand="SELECT * FROM [Web_Ware]"></asp:SqlDataSource>
                    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" 
                        Width="100%" onitemcommand="DataList1_ItemCommand" DataKeyField="Ware_ID">
                        <ItemTemplate>
                            <table class="shoppingshow">
                                <tr>
                                    <td class="shoppingshow_image" rowspan="3">
                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Ware_Image") %>' />
                                    </td>
                                    <td class="shoppingshow_title">
                                        <asp:Label ID="Lab_WareName" runat="server" Text='<%# Eval("Ware_Name") %>'></asp:Label>
                                    </td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="">
                                        <asp:Label ID="Lab_WareInfo" runat="server" Text='<%# Eval("Ware_Information") %>'></asp:Label>
                                        <asp:Label ID="Label4" runat="server" Text="[详细]"></asp:Label>
                                    </td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="shoppingshow_price">
                                        <asp:Label ID="Label1" runat="server" Text="Label">当前价格:</asp:Label>
                                        <asp:Label ID="Lab_WarePrice" runat="server" Text='<%# Eval("Ware_Price") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Button ID="Button1" runat="server" Text="加入购物车" CssClass="btn-large" CommandName="AddShop" />
                                    </td>
                                </tr>
                            </table>
                            <br /><br />
                        </ItemTemplate>
                    </asp:DataList></div>   
                </div>
                
            </div>        
        </div>
</form>
</asp:Content>


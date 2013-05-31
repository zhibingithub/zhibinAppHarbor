<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="WareShoppingCart.aspx.cs" Inherits="WareShoppingCart" Title="购物车" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form action="#">
        <div class="row">
            您已购选以下商品
            <hr />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SqlConnStr %>" 
                DeleteCommand="DELETE FROM Web_ShoppingInfo WHERE (Sinfo_ID = @Sinfo_ID)" 
                SelectCommand="SELECT Web_ShoppingInfo.Sinfo_Num, Web_Ware.Ware_Name, Web_Ware.Ware_Price, Web_Ware.Ware_DiscountPrice FROM Web_ShoppingCar INNER JOIN Web_ShoppingInfo ON Web_ShoppingCar.Scar_ID = Web_ShoppingInfo.Sinfo_ScarID INNER JOIN Web_Ware ON Web_ShoppingInfo.Sinfo_WareID = Web_Ware.Ware_ID WHERE (Web_ShoppingCar.Scar_ID = @Scar_ID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Scar_ID" QueryStringField="ScarID" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Sinfo_ID" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="Ware_Name" HeaderText="商品名称" 
                        SortExpression="Ware_Name" />
                    <asp:BoundField DataField="Ware_Price" HeaderText="商品价格" 
                        SortExpression="Ware_Price" />
                    <asp:BoundField DataField="Ware_DiscountPrice" HeaderText="折后价格" 
                        SortExpression="Ware_DiscountPrice" />
                    <asp:BoundField DataField="Sinfo_Num" HeaderText="商品数量" 
                        SortExpression="Sinfo_Num" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
            
            <hr />
        </div>
    </form>
</asp:Content>


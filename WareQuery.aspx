<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="WareQuery.aspx.cs" Inherits="WareQuery" Title="商品查询" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<form action="#">
    <div class="row" style="padding-top:30px;">
        <div class="span3">

                <asp:Label ID="Lab_WareName" runat="server" Text="商品名称:"></asp:Label>
                
                    <br />
                <asp:TextBox ID="Text_Search" runat="server"></asp:TextBox>
                
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SqlConnStr %>" 
                    SelectCommand="SELECT * FROM [Web_WareType]"></asp:SqlDataSource>
                    
                    <br />
                <asp:Label ID="Lab_WareType" runat="server" Text="商品类别:"></asp:Label>
                
                    <br />
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="WareType_Name" 
                    DataValueField="WareType_ID">
                </asp:DropDownList>
                
                    <br />
                <asp:Button ID="Button1" runat="server" Text="查询" CssClass="btn" />

        </div>
        <div class="span9"><div class="span8" style="padding:10px 0 100px 0;">
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SqlConnStr %>" 
                
                SelectCommand="SELECT [Ware_Name], [Ware_TypeID], [Ware_Price], [Ware_Information], [Ware_AllSum], [Ware_SellSum] FROM [Web_Ware]">
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource2" AllowPaging="True" PageSize="15" CssClass="table">
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" 
                    PreviousPageText="上一页" />
                <Columns>
                    <asp:BoundField DataField="Ware_Name" HeaderText="商品名称" 
                        SortExpression="Ware_Name" />
                    <asp:BoundField DataField="Ware_AllSum" HeaderText="剩余" 
                        SortExpression="Ware_AllSum" />
                    <asp:BoundField DataField="Ware_SellSum" HeaderText="已售" 
                        SortExpression="Ware_SellSum" />
                    <asp:BoundField DataField="Ware_Price" HeaderText="单价" 
                        SortExpression="Ware_Price" />
                    <asp:BoundField DataField="Ware_Information" HeaderText="说明" 
                        SortExpression="Ware_Information" />
                    <asp:BoundField DataField="Ware_TypeID" HeaderText="商品类别" 
                        SortExpression="Ware_TypeID" />
                </Columns>
            </asp:GridView></div>
        </div>
    </div>
</form>
</asp:Content>


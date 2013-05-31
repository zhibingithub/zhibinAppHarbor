<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="WareManage.aspx.cs" Inherits="WareManage" Title="商品管理" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<form action="">
    <div class="row">
        <div class="span8"  style=" padding-left:160px;">
            <hr />
            [商品信息管理] :
            <hr />
            <%--数据源--%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SqlConnStr %>" 
                DeleteCommand="DELETE FROM Web_Ware WHERE (Ware_ID = @Ware_ID)" 
                InsertCommand="INSERT INTO Web_Ware(Ware_Name, Ware_AllSum, Ware_Price, Ware_Image, Ware_TypeID) VALUES (@Ware_Name, @Ware_AllSum, @Ware_Price, @Ware_Image, @Ware_TypeID)" 
                SelectCommand="SELECT Web_Ware.*, Web_WareType.WareType_Name FROM Web_Ware INNER JOIN Web_WareType ON Web_Ware.Ware_TypeID = Web_WareType.WareType_ID" 
                UpdateCommand="UPDATE Web_Ware SET Ware_TypeID = @Ware_TypeID, Ware_Name = @Ware_Name, Ware_AllSum = @Ware_AllSum, Ware_Price = @Ware_Price, Ware_Image = @Ware_Image FROM Web_Ware INNER JOIN Web_WareType ON Web_Ware.Ware_TypeID = Web_WareType.WareType_ID WHERE (Web_Ware.Ware_ID = @Ware_ID)">
                <DeleteParameters>
                    <asp:Parameter Name="Ware_ID" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Ware_TypeID" />
                    <asp:Parameter Name="Ware_Name" />
                    <asp:Parameter Name="Ware_AllSum" />
                    <asp:Parameter Name="Ware_Price" />
                    <asp:Parameter Name="Ware_Image" />
                    <asp:Parameter Name="Ware_ID" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="Ware_Name" />
                    <asp:Parameter Name="Ware_AllSum" />
                    <asp:Parameter Name="Ware_Price" />
                    <asp:Parameter Name="Ware_Image" />
                    <asp:Parameter Name="Ware_TypeID" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SqlConnStr %>" 
                SelectCommand="SELECT * FROM [Web_WareType]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SqlConnStr %>" 
                SelectCommand="SELECT [Buy_ID] FROM [Web_BuyInfo] WHERE ([Buy_Ware_ID] = @Buy_Ware_ID)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="@Buy_WareID" Name="Buy_Ware_ID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <%--商品列表--%>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="Ware_ID" DataSourceID="SqlDataSource1" ShowFooter="True" 
                AllowPaging="True" onpageindexchanging="GridView1_PageIndexChanging" 
                onselectedindexchanging="GridView1_SelectedIndexChanging" Width="100%">
                <Columns>
                    <asp:BoundField DataField="Ware_ID" HeaderText="商品编号" InsertVisible="False" 
                        ReadOnly="True" SortExpression="Ware_ID" />
                    <asp:BoundField DataField="Ware_Name" HeaderText="商品名称" 
                        SortExpression="Ware_Name" />
                    <asp:BoundField DataField="Ware_AllSum" HeaderText="商品数量" 
                        SortExpression="Ware_AllSum" />
                    <asp:BoundField DataField="Ware_Price" HeaderText="商品价格" 
                        SortExpression="Ware_Price" />
                    <asp:BoundField DataField="WareType_Name" HeaderText="商品类别" 
                        SortExpression="WareType_Name" />
                    <asp:HyperLinkField Text="选择" />
                </Columns>
            </asp:GridView>
            <br />
            <%--详细商品信息--%>
            <asp:FormView ID="FormView1" runat="server" BorderWidth="1px" EnableViewState="False" 
                GridLines="Both" HeaderText="[详细商品信息]" DataKeyNames="Ware_ID" 
                DataSourceID="SqlDataSource1" Width="80%" 
                onitemdeleting="FormView1_ItemDeleting" 
                oniteminserting="FormView1_ItemInserting" 
                onitemupdating="FormView1_ItemUpdating">
                <EditItemTemplate>
                    <br />
                    &nbsp;<table style="width:100%;">
                        <tr>
                            <td>
                                商品编号 :</td>
                            <td>
                                <asp:Label ID="Ware_IDLabel1" runat="server" Text='<%# Eval("Ware_ID") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                商品名称 :</td>
                            <td>
                                <asp:TextBox ID="Ware_NameTextBox" runat="server" 
                                    Text='<%# Bind("Ware_Name") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                商品类别 :</td>
                            <td>
                                <asp:DropDownList ID="DropDownList1" runat="server" 
                                    DataSourceID="SqlDataSource2" DataTextField="WareType_Name" 
                                    DataValueField="WareType_ID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                                                <tr>
                            <td>
                                商品数量 :</td>
                            <td>
                                <asp:TextBox ID="Ware_AllSumTextBox" runat="server" 
                                    Text='<%# Bind("Ware_AllSum") %>' />
                                                    </td>
                        </tr>
                        <tr>
                            <td>
                                商品价格 :</td>
                            <td>
                                <asp:TextBox ID="Ware_PriceTextBox" runat="server" 
                                    Text='<%# Bind("Ware_Price") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                商品图片 :</td>
                            <td>
                                <asp:FileUpload ID="FileUpload1" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                    CommandName="Update" Text="更新" />
                                    &nasp;
                                <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                                    CommandName="Cancel" Text="取消" />
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <table style="width:100%;">
                        <tr>
                            <td>
                                商品名称 :</td>
                            <td>
                                <asp:TextBox ID="Ware_NameTextBox" runat="server" 
                                    Text='<%# Bind("Ware_Name") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                商品类别 :</td>
                            <td>
                                <asp:TextBox ID="WareType_NameTextBox" runat="server" 
                                    Text='<%# Bind("WareType_Name") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                商品数量 :</td>
                            <td>
                                <asp:TextBox ID="Ware_AllSumTextBox" runat="server" 
                                    Text='<%# Bind("Ware_AllSum") %>' />
                            </td>
                        </tr>
                         <tr>
                            <td>
                                商品价格 :</td>
                            <td>
                                <asp:TextBox ID="Ware_PriceTextBox" runat="server" 
                                    Text='<%# Bind("Ware_Price") %>' />
                             </td>
                        </tr>
                        <tr>
                            <td>
                                商品图片 :</td>
                            <td>
                                <asp:FileUpload ID="FileUpload2" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                    CommandName="Insert" Text="插入" />
                                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                    CommandName="Cancel" Text="取消" />
                            </td>
                        </tr>
                    </table>
                </InsertItemTemplate>
                <ItemTemplate>
                    <table style="width:100%;">
                        <tr>
                            <td>
                                商品编号 :</td>
                            <td>
                                <asp:Label ID="Ware_IDLabel" runat="server" Text='<%# Eval("Ware_ID") %>' />
                            </td>
                            <td rowspan="5">
                                <asp:Image ID="Image1" CssClass="shoppingshow_image" runat="server" ImageUrl='<%# Eval("Ware_Image") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                商品类别 :</td>
                            <td>
                                <asp:Label ID="WareType_NameLabel" runat="server" 
                                    Text='<%# Bind("WareType_Name") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                商品名称 :</td>
                            <td>
                                <asp:Label ID="Ware_NameLabel" runat="server" Text='<%# Bind("Ware_Name") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                商品数量 :</td>
                            <td>
                                
                                <asp:Label ID="Ware_AllSumLabel" runat="server" 
                                    Text='<%# Bind("Ware_AllSum") %>' />
                                
                            </td>
                        </tr>
                        <tr>
                            <td>
                                商品价格 :</td>
                            <td>
                                
                                <asp:Label ID="Ware_PriceLabel" runat="server" 
                                    Text='<%# Bind("Ware_Price") %>' />
                                
                            </td>
                        </tr>
                    </table>
                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                        CommandName="Edit" Text="编辑" />
                    &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                        CommandName="Delete" Text="删除" />
                    &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                        CommandName="New" Text="新建" />
                </ItemTemplate>
                
                
            </asp:FormView>
        </div>
    </div>
</form>
</asp:Content>


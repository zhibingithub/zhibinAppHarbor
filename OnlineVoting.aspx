<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="OnlineVoting.aspx.cs" Inherits="OnlineVoting" Title="无标题页" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form action="">
    <div class="row">
    <div class="span6 offset3"  style="padding-bottom:400px">
        <table class="table">
            <tr><td colspan="2"><h3>在线投票系统</h3></td></tr>
            <tr>
                <td>
                    注意 :
                    <asp:Label ID="Lab_State" runat="server"></asp:Label>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:RadioButtonList ID="Radio_Vote" runat="server" RepeatColumns="2">
                        <asp:ListItem>张雨杰</asp:ListItem>
                        <asp:ListItem>李明达</asp:ListItem>
                        <asp:ListItem>王玉兰</asp:ListItem>
                        <asp:ListItem>马伟明</asp:ListItem>
                        <asp:ListItem>王子文</asp:ListItem>
                        <asp:ListItem>黄渤</asp:ListItem>
                        <asp:ListItem>王宝强</asp:ListItem>
                        <asp:ListItem>张群英</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td>
                    <div style="text-align:center;"><asp:Image ID="Image1" runat="server" ImageUrl="~/Contents/Pages/HistogramOnlineInquiry.aspx" /></div>
                </td>
            </tr>
            <tr>
                <td>
            
                    <asp:Button ID="Btn_Vote" runat="server" CssClass="btn" Text="投票" onclick="Btn_Vote_Click" />
                    <asp:Button ID="Btn_Look" runat="server" CssClass="btn" Text="查看" 
                        onclick="Btn_Look_Click" />
                </td>
                <td>
                </td>
            </tr>
        </table>
        <asp:Label ID="Lab_View" runat="server"></asp:Label>
    </div>
</div>
</form>
</asp:Content>


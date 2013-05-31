<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>注册新用户</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="span12 offset4">
        <table class="table" style="width:40%;">
            <tr>
                <td colspan="3">
                    注册新用户</td>
            </tr>
            <tr>
                <td>
                    用户名:</td>
                <td>
                    <asp:TextBox ID="Text_Name" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="Text_Name" Display="Dynamic" ErrorMessage="请输入用户名"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    密码:</td>
                <td>
                    <asp:TextBox ID="Text_Pwd" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="Text_Pwd" Display="Dynamic" ErrorMessage="请输入用户密码"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    重复密码:</td>
                <td>
                    <asp:TextBox ID="Text_RePwd" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                        ControlToCompare="Text_Pwd" ControlToValidate="Text_RePwd" Display="Dynamic" 
                        ErrorMessage="密码输入不一致"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>
                    注册邮箱:</td>
                <td>
                    <asp:TextBox ID="Text_Mail" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    性别:</td>
                <td>
                    <asp:RadioButton ID="RadioButton1" runat="server" GroupName="Sex" Text="男" />
                    <asp:RadioButton ID="RadioButton2" runat="server" GroupName="Sex" Text="女" />
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    出生日期:</td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:Button ID="Btn_Reg" CssClass="btn" runat="server" onclick="Btn_Reg_Click" Text="注册" />
                    <asp:Button ID="Button2" CssClass="btn" runat="server" Text="重置" />
                </td>
                <td>
                    &nbsp;</td>
            </tr>                                                            
        </table>
    </div>
    </form>
</body>
</html>

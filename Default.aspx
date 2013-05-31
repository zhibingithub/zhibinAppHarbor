<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<form action="#">
        <div class="hero-unit">
          <h1>Heading</h1>
          <p>Tagline</p>
          <p>
            <a class="btn btn-primary btn-large">
              Learn more
            </a>
          </p>
        </div>
        <div class="row">
            <div class="span3">
                <ul class="nav nav-pills nav-stacked">
                      <li class="nav-header"></li>
                      <li class="active"><a href="#">最新<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">ASP.NET<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">Python<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">Hadoop<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">OpenStack<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">虚拟化<i class="icon-chevron-right pull-right"></i></a></li>
                      <li><a href="#">云计算<i class="icon-chevron-right pull-right"></i></a></li>
                </ul>
            </div>
            <div class="span8">
                <p>用户名 : admin <br /> 密码 : admin</p>
            </div>
            
        </div>        
</form>           
</asp:Content>


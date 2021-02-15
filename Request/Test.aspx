<%@ Page Title="" Language="C#" MasterPageFile="~/TrustBank.master" AutoEventWireup="true"
    CodeFile="Test.aspx.cs" Inherits="Test" %>

<%@ Register src="CommonControl.ascx" tagname="CommonControl" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Test
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div class="form-group">
        <label for="inputEmail3" class="col-sm-2 control-label">
            Email</label><uc1:CommonControl ID="CommonControl1" runat="server" />
&nbsp;<div class="col-sm-10">
            <input type="email" class="form-control" id="inputEmail3" placeholder="Email">
        </div>
    </div>
    <div class="form-group">
        <label for="inputEmail3" class="col-sm-2 control-label">
            Passport</label>
        <div class="col-sm-10">
            <input type="email" class="form-control" id="Email1" placeholder="Email">
        </div>
    </div>
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
</asp:Content>

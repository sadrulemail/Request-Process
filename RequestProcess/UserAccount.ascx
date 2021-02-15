<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserAccount.ascx.cs" Inherits="RequestProcess.UserAccount" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<link href="CSS/EMP.css" rel="stylesheet" type="text/css" />
<asp:Label ID="lblUserID" runat="server" Text="" CssClass="UserLabel"></asp:Label>
<asp:HoverMenuExtender runat="server" ID="HoverMenuExtenderlblUserID" DynamicControlID="UserInfo"
    DynamicServiceMethod="getUserInfo" DynamicServicePath="UserAccountService.asmx" TargetControlID="lblUserID"
    PopupControlID="UserInfo" CacheDynamicResults="true" HoverDelay="500">
</asp:HoverMenuExtender>

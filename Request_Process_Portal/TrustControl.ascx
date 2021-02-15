<%@ Control Language="C#" AutoEventWireup="true" Inherits="TrustControl" 
    CodeFile="TrustControl.ascx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:ToolkitScriptManager 
    ID="TrustScriptManager1" 
    runat="server" 
    CombineScripts="true" 
    ScriptMode="Release"
    CompositeScript-ScriptMode="Release"
    AsyncPostBackTimeout="360000">
</asp:ToolkitScriptManager>
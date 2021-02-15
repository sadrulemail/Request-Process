<%@ Page Title="" Language="C#" MasterPageFile="~/TrustBank.master" AutoEventWireup="true"
    Inherits="RequestProcess.Request_Print" CodeBehind="Request_Print.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Trust Bank eService Request Print</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Trust Bank eService Request Print
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:Panel ID="PanelError" runat="server">
        <div class="col-md-2 text-center">
            <img src="Images/service-icon.png" width="128" height="128" />
        </div>
        <div class="">
            <asp:Literal ID="lblErrorMsg" runat="server"></asp:Literal>
        </div>
    </asp:Panel>
    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server" EnableCaching="false">
        <Report FileName="Request_Report.rpt">
            <DataSources>
                <CR:DataSourceRef DataSourceID="SqlDataSource1" TableName="s_Service_Req_Print;1" />
            </DataSources>
            <Parameters>
            </Parameters>
        </Report>
    </CR:CrystalReportSource>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" OnAfterRender="CrystalReportViewer1_AfterRender"
        AutoDataBind="true" ReportSourceID="CrystalReportSource1" DisplayToolbar="False"
        EnableParameterPrompt="False" EnableDatabaseLogonPrompt="False" Visible="true" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
        SelectCommand="s_Service_Req_Print" SelectCommandType="StoredProcedure" EnableCaching="false"
        OnSelected="SqlDataSource1_Selected1">
        <SelectParameters>
            <asp:QueryStringParameter Name="ReqID" QueryStringField="reqid" Type="String" />
            <asp:QueryStringParameter Name="Email" QueryStringField="email" Type="String" />
            <asp:QueryStringParameter Name="KeyCode" QueryStringField="keycode" Type="String" />
            <asp:Parameter Direction="InputOutput" Name="Msg" Type="String" DefaultValue=" "
                Size="255" />
            <asp:Parameter Direction="InputOutput" Name="Done" Type="Boolean" DefaultValue="false" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

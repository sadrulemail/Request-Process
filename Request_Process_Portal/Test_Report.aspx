<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" 
    CodeFile="Test_Report.aspx.cs" Inherits="Test_Report" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
Test_Report
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
<uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
                <Report FileName="Reports\CR_BR1.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="TextBox1" ConvertEmptyStringToNull="False" 
                        DefaultValue="Test" Name="TestParameter" PropertyName="Text" ReportName="" />
                    </Parameters>
                </Report>
            </CR:CrystalReportSource>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Button" />
            <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" ReportSourceID="CrystalReportSource1"
                AutoDataBind="true" ShowAllPageIds="True" EnableDrillDown="False" DisplayStatusbar="false" 
                HasCrystalLogo="False" ToolPanelView="None" 
                HasToggleGroupTreeButton="False" HasDrilldownTabs="False" 
                HasToggleParameterPanelButton="False" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
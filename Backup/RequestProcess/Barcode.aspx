<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Barcode.aspx.cs" Inherits="RequestProcess.Barcode1" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
            TypeName="RequestProcess.DataSetBarcodeTableAdapters.BarcodeTableAdapter" 
            DeleteMethod="Delete" UpdateMethod="UpdateQuery">
            <DeleteParameters>
                <asp:Parameter Name="Original_ID" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Barcode" Type="String" />
                <asp:Parameter Name="Original_ID" Type="String" />
                <asp:Parameter Name="ID" Type="String" />
            </UpdateParameters>
        </asp:ObjectDataSource>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
            OnAfterRender="CrystalReportViewer1_AfterRender" GroupTreeImagesFolderUrl=""
            Height="50px" ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl=""
            ToolPanelWidth="200px" Width="350px" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server" EnableCaching="False">
            <Report FileName="Barcode2.rpt">
                <DataSources>
                    <CR:DataSourceRef DataSourceID="ObjectDataSource1" TableName="Barcode" />
                </DataSources>
                <Parameters>
                    <CR:Parameter Name="Barcode" DefaultValue="123" />
                    <CR:Parameter Name="Barcode1" DefaultValue="123" />
                    <CR:Parameter Name="Barcode2" DefaultValue="123" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
    </div>
    </form>
</body>
</html>

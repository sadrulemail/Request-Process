<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SMS_Exclude.aspx.cs" Inherits="SMS_Exclude" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    SMS Alert Exclude
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <table class="Panel1">
                <tr>
                    <td class="bold">
                        A/C Number
                    </td>
                    <td>
                        <asp:TextBox ID="txtAcc" MaxLength="15" Font-Size="Large" Font-Bold="true" Width="200px"
                            runat="server" AutoPostBack="True" ontextchanged="txtAcc_TextChanged"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="reqAcc" ControlToValidate="txtAcc" ErrorMessage="*" ForeColor="Red" Font-Bold="true"></asp:RequiredFieldValidator>
                        <asp:Label ID="lblAccName" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="bold">
                        Remarks
                    </td>
                    <td>
                        <asp:TextBox ID="txtRemarks" MaxLength="255" runat="server" Width="300px"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="reqRemarks" ControlToValidate="txtRemarks" ErrorMessage="*" ForeColor="Red" Font-Bold="true"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="cmdOK" runat="server" Text="Exclude" onclick="cmdOK_Click" />
                        <asp:ConfirmButtonExtender runat="server" ID="con1" TargetControlID="cmdOK" ConfirmText="Do you want to Exclude SMS Alert?"></asp:ConfirmButtonExtender>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DynamicLayout="false" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="10">
        <ProgressTemplate>
            <div class="TransparentGrayBackground">
            </div>
            <asp:Image ID="Image1" runat="server" alt="" ImageUrl="~/Images/processing.gif" CssClass="LoadingImage"
                Width="214" Height="138" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:AlwaysVisibleControlExtender ID="UpdateProgress1_AlwaysVisibleControlExtender"
        runat="server" Enabled="True" HorizontalSide="Center" TargetControlID="Image1"
        UseAnimation="false" VerticalSide="Middle">
    </asp:AlwaysVisibleControlExtender>
</asp:Content>

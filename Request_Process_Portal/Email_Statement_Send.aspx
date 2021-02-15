<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Email_Statement_Send.aspx.cs" Inherits="Email_Statement_Send" Culture="en-NZ"
    UICulture="en-NZ" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Send Account Statement to Email
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <table>
                <tr>
                    <td valign="top">
                        <table class="Panel1">
                            <tr>
                                <td class="bold">
                                    Account
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAcc" MaxLength="15" Font-Size="Medium" Width="200px" runat="server"
                                        placeholder="account number" onfocus="select()" OnTextChanged="txtAcc_TextChanged1"
                                        CausesValidation="false" AutoPostBack="true"></asp:TextBox>
                                    <asp:Button ID="cmdShow" runat="server" Text="Show" OnClick="cmdShow_Click" />
                                    <asp:Label ID="lblAccName" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="bold">
                                    To Email
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmail" MaxLength="255" runat="server" Width="300px" placeholder="email address"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="bold">
                                    Statement Date
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDateFrom" MaxLength="10" runat="server" Width="85px" CssClass="Date"></asp:TextBox>
                                    to
                                    <asp:TextBox ID="txtDateTo" MaxLength="10" runat="server" Width="85px" CssClass="Date"></asp:TextBox>
                                    <asp:DropDownList ID="dboDataType" BackColor="#DBDBDB" AutoPostBack="true" 
                                        runat="server" onselectedindexchanged="dboDataType_SelectedIndexChanged">
                                        <asp:ListItem Text="Last 7 Days" Value="7D"></asp:ListItem>
                                        <asp:ListItem Text="Last 15 Days" Value="15D"></asp:ListItem>
                                        <asp:ListItem Text="Last 1 Month" Value="1M"></asp:ListItem>
                                        <asp:ListItem Text="Last 3 Months" Value="3M"></asp:ListItem>
                                        <asp:ListItem Text="Last 6 Months" Value="6M"></asp:ListItem>
                                        <asp:ListItem Text="Last 1 Year" Value="1Y"></asp:ListItem>
                                        <asp:ListItem Text="Half Yearly Statement" Value="1H"></asp:ListItem>
                                        
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="bold">
                                    Reference
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRemarks" MaxLength="255" runat="server" Width="300px" placeholder="remarks/reason"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button ID="cmdOK" runat="server" Text="Send Statement Now" OnClick="cmdOK_Click"
                                        Height="30px" Enabled="false" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top" style="padding-left: 10px">
                        <asp:DetailsView ID="DetailsView3" runat="server" AutoGenerateRows="false" BackColor="White"
                            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="AccountNo"
                            DataSourceID="SqlDataSource3" ForeColor="Black" GridLines="Vertical" CssClass="Grid hide-blank-detailsview"
                            OnDataBound="DetailsView3_DataBound">
                            <Fields>
                                <asp:TemplateField HeaderText="A/C Name" ShowHeader="false" ItemStyle-CssClass="donothide">
                                    <ItemTemplate>
                                        <%# Eval("acName") %>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="true" Font-Size="Medium" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type">
                                    <ItemTemplate>
                                        <%# Eval("glhead","<div width:'100%'>{0}</div>")%>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="width100" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" SortExpression="Status">
                                    <ItemTemplate>
                                        <%# Eval("Status") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email(s)" SortExpression="Email">
                                    <ItemTemplate>
                                        <%# Eval("Email").ToString().Replace(";","<br>") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="AutoActivated" HeaderText="Auto Added" HeaderStyle-Wrap="false"
                                    Visible="false"></asp:BoundField>
                            </Fields>
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#FAFAD2" VerticalAlign="Top" />
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SMSConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:SMSConnectionString.ProviderName %>" SelectCommand="s_EmailNotification_AccountInfo"
                            SelectCommandType="StoredProcedure" OnSelected="SqlDataSource3_Selected">
                            <SelectParameters>
                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                <asp:QueryStringParameter Name="AccountNo" QueryStringField="acc" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
            <br />
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

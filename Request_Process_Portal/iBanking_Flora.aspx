<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="iBanking_Flora.aspx.cs" Inherits="iBanking_Flora" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    iBanking Flora Search
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:Panel runat="server" ID="panelAddItem" CssClass="Panel1" Style="padding: 2px 7px;
                margin-bottom: 10px; display: inline-table">
                <table>
                    <tr>
                        <td style="margin: 5px; font-weight: bold">
                            Account/Email/Contact:
                        </td>
                        <td style="padding-left: 10px;">
                            <asp:TextBox ID="txtAccNo" runat="server" Width="400px" MaxLength="255" Font-Size="Large"
                                onfocus="this.select()"></asp:TextBox>
                        </td>
                        <td style="margin: 5x; padding-left: 10px;">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" Width="90px" Height="30px"
                                CommandName="Select" OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="false" CssClass="Grid" AllowSorting="True"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="6" DataSourceID="SqlDataSource1" ForeColor="Black"
                GridLines="Vertical" OnRowDataBound="GridView1_RowDataBound">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="AccountNo" HeaderText="Account No" SortExpression="AccountNo">
                        <ItemStyle Font-Bold="true" Wrap="false" />
                    </asp:BoundField>
                    <asp:BoundField DataField="AcName" HeaderText="Account Name" SortExpression="AcName">
                    </asp:BoundField>
                    <asp:BoundField DataField="email_id" HeaderText="Login ID" SortExpression="email_id" />
                    <asp:BoundField DataField="contact" HeaderText="Contact" SortExpression="contact" />
                    <asp:BoundField DataField="OTPOption" HeaderText="OTP" SortExpression="OTPOption">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Fund Trans Limit" SortExpression="FundTrf_limit">
                        <ItemTemplate>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("FundTrf_limit"))%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Utility Bill Limit" SortExpression="Utilitybill_limit">
                        <ItemTemplate>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Utilitybill_limit"))%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Daily Limit" SortExpression="daily_limit">
                        <ItemTemplate>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("daily_limit"))%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Monthly Limit" SortExpression="monthly_limit">
                        <ItemTemplate>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("monthly_limit"))%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="no_of_trn" HeaderText="No of Trans" SortExpression="no_of_trn"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="no_of_mtrn" HeaderText="No of Monthly Trans" SortExpression="no_of_mtrn"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Status" HeaderText="Acc Status" SortExpression="Status"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ActiveYN" HeaderText="Active" SortExpression="ActiveYN"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TrfAcType" HeaderText="Trans Type" SortExpression="TrfAcType"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ChargeableYN" HeaderText="Charge" SortExpression="ChargeableYN"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataTemplate>
                    No Data Found.
                </EmptyDataTemplate>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="s_Flora_iBanking_Search" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Search" QueryStringField="s" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <div style="padding: 10px 0 50px 0">
                <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
            </div>
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

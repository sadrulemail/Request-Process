<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SignatureVerifyPending.aspx.cs" Inherits="SignatureVerifyPending" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc4" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Signature Verification Pending
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:Panel runat="server" ID="panelAddItem" CssClass="Panel1" Style="padding: 6px;
                margin-bottom: 20px; display: inline-block" Min-Height="120px">
                <table>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtFilter" runat="server" Width="250px" Watermark="Enter text to filter"></asp:TextBox>
                        </td>
                        <td style="padding-left: 15px">
                            Branch
                        </td>
                        <td style="">
                            <asp:DropDownList ID="ddlBranch" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceBranch"
                                DataTextField="BranchName" DataValueField="BranchID" AutoPostBack="True" CausesValidation="false"
                                OnDataBound="ddlBranch_DataBound">
                                <asp:ListItem Text="All Branches" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td style="padding-left: 2px">
                            <asp:Button ID="Button1" runat="server" Text="Search" Width="70px" CausesValidation="false" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:GridView ID="grdvAccountList" runat="server" DataKeyNames="SL" AutoGenerateColumns="False"
                DataSourceID="SqlDataSourceAddAcc" CssClass="Grid" BorderStyle="None" BackColor="White"
                BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="true" PagerSettings-Position="TopAndBottom"
                PageSize="10" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="20">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblSL" runat="server" Text='<%# Eval("SL") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Request ID" SortExpression="ReqID">
                        <ItemTemplate>
                            <a href='iBankingRequestShow.aspx?reqid=<%# Eval("ReqID") %>' title="View iBanking Request"
                                target="_blank">
                                <%# Eval("ReqID")%>
                            </a>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Font-Bold="true" Wrap="false" />
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Account No" DataField="Accountno" SortExpression="Accountno"
                        ItemStyle-Wrap="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Requested By" DataField="Fullname" SortExpression="Fullname"
                        ItemStyle-Wrap="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Branch" SortExpression="Branch ID">
                        <ItemTemplate>
                            <uc4:Branch ID="BranchControl1" runat="server" BranchID='<%# Eval("BranchID") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email & Mobile" SortExpression="Email">
                        <ItemTemplate>
                            <%# Eval("Email","<div>{0}</div>") %>
                            <%# Eval("MobileNo", "<div>+{0}</div>")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ReqType" HeaderText="Req Type" SortExpression="ReqType"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Request On" SortExpression="ReqDT">
                        <ItemTemplate>
                            <div title='<%# Eval("ReqDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("ReqDT"))%><br />
                                <time class="timeago" datetime='<%# Eval("ReqDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                        <ItemStyle ForeColor="Gray" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Attachment Submit On" SortExpression="AttachmentSubmitDT">
                        <ItemTemplate>
                            <div title='<%# Eval("AttachmentSubmitDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("AttachmentSubmitDT"))%><br />
                                <time class="timeago" datetime='<%# Eval("AttachmentSubmitDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Attach By" SortExpression="SubmitBy">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("SubmitBy") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    No Signature Verification is Pending.
                </EmptyDataTemplate>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                <FooterStyle BackColor="#CCCC99" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:HiddenField ID="hidSlNo" runat="server" Value="" />
            <br />
            <asp:Label ID="lblStatus" runat="server" Text="" Font-Size="Small"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSourceAddAcc" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="s_iBanking_Signature_Verify_Pending" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSourceAddAcc_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtFilter" Name="Filter" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                    <asp:ControlParameter ControlID="ddlBranch" Name="BranchID" PropertyName="SelectedValue"
                        DefaultValue="-1" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="SELECT [BranchID], [BranchName] FROM [TblUserDB].[dbo].[ViewBranchOnly] ORDER BY BranchName">
            </asp:SqlDataSource>
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

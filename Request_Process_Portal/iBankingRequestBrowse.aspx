<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    Inherits="RequestShowAtHO" CodeFile="iBankingRequestBrowse.aspx.cs" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    iBanking Service Request Browse
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
                        <td style="padding-left: 15px;">
                            Customer Submitted Date
                        </td>
                        <td>
                            <asp:TextBox ID="txtDateFrom" runat="server" Width="80px" CssClass="Watermark Date"
                                Watermark="dd/mm/yyyy" AutoPostBack="true"></asp:TextBox>
                        </td>
                        <td>
                            to
                        </td>
                        <td>
                            <asp:TextBox ID="txtDateTo" runat="server" Width="80px" CssClass="Watermark Date"
                                Watermark="dd/mm/yyyy" AutoPostBack="true"></asp:TextBox>
                        </td>
                        <td style="padding-left: 15px">
                            Request Status
                        </td>
                        <td style="">
                            <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceStatus"
                                DataTextField="Status_Name" DataValueField="Status_Types" AutoPostBack="True"
                                CausesValidation="false">
                                <asp:ListItem Text="All Verified" Value="-2"></asp:ListItem>
                                <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <%--<td style="margin: 5x; padding-left: 10px;">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100px" Height="35px"
                               CausesValidation="false" onclick="btnSearch_Click"  />
                        </td>--%>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtRequestID" runat="server" Width="175px" Watermark="Request ID"></asp:TextBox>
                        </td>
                        <td style="padding-left: 2px">
                            <asp:Button ID="Button1" runat="server" Text="Search" Width="70px" CausesValidation="false"
                                OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <%--  <asp:Panel runat="server" ID="panel2" CssClass="group">
                <h4>
                    iBanking Service Request Account No List</h4>--%>
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
                    <%--  <asp:TemplateField HeaderText="#" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%#Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Request ID" SortExpression="ReqID">
                        <ItemTemplate>
                            <a href='iBankingRequestShow.aspx?reqid=<%# Eval("ReqID") %>' title="View iBanking Request"
                                target="_blank">
                                <%# Eval("ReqID")%></a></ItemTemplate>
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
                    <asp:BoundField DataField="Status_Name" HeaderText="Status" SortExpression="Status_Name">
                        <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
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
                    <asp:TemplateField HeaderText="Last Modify" SortExpression="LastModified">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("LastModifiedBy") %>' />
                            <div title='<%# Eval("LastModified", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("LastModified"))%><br />
                                <time class="timeago" datetime='<%# Eval("LastModified","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    No Data Found.
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
            <%-- </asp:Panel>--%>
            <asp:HiddenField ID="hidSlNo" runat="server" Value="" />
            <br />
            <asp:Label ID="lblStatus" runat="server" Text="" Font-Size="Small"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSourceAddAcc" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="s_iBanking_Req_Browse" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceAddAcc_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtRequestID" Name="ReqID" PropertyName="Text" Type="Int64"
                        DefaultValue="-1" Size="20" />
                    <asp:ControlParameter ControlID="txtFilter" Name="Filter" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                    <asp:ControlParameter ControlID="ddlStatus" Name="ReqStatus" PropertyName="SelectedValue"
                        DefaultValue="-1" Type="Int32" />
                    <asp:ControlParameter ControlID="txtDateFrom" Name="DateFrom" DefaultValue='01/01/1900'
                        PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtDateTo" Name="DateTo" DefaultValue='01/01/1900'
                        PropertyName="Text" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                EnableCaching="true" CacheDuration="600" SelectCommand="SELECT Status_Types, Status_Name FROM [Request_Process].[dbo].[Status_Types] WHERE ho_br IN ('HO','BR') AND Active = 1 ORDER BY ordercol">
                <%-- <SelectParameters>
                    <asp:ControlParameter ControlID="hiddenFieldBranch" Name="ho_br" PropertyName="Value" />
                </SelectParameters>--%>
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

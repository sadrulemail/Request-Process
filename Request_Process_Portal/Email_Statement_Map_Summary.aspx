<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Email_Statement_Map_Summary.aspx.cs"
    Inherits="Email_Statement_Map_Summary" EnableViewState="false" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    eStatement Email Mapping Summary
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:Panel runat="server" ID="panelAddItem" CssClass="Panel1" Style="padding: 6px; margin-bottom: 20px; display: inline-block"
                Min-Height="120px">
                <table>
                    <tr>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource4"
                                DataTextField="classname" DataValueField="classcode"
                                AppendDataBoundItems="true">
                                <asp:ListItem Text="All Types" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:Florabank_OnlineConnectionString %>"
                                SelectCommand="SELECT classcode, classname FROM aclass With (nolock) ORDER BY classname"></asp:SqlDataSource>
                        </td>
                        <td style="padding-left: 10px">
                            <asp:Button ID="Button1" runat="server" Text="Search" Width="70px" CausesValidation="false"
                                OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                            ConnectionString="<%$ ConnectionStrings:SMSConnectionString %>"
                            SelectCommand="s_Email_eStatement_Error_Summary" SelectCommandType="StoredProcedure"
                            OnSelected="SqlDataSource1_Selected">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList2" Name="ClassCode" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowFooter="true"
                            DataSourceID="SqlDataSource1" CssClass="Grid" BorderStyle="None" BackColor="White"
                            BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                            AllowPaging="false" AllowSorting="True"
                            PageSize="25" OnRowDataBound="GridView1_RowDataBound"
                            OnRowCommand="GridView1_RowCommand" OnDataBound="GridView1_DataBound">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="Branch Code" SortExpression="branch_code">
                                    <ItemTemplate>
                                        <%# Eval("branch_code")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Branch" SortExpression="BranchName">
                                    <ItemTemplate>
                                        <%# Eval("BranchName")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Total" DataField="Total" 
                                    SortExpression="Total" ItemStyle-HorizontalAlign="Right" 
                                    DataFormatString="{0:N0}"></asp:BoundField>
                                <asp:BoundField HeaderText="Authorize Pending" DataField="TotalAuthorizePending" 
                                    SortExpression="TotalAuthorizePending" ItemStyle-HorizontalAlign="Right" 
                                    DataFormatString="{0:N0}"></asp:BoundField>
                                <asp:BoundField HeaderText="No Email Address" DataField="TotalNoEmail" 
                                    SortExpression="TotalNoEmail" ItemStyle-HorizontalAlign="Right" 
                                    DataFormatString="{0:N0}"></asp:BoundField>
                                <asp:BoundField HeaderText="Total Authorized" DataField="TotalAuthorized" 
                                    SortExpression="TotalAuthorized" ItemStyle-HorizontalAlign="Right" 
                                    DataFormatString="{0:N0}"></asp:BoundField>
                            </Columns>
                            <EmptyDataTemplate>
                                No Data Found.
                            </EmptyDataTemplate>
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                            <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast"
                                PageButtonCount="20" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                            <FooterStyle BackColor="#CCCC99" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                        </asp:GridView>
                        <asp:Label ID="lblStatus" runat="server" Font-Size="Small"></asp:Label>

                    
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


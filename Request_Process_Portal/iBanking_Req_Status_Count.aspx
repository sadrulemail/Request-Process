<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="iBanking_Req_Status_Count.aspx.cs" Inherits="iBanking_Req_Status_Count" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    iBanking Service Request Browse
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:Panel runat="server" ID="panelAddItem" Style="margin-bottom: 10px">
                <table>
                    <tr>
                        <td>
                            <table class="Panel1" style="padding: 6px; display: inline-block">
                                <tr>
                                    <td>
                                        Date
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
                                    <td style="padding-left: 10px;">
                                        Branch
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="cmdBranch" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceBranch"
                                            DataTextField="BranchName" DataValueField="BranchID" AutoPostBack="true">
                                            <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="All Branch" Value="-1"></asp:ListItem>
                                            <asp:ListItem Text="All Branch except Head Office" Value="-2"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                            SelectCommand="SELECT * FROM [ViewBranchOnly] ORDER BY [BranchName]"></asp:SqlDataSource>
                                    </td>
                                    <td style="padding-left: 10px">
                                        <asp:Button ID="Button1" runat="server" Text="Search" Width="70px" CausesValidation="false" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <asp:LinkButton ID="cmdPreviousDay" runat="server" OnClick="cmdPreviousDay_Click"
                                ToolTip="Previous Day" data-toggle='tooltip' CssClass="button-round"><img src="Images/Previous.gif" width="32px" height="32px" border="0" /></asp:LinkButton>
                            <asp:LinkButton ID="cmdNextDay" runat="server" OnClick="cmdNextDay_Click" ToolTip="Next Day"
                                data-toggle='tooltip' CssClass="button-round"><img src="Images/Next.gif" width="32px" height="32px" border="0" /></asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:GridView ID="grdiBanking_Req_Status_Count" runat="server" DataKeyNames="ByEmp"
                AutoGenerateColumns="False" DataSourceID="SqlDataSourceiBanking_Req_Status_Count"
                CssClass="Grid" BorderStyle="None" BackColor="White" BorderColor="#DEDFDE" BorderWidth="1px"
                CellPadding="4" ForeColor="Black" GridLines="Vertical" AllowPaging="false" AllowSorting="true"
                ShowFooter="true" OnDataBound="grdiBanking_Req_Status_Count_DataBound">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="By Emp" SortExpression="ByEmp">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("ByEmp")%>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Emp Name" DataField="EmpName" SortExpression="EmpName"
                        ItemStyle-Wrap="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Desig" DataField="DesigName" SortExpression="DesigName"
                        ItemStyle-Wrap="false">
                        <ItemStyle Wrap="False" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Branch" SortExpression="Branch_BranchID">
                        <ItemTemplate>
                            <uc4:Branch ID="BranchControl1" runat="server" BranchID='<%# Eval("Branch_BranchID") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Completed" DataField="Completed" SortExpression="Completed">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Reject by IT Division" DataField="Reject by IT Division"
                        SortExpression="Reject by IT Division">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Signature Verified" DataField="Signature Verified" SortExpression="Signature Verified">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Verified by Branch" DataField="Verified by Branch" SortExpression="Verified by Branch">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Signature Not Matched" DataField="Signature Not Matched"
                        SortExpression="Signature Not Matched">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Declined by Branch" DataField="Declined by Branch" SortExpression="Declined by Branch">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Total" DataField="Total" SortExpression="Total">
                        <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataTemplate>
                    No Data Found.
                </EmptyDataTemplate>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                <FooterStyle BackColor="#CCCC99" HorizontalAlign="Center" Font-Bold="true" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:HiddenField ID="hidSlNo" runat="server" Value="" />
            <br />
            <asp:Label ID="lblStatus" runat="server" Text="" Font-Size="Small"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSourceiBanking_Req_Status_Count" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="s_iBanking_Req_Status_Count" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtDateFrom" Name="DateFrom" DefaultValue='01/01/1900'
                        PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtDateTo" Name="DateTo" DefaultValue='01/01/1900'
                        PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="cmdBranch" Name="BranchID" DefaultValue='1' PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
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

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SMS_Exclude_Browse.aspx.cs" Inherits="SMS_Exclude_Browse" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Browse SMS Alert Exclude
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
                            <asp:TextBox ID="txtFilter" runat="server" Width="150px" Watermark="Enter A/C to filter"></asp:TextBox>
                        </td>
                        <td style="padding-left: 15px;">
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
                        <td style="padding-left: 2px">
                            <asp:Button ID="Button1" runat="server" Text="Search" Width="70px" CausesValidation="false"
                                OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:GridView ID="grdvExcludeList" runat="server" DataKeyNames="ExcludeID" AutoGenerateColumns="False"
                DataSourceID="SqlDataSourceExcludeAcc" CssClass="Grid" BorderStyle="None" BackColor="White"
                BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="true" PagerSettings-Position="TopAndBottom"
                PageSize="25" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="20">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblSL" runat="server" Text='<%# Eval("ExcludeID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Account No" DataField="AccountNo" SortExpression="AccountNo"
                        ItemStyle-Wrap="false" ReadOnly="true">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Exclude By" SortExpression="ExcludeBy">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("ExcludeBy") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Exclude On" SortExpression="ExcludeDT">
                        <ItemTemplate>
                            <div title='<%# Eval("ExcludeDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("ExcludeDT"))%><br />
                                <time class="timeago" datetime='<%# Eval("ExcludeDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                        <ItemStyle ForeColor="Gray" />
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Remarks" DataField="Remarks" SortExpression="Remarks"
                        ItemStyle-Wrap="false" ReadOnly="true">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="BtnDelete" runat="server" CommandName="Edit" ToolTip="Delete">
                                <img src="Images/cross.png" width="20" height="20" />
                            </asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox runat="server" ID="cmdRemarks" Width="300px" MaxLength="255" placeholder="delete reason" Text='<%# Bind("Reason") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ID="req1" ControlToValidate="cmdRemarks"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            <br />
                            <asp:Button ID="BtnDelete" runat="server" CommandName="Update" Text="Delete"></asp:Button>
                            <asp:ConfirmButtonExtender runat="server" ID="BtnDeleteewe" ConfirmText="Do you want to Delete?"
                                TargetControlID="BtnDelete">
                            </asp:ConfirmButtonExtender>
                            <asp:LinkButton ID="lnkCalcel" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="false">
                            </asp:LinkButton>
                        </EditItemTemplate>
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
            <asp:Label ID="lblStatus" runat="server" Text="" Font-Size="Small"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSourceExcludeAcc" runat="server" ConnectionString="<%$ ConnectionStrings:SMSConnectionString %>"
                SelectCommand="s_SMS_Exclude_List" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceExcludeAcc_Selected"
                UpdateCommand="s_SMS_Exclude_List_Delete" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtFilter" Name="Filter" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                    <asp:ControlParameter ControlID="txtDateFrom" Name="DateFrom" DefaultValue='01/01/1900'
                        PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtDateTo" Name="DateTo" DefaultValue='01/01/1900'
                        PropertyName="Text" Type="DateTime" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ExcludeID" />
                    <asp:Parameter Name="Msg" Direction="InputOutput" Size="255" DefaultValue="*" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Reason" Size="255" />
                </UpdateParameters>
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

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    Inherits="RequestShow" CodeFile="RequestShow.aspx.cs" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    iBanking Service Request Verification
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <%--asp:Panel runat="server" ID="panelAddItem" CssClass="group"  Width="600px" Min-Height="120px">
                <h4>iBanking Service Request ID Search</h4>--%>
            <%-- <fieldset style="width: 70%;">--%>
            <%-- <legend style="font-weight: bold;">iBanking Service Request User Information Search
                    by Request ID </legend>--%>
            <asp:Panel runat="server" ID="panelAddItem" CssClass="Panel1" Width="530px" Style="padding: 6px;
                margin-bottom: 20px" Min-Height="120px">
                <table>
                    <tr>
                        <td style="margin: 5px; font-weight: bold">
                            Service Request ID
                        </td>
                        <td style="padding-left: 10px;">
                            <asp:TextBox ID="txtRequestID" runat="server" CssClass="Center" Width="250px" Font-Size="X-Large"></asp:TextBox>
                        </td>
                        <td style="margin: 5x; padding-left: 10px;">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100px" Height="35px"
                                CommandName="Select" OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <%--  </fieldset>--%>
            <asp:Panel runat="server" ID="panel1" CssClass="group" Width="600px" Min-Height="120px">
                <h4>
                    Customer Information</h4>
                <%-- <div class="panel-heading">
                My Personal Information</div>--%>
                <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" CssClass="Grid"
                    BorderColor="#DEDFDE" BorderStyle="None" ForeColor="Black" GridLines="Vertical"
                    AutoGenerateRows="False" DataKeyNames="ReqID" DataSourceID="SqlDataSource1" BorderWidth="1px"
                    CellPadding="4">
                    <Fields>
                        <asp:TemplateField HeaderText="Email" ShowHeader="true">
                            <ItemTemplate>
                                <div class="row">
                                    <div class="col-sm-9">
                                        <div class="bold form-control-static">
                                            <%# Eval("Email") %>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <div class="row">
                                    <div class="col-sm-9">
                                        <div class="form-control-static">
                                            <%# Eval("Title") %>
                                            <%# Eval("FirstName")%>
                                            <%# Eval("MiddleName")%>
                                            <%# Eval("LastName")%>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mobile No." ShowHeader="true">
                            <ItemTemplate>
                                <div class="row">
                                    <div class="col-sm-9">
                                        <div class="form-control-static">
                                            <%# Eval("MobileNo","+{0}")%>
                                            <%--  <%# (Eval("MobileVarified").ToString() == "True") ? "<img src='Images/tick2.png' width='16' height='16' title='verified'>" : ""%>--%>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <AlternatingRowStyle BackColor="White" />
                    <EditRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <EmptyDataTemplate>
                        No Data Found.
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#CCCC99" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#F7F7DE" />
                </asp:DetailsView>
            </asp:Panel>
            <%--<asp:Panel ID="PanelLinkedAccount" runat="server" Visible="true">
                <div class="panel panel-success">
                    <div class="table-hover">--%>
            <%--<div class="panel-heading">
                            iBanking Service Request Account No List
                        </div>--%>
            <asp:Panel runat="server" ID="panel2" CssClass="group">
                <h4>
                    iBanking Service Request Account No List</h4>
                <asp:GridView ID="grdvAccountList" runat="server" DataKeyNames="SL" AutoGenerateColumns="False"
                    DataSourceID="SqlDataSourceAddAcc" CssClass="Grid" BorderStyle="None" BackColor="White"
                    BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                    OnRowCommand="grdvAccountList_RowCommand" OnSelectedIndexChanged="grdvAccountList_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblSL" runat="server" Text='<%# Eval("SL") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="#" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Account No" DataField="Accountno" ItemStyle-Wrap="false">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Account Name" DataField="acname" ItemStyle-Wrap="false">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="AlllowFund" HeaderText="Allow Fund" ItemStyle-HorizontalAlign="Center"
                            SortExpression="AlllowFund">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:CheckBoxField>
                        <asp:TemplateField HeaderText="Transfer limit per Trans">
                            <ItemTemplate>
                                <asp:Label ID="lblTransferLimit" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("TransferLimit", "{0:N0}"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Utility Limit Per Trans">
                            <ItemTemplate>
                                <asp:Label ID="lblUtilityLimit" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("UtilityLimit", "{0:N0}"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Daily Transaction Limit">
                            <ItemTemplate>
                                <asp:Label ID="lblDailyTrans" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("DailyTransactionLimit", "{0:N0}"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Monthly Transaction Limit">
                            <ItemTemplate>
                                <asp:Label ID="lblMonthly" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("MonthlyTransactionLimit", "{0:N0}"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="No. of Trans Per Day">
                            <ItemTemplate>
                                <asp:Label ID="lblPerDayTrans" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("PerDayNoOfTransaction", "{0:N0}"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="No. of Trans Per Month">
                            <ItemTemplate>
                                <asp:Label ID="lblPerMonthTrans" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("PerMonthNoOfTransaction", "{0:N0}"))%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ReqType" HeaderText="Request Type" ItemStyle-HorizontalAlign="Center">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Status_Name" HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="lnkDelete" CausesValidation="False" CommandName="Select"
                                    CommandArgument='<%# Eval("Status") %>'>Select</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#F7F7DE" />
                    <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                    <FooterStyle BackColor="#CCCC99" />
                    <SortedAscendingCellStyle BackColor="#FBFBF2" />
                    <SortedAscendingHeaderStyle BackColor="#848384" />
                    <SortedDescendingCellStyle BackColor="#EAEAD3" />
                    <SortedDescendingHeaderStyle BackColor="#575357" />
                </asp:GridView>
            </asp:Panel>
            <%--    </div>
                </div>
            </asp:Panel>--%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="SELECT * FROM [v_Request_Master_Submitted] WHERE  ([ReqID] = @ReqID)"
                SelectCommandType="Text">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtRequestID" Name="ReqID" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="hidSlNo" runat="server" Value="" />
            <asp:SqlDataSource ID="SqlDataSourceAddAcc" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                DeleteCommand="Update iBanking_Req SET status=3 WHERE SL=@SL" DeleteCommandType="Text"
                SelectCommand="s_LoadiBankingReqDatatoGridReqIDWise" SelectCommandType="StoredProcedure"
                OnDeleted="SqlDataSourceAddAcc_Deleted">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtRequestID" Name="ReqID" PropertyName="Text" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SL" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <%-------------------------------Start Modal-----------------------------------------------------------%>
            <span style="visibility: hidden">
                <asp:Button runat="server" ID="cmdPopup" /></span>
            <asp:Panel ID="ModalPanel" runat="server" CssClass="Panel1">
                <div style="padding: 5px">
                    <table width="100%">
                        <tr>
                            <td>
                            </td>
                            <td align="right">
                                <asp:Image ID="ModalClose" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close"
                                    Style="cursor: pointer" Width="21px" Height="21px" />
                            </td>
                        </tr>
                    </table>
                    <asp:DetailsView ID="DetailsViewforModal" runat="server" BackColor="White" BorderColor="#DEDFDE"
                        BorderStyle="Solid" CssClass="Grid" DataSourceID="SqlDataSource3" CellPadding="5"
                        ForeColor="Black" AutoGenerateRows="False" DataKeyNames="SL" OnItemUpdated="DetailsViewforModal_ItemUpdated"
                        OnDataBound="DetailsViewforModal_DataBound">
                        <FooterStyle BackColor="#CCCC99" />
                        <RowStyle BackColor="#F7F7DE" VerticalAlign="Middle" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <Fields>
                            <asp:BoundField DataField="SL" HeaderText="SL" SortExpression="SL" ReadOnly="true"
                                Visible="false" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Large">
                                <ItemStyle Font-Bold="True" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ReqID" HeaderText="Request ID" SortExpression="ReqID"
                                ReadOnly="true"></asp:BoundField>
                            <asp:BoundField DataField="Accountno" HeaderText="Account No" SortExpression="Accountno"
                                ReadOnly="true">
                                <ItemStyle Font-Bold="True" Font-Size="120%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="acname" HeaderText="Account Name" SortExpression="acname"
                                ReadOnly="true">
                                <ItemStyle Font-Bold="false" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ReqType" HeaderText="Request Type" SortExpression="ReqType"
                                ReadOnly="true">
                                <ItemStyle Font-Bold="false" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Status_Name" HeaderText="Present Status" SortExpression="Status_Name"
                                ReadOnly="true">
                                <ItemStyle Font-Bold="false" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Status">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceStatus"
                                        DataTextField="Status_Name" DataValueField="Status_Types" SelectedValue='<%# Bind("Status_Types") %>'>
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorddlStatus" runat="server" ControlToValidate="ddlStatus"
                                        ErrorMessage="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtRemarks" runat="server" MaxLength="500" Width="400px" Text='<%# Bind("Remarks") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ControlStyle-Width="100px">
                                <%--<ItemTemplate>Remarks
                                    <asp:Button ID="btnSave" runat="server" CommandName="Update" OnClick="btnSave_Click"
                                        Text="Save" />
                                </ItemTemplate>--%>
                                <EditItemTemplate>
                                    <asp:Button ID="Button1" runat="server" CommandName="Update" Text="Update" />
                                </EditItemTemplate>
                                <ControlStyle Width="100px" />
                            </asp:TemplateField>
                        </Fields>
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:DetailsView>
                </div>
                <div style="padding: 5px; max-height: 300px; overflow: auto">
                    <asp:GridView ID="gdvChangeStatusList" runat="server" DataKeyNames="SL" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSourceStatusList" CssClass="Grid" AllowSorting="false" BorderStyle="None"
                        BackColor="White" BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black"
                        GridLines="Vertical">
                        <RowStyle VerticalAlign="Top" />
                        <Columns>
                            <asp:TemplateField HeaderText="#" SortExpression="SL">
                                <ItemTemplate>
                                    <div title='<%# Eval("AutoSL") %>'>
                                        <%# (Eval("RevID").ToString() == "9999" ? "<img src='Images/new.gif' width=35' height='22' >" : Eval("RevID") )%></div>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Reason" HeaderText="Remarks" />
                            <asp:BoundField DataField="Status_Name" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Insert By">
                                <ItemTemplate>
                                    <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("ByEmp") %>' />
                                </ItemTemplate>
                                <ItemStyle ForeColor="Gray" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Insert On">
                                <ItemTemplate>
                                    <div title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                        <%# TrustControl1.ToRecentDateTime(Eval("DT"))%><br />
                                        <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle ForeColor="Gray" />
                            </asp:TemplateField>
                            <%-- <asp:BoundField DataField="DT" HeaderText="Date" />
                            <asp:BoundField DataField="ByEmp" HeaderText="Insert By" />--%>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle HorizontalAlign="Left" CssClass="PagerStyle" />
                        <SelectedRowStyle BackColor="#FFD24D" />
                        <HeaderStyle BackColor="#6B696B" ForeColor="White" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceStatusList" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                        SelectCommand="s_iBanking_Req_Status_List_AccWise" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="grdvAccountList" Name="SL" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="modal" runat="server" CancelControlID="ModalClose" TargetControlID="cmdPopup"
                PopupControlID="ModalPanel" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="ModalTitleBar"
                RepositionMode="RepositionOnWindowResize" X="-1" Y="1" CacheDynamicResults="False"
                Drag="false">
            </cc1:ModalPopupExtender>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="s_iBanking_Req_Status_Select" SelectCommandType="StoredProcedure"
                UpdateCommand="s_iBanking_Req_Status_Insert" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSource3_Inserted" OnUpdated="SqlDataSource3_Updated">
                <SelectParameters>
                    <asp:ControlParameter ControlID="grdvAccountList" Name="SL" PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                    <%--<asp:Parameter Direction="InputOutput" Name="ID" Type="Int32" />--%>
                    <asp:Parameter Name="SL" Type="Int32" />
                    <asp:Parameter Name="ReqID" Type="Int64" />
                    <asp:Parameter Name="Status_Types" Type="Int32" />
                    <asp:SessionParameter Name="ModifiedBy" SessionField="EMPID" Type="String" />
                    <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                    <asp:Parameter Name="Remarks" Type="String" />
                    <asp:Parameter DefaultValue="" Direction="InputOutput" Name="Msg" Size="255" Type="String" />
                    <asp:Parameter DefaultValue="false" Direction="InputOutput" Name="Done" Type="Boolean" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="hiddenFieldBranch" runat="server" />
            <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="SELECT   Status_Types ,Status_Name FROM    [Request_Process].[dbo].[Status_Types] WHERE   ho_br = @ho_br  AND Active = 1 ORDER BY ordercol">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hiddenFieldBranch" Name="ho_br" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <%-----------------------------------------------------End Modal------------------------------------------------%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

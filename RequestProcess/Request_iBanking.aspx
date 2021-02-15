<%@ Page Title="" Language="C#" MasterPageFile="~/TrustBank.master" AutoEventWireup="true"
    Inherits="RequestProcess.Request_iBanking" CodeBehind="Request_iBanking.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>iBanking Request - Trust Bank</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    iBanking Request
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ToolkitScriptManager ID="TrustScriptManager" runat="server" CombineScripts="true"
        LoadScriptsBeforeUI="true" ScriptMode="Release" CompositeScript-ScriptMode="Release">
    </asp:ToolkitScriptManager>
    <uc1:CommonControl ID="CommonControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="row hidden-xs">
                <div class="col-md-7">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            My Personal Information
                        </div>
                        <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" CssClass="table table-condensed table-hover"
                            HeaderText="" BorderColor="white" BorderStyle="None" ForeColor="Black" GridLines="None"
                            AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" OnDataBound="DetailsView1_DataBound">
                            <Fields>
                                <asp:TemplateField HeaderText="" ShowHeader="false">
                                    <ItemTemplate>
                                        <div class="row">
                                            <label class="col-sm-3 control-label">
                                                Email</label>
                                            <div class="col-sm-9">
                                                <div class="bold form-control-static">
                                                    <%# Eval("Email") %>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name" ShowHeader="false">
                                    <ItemTemplate>
                                        <div class="row">
                                            <label class="col-sm-3 control-label">
                                                Full Name</label>
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
                                <asp:TemplateField HeaderText="Mobile No." ShowHeader="false">
                                    <ItemTemplate>
                                        <div class="row">
                                            <label class="col-sm-3 control-label">
                                                Mobile</label>
                                            <div class="col-sm-9">
                                                <div class="form-control-static">
                                                    <%# Eval("MobileNo","+{0}")%>
                                                    <%# (Eval("MobileVarified").ToString() == "True") ? "<img src='Images/tick2.png' width='16' height='16' title='verified'>" : ""%>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                            <EmptyDataTemplate>
                                No Data Found.
                            </EmptyDataTemplate>
                        </asp:DetailsView>
                    </div>
                </div>
                <div class="col-md-5">
                </div>
            </div>
            <asp:Panel ID="panelUsedAcc" runat="server" Visible="false">
                <div class="panel panel-success">
                    <div class="panel-heading" id="taggedAccountPanel" style="cursor: pointer">
                        Tagged Accounts with your e-mail address (click here to show)</div>
                    <div id="taggedAccountContent">
                        <div class="table-responsive">
                            <asp:GridView ID="gdvUsedAccount" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed table-responsive"
                                BorderStyle="None" DataSourceID="SqlDataSourceTaggedAcc" DataKeyNames="Accountno"
                                OnSelectedIndexChanged="gdvUsedAccount_SelectedIndexChanged">
                                <Columns>
                                    <asp:TemplateField HeaderText="#" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <%--  <asp:BoundField HeaderText="Account No" DataField="Accountno" ItemStyle-Wrap="false">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>--%>
                                    <asp:TemplateField HeaderText="Account No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAccountNo" runat="server" Text='<%# Eval("Accountno") %>'></asp:Label>
                                            <asp:HoverMenuExtender runat="server" ID="HoverMenuExtenderlblUserID" DynamicControlID="PanelAccountNoHover"
                                                DynamicServiceMethod="getAccountInfo" DynamicServicePath="UserAccountService.asmx"
                                                TargetControlID="lblAccountNo" DynamicContextKey='<%# Eval("Accountno") %>' PopupControlID="PanelAccountNoHover"
                                                CacheDynamicResults="true" HoverDelay="500" OffsetY="15">
                                            </asp:HoverMenuExtender>
                                            <asp:Panel runat="server" ID="PanelAccountNoHover" CssClass="alert alert-warning HoverMenuExtender">
                                            </asp:Panel>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                    </asp:TemplateField>
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
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="No. of Trans Per Month">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPerMonthTrans" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("PerMonthNoOfTransaction", "{0:N0}"))%>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:TemplateField>
                                    <asp:CommandField SelectText="Modify" ShowSelectButton="True" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lblDelteExisting" Text="Delete" CausesValidation="false"
                                                CommandArgument='<%# Eval("Accountno") %>' CommandName="Insert" OnClick="lblDelteExisting_Click"></asp:LinkButton>
                                            <asp:ConfirmButtonExtender runat="server" ID="ConfirmButtonExtenderlblDelteExisting"
                                                TargetControlID="lblDelteExisting" ConfirmText="Do you want to Delete this Account?">
                                            </asp:ConfirmButtonExtender>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <SelectedRowStyle CssClass="GridSelected" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <div class="panel panel-success">
                <div class="panel-heading">
                    Account Link for iBanking Service</div>
                <table class="table table-condensed table-hover">
                    <tr>
                        <td>
                            <div class="row col-sm-12 courier">
                                Please enter the following information to avail the Trust Bank iBanking service.
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="row">
                                <label class="col-sm-4 control-label">
                                    Account Number</label>
                                <div class="col-sm-4 col-md-3 has-feedback">
                                    <asp:TextBox ID="txtAccountNo" runat="server" CssClass="form-control" MaxLength="18"
                                        placeholder="xxxx-xxxxxxxxxx" required></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtAccountNo" runat="server"
                                        ControlToValidate="txtAccountNo" ErrorMessage="*" Style="margin: 5px" ForeColor="Red"
                                        Font-Size="25px" Font-Bold="true" SetFocusOnError="True" Display="Dynamic" class="form-control-feedback"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-sm-8 col-md-5 col-sm-offset-4 col-md-offset-0 btn-option-advance">
                                    <asp:CheckBox ID="chkFundTransfer" runat="server" Text="Allow Fund Transfer/Utility Payment"
                                        ToolTip="Click on Check box to allow Fund Transfer/Utility Payment" />
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="hidden option-advance">
                        <td>
                            <div class="row">
                                <label class="col-sm-4 control-label">
                                    Transfer Limit Per Transaction
                                </label>
                                <div class="col-sm-3 has-feedback">
                                    <asp:TextBox ID="txtTransferLimit" runat="server" TextMode="Number" min="0" max="40000"
                                        CssClass="form-control" Text="40000"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RVtxtTransferLimit" ControlToValidate="txtTransferLimit"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="40000" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-5 courier">
                                    <div class="glyphicon info-sign pointer btn-lg" title="more info" id="btnInfo-TransferLimit">
                                    </div>
                                    <div id="lblInfo-TransferLimit" class="hidden pointer" title="hide">
                                        This amount will be per transaction maximum transfer limit. Enter 0 to stop this
                                        service. Maximum allowed limit is Tk. 40000 (forty thousand).
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="hidden option-advance">
                        <td>
                            <div class="row">
                                <label class="col-sm-4 control-label">
                                    Utility Limit Per Transaction</label>
                                <div class="col-sm-3 has-feedback">
                                    <asp:TextBox ID="txtUtilityLimit" runat="server" TextMode="Number" min="0" max="40000"
                                        required CssClass="form-control" Text="40000"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RangeValidatorUtilityLimit" ControlToValidate="txtUtilityLimit"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="40000" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-5 courier">
                                    <div class="glyphicon info-sign pointer btn-lg" title="more info" id="btnInfo-UtilityLimit">
                                    </div>
                                    <div id="lblInfo-UtilityLimit" class="hidden pointer" title="hide">
                                        This amount will be per transaction maximum utility bill payment limit. Enter 0
                                        to stop this service. Maximum allowed limit is Tk. 40000 (forty thousand).
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="hidden option-advance">
                        <td>
                            <div class="row">
                                <label class="col-sm-4 control-label">
                                    Daily Transaction Limit</label>
                                <div class="col-sm-3 has-feedback">
                                    <asp:TextBox ID="txtDailyTransactionLimit" runat="server" TextMode="Number" min="0"
                                        max="100000" required CssClass="form-control" Text="100000"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RangeValidatorDailyTransactionLimit" ControlToValidate="txtDailyTransactionLimit"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="100000" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-5 courier">
                                    <div class="glyphicon info-sign pointer btn-lg" title="more info" id="btnInfo-DailyTransactionLimit">
                                    </div>
                                    <div id="lblInfo-DailyTransactionLimit" class="hidden pointer" title="hide">
                                        Enter your total transaction limit per day. Maximum allowed limit is Tk. 100000
                                        (one lac).
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="hidden option-advance">
                        <td>
                            <div class="row">
                                <label class="col-sm-4 control-label">
                                    Monthly Transaction Limit</label>
                                <div class="col-sm-3 has-feedback">
                                    <asp:TextBox ID="txtMonthlyTransactionLimit" runat="server" TextMode="Number" min="0"
                                        max="1000000" required CssClass="form-control" Text="1000000"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RangeValidatorMonthlyTransactionLimit" ControlToValidate="txtMonthlyTransactionLimit"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="1000000" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-5 courier">
                                    <div class="glyphicon info-sign pointer btn-lg" title="more info" id="btnInfo-MonthlyTransactionLimit">
                                    </div>
                                    <div id="lblInfo-MonthlyTransactionLimit" class="hidden pointer" title="hide">
                                        Enter your total transaction limit per month. Maximum allowed limit is Tk. 1000000
                                        (ten lac).
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="hidden option-advance">
                        <td>
                            <div class="row">
                                <label class="col-sm-4 control-label">
                                    No of Transaction Per Day</label>
                                <div class="col-sm-2 has-feedback">
                                    <asp:TextBox ID="txtPerDayNoOfTransaction" runat="server" TextMode="Number" min="0"
                                        max="10" required CssClass="form-control" MaxLength="2" Text="4"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RangeValidatorPerDayNoOfTransaction" ControlToValidate="txtPerDayNoOfTransaction"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="10" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-6 courier">
                                    <div class="glyphicon info-sign pointer btn-lg" title="more info" id="btnInfo-PerDayNoOfTransaction">
                                    </div>
                                    <div id="lblInfo-PerDayNoOfTransaction" class="hidden pointer" title="hide">
                                        Enter your total number of transaction per day. Maximum allowed limit is 10.
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="hidden option-advance">
                        <td>
                            <div class="row">
                                <label class="col-sm-4 control-label">
                                    No of Transaction Per Month</label>
                                <div class="col-sm-2 has-feedback">
                                    <asp:TextBox ID="txtPerMonthNoOfTransaction" runat="server" TextMode="Number" min="0"
                                        max="100" required CssClass="form-control" MaxLength="3" Text="100"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RangeValidatorPerMonthNoOfTransaction" ControlToValidate="txtPerMonthNoOfTransaction"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="100" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-6 courier">
                                    <div class="glyphicon info-sign pointer btn-lg" title="more info" id="btnInfo-PerMonthNoOfTransaction">
                                    </div>
                                    <div id="lblInfo-PerMonthNoOfTransaction" class="hidden pointer" title="hide">
                                        Enter your total number of transaction per month. Maximum allowed limit is 100.
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="row hidden" id="div-tp-warning">
                                <div class="col-sm-8 col-md-offset-4 col-sm-offset-4 courier bold" style="color: Red">
                                    This iBanking Transaction profile will not supersede the initial Transaction Profile
                                    which you have filled up at the time of account opening. If you want to change that
                                    transaction profile please contact with your branch's account opening desk.
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 col-md-offset-4 col-sm-offset-4">
                                    <asp:Button ID="cmdAddAccount" runat="server" Text="Add Account" CssClass="btn btn-success btn-block"
                                        OnClick="cmdAddAccount_Click1" />
                                </div>
                                <div class="col-sm-2">
                                    <asp:Button ID="btnNewAcc" runat="server" Text="New" CssClass="btn btn-success btn-block"
                                        Visible="false" OnClick="btnNewAcc_Click" />
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:Panel ID="PanelLinkedAccount" runat="server" Visible="false">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        Linked Account againest above Email No for iBanking Service</div>
                    <div class="table table-responsive">
                        <asp:GridView ID="grdvAccountList" runat="server" DataKeyNames="SL" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSourceAddAcc" CssClass="table table-striped table-bordered table-condensed table-responsive"
                            BorderStyle="None" OnSelectedIndexChanged="grdvAccountList_SelectedIndexChanged"
                            OnRowCommand="grdvAccountList_RowCommand" OnRowDataBound="grdvAccountList_RowDataBound"
                            OnDataBound="grdvAccountList_DataBound">
                            <Columns>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSL" runat="server" Text='<%# Eval("SL") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--  <asp:BoundField HeaderText="Sl No" DataField="SL" Visible="false" />--%>
                                <asp:TemplateField HeaderText="#" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Account No" DataField="Accountno" ItemStyle-Wrap="false"
                                    HeaderStyle-Font-Size="Small">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:CheckBoxField DataField="AlllowFund" HeaderText="Allow Fund" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-Font-Size="Small" SortExpression="AlllowFund">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:CheckBoxField>
                                <asp:TemplateField HeaderText="Transfer limit per Transaction" HeaderStyle-Font-Size="Small">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransferLimit" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("TransferLimit", "{0:N0}"))%>' />
                                        <%--  <%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("TransferLimit", "{0:N0}"))%>--%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Utility Limit Per Trans" HeaderStyle-Font-Size="Small">
                                    <ItemTemplate>
                                        <%--  <%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("UtilityLimit", "{0:N0}"))%>--%>
                                        <asp:Label ID="lblUtilityLimit" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("UtilityLimit", "{0:N0}"))%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Daily Transaction Limit" HeaderStyle-Font-Size="Small">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDailyTrans" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("DailyTransactionLimit", "{0:N0}"))%>' />
                                        <%-- <%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("DailyTransactionLimit", "{0:N0}"))%>--%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Monthly Transaction Limit" HeaderStyle-Font-Size="Small">
                                    <ItemTemplate>
                                        <%-- <%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("MonthlyTransactionLimit", "{0:N0}"))%>--%>
                                        <asp:Label ID="lblMonthly" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("MonthlyTransactionLimit", "{0:N0}"))%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="No. of Trans Per Day" HeaderStyle-Font-Size="Small"
                                    HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%-- <%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("PerDayNoOfTransaction", "{0:N0}"))%>--%>
                                        <asp:Label ID="lblPerDayTrans" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("PerDayNoOfTransaction", "{0:N0}"))%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="No. of Trans Per Month" HeaderStyle-Font-Size="Small">
                                    <ItemTemplate>
                                        <%-- <%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("PerMonthNoOfTransaction", "{0:N0}"))%>--%>
                                        <asp:Label ID="lblPerMonthTrans" runat="server" Text='<%# (Eval("AlllowFund").ToString() == "False" ? "" : Eval("PerMonthNoOfTransaction", "{0:N0}"))%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ReqType" HeaderText="Request Type" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-Font-Size="Small">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkSelect" CausesValidation="False" CommandName="Select"
                                            OnClick="lnkSelect_Click" CommandArgument='<%# Eval("SL") %>'>Edit</asp:LinkButton>
                                        <%-- <%# (Eval("ReqType").ToString() == "DELETE" ? "" :"this.Visible=false")%>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkDelete" CausesValidation="False" CommandName="Delete"
                                            CommandArgument='<%# Eval("SL") %>'>Delete</asp:LinkButton>
                                        <asp:ConfirmButtonExtender ID="btnDelete_ConfirmButtonExtender" runat="server" ConfirmText="Do you want to Delete this Account No?"
                                            Enabled="True" TargetControlID="lnkDelete">
                                        </asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <SelectedRowStyle CssClass="GridSelected" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel runat="server" ID="panelTransferMode" Visible="false">
                <div class="row">
                    <label class="col-sm-4 control-label">
                        Fund Transfer is allowed to</label>
                    <div class="col-sm-4 col-md-3 has-feedback">
                        <asp:DropDownList ID="ddlTranPrevilage" runat="server" AppendDataBoundItems="true"
                            ValidationGroup="grpNextStep" CssClass="form-control" DataTextField="PrivilegeName"
                            DataValueField="PrivilegeID">
                            <asp:ListItem Text="Please Select" Value=""></asp:ListItem>
                            <asp:ListItem Value="Own Accounts Only" Text="Own Accounts Only"></asp:ListItem>
                            <asp:ListItem Value="All Accounts" Text="All Accounts"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlTranPrevilage"
                            ErrorMessage="*" Style="margin: 5px" ForeColor="Red" Font-Size="25px" Font-Bold="true"
                            ValidationGroup="grpNextStep" SetFocusOnError="True" Display="Dynamic" class="form-control-feedback"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row" style="padding: 10px 0 0 0;">
                    <label class="col-sm-4 control-label">
                        One Time Password (OTP) for Fund Transaction will go through</label>
                    <div class="col-sm-4 col-md-3 has-feedback">
                        <asp:DropDownList ID="ddlOtp" runat="server" AppendDataBoundItems="true" CssClass="form-control"
                            ValidationGroup="grpNextStep" DataTextField="OtpName" DataValueField="OtpID">
                            <asp:ListItem Text="Please Select" Value=""></asp:ListItem>
                            <asp:ListItem Value="Mobile" Text="Mobile"></asp:ListItem>
                            <asp:ListItem Value="Email" Text="Email Address" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="Email and Mobile" Text="Email and Mobile" Enabled="false"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlOtp"
                            ErrorMessage="*" Style="margin: 5px" ForeColor="Red" Font-Size="25px" Font-Bold="true"
                            ValidationGroup="grpNextStep" SetFocusOnError="True" Display="Dynamic" class="form-control-feedback"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </asp:Panel>
            <div class="row" style="padding: 0 0 15px 0;">
                <div class="col-sm-3 col-md-offset-4 col-sm-offset-4">
                    <asp:Button ID="btnNextStep" runat="server" Text="Skip & Next Step" CssClass="btn btn-success btn-block"
                        ValidationGroup="grpNextStep" CausesValidation="true" formnovalidate OnClick="btnNextStep_Click" />
                </div>
                <div class="col-sm-3">
                    <asp:HyperLink ID="HyperLinkShowRequst" runat="server" NavigateUrl="" Target="_blank"
                        Visible="false">View all Service Requests</asp:HyperLink>
                </div>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="SELECT * FROM [v_Request_Master_Submitted] WHERE (([Email] = @Email) AND ([KeyCode] = @KeyCode) AND ([ReqID] = @ReqID))"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Email" QueryStringField="email" Type="String" />
                    <asp:QueryStringParameter Name="KeyCode" QueryStringField="keycode" Type="String" />
                    <asp:QueryStringParameter Name="ReqID" QueryStringField="reqid" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="hidSlNo" runat="server" Value="" />
            <asp:SqlDataSource ID="SqlDataSourceAddAcc" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                DeleteCommand="DELETE FROM iBanking_Req WHERE SL=@SL" DeleteCommandType="Text"
                SelectCommand="s_LoadiBankingReqDatatoGridReqIDWise" SelectCommandType="StoredProcedure"
                OnDeleted="SqlDataSourceAddAcc_Deleted" OnSelected="SqlDataSourceAddAcc_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ReqID" QueryStringField="reqid" Type="String" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SL" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceTaggedAcc" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="s_iBanking_UserAcc" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Email" QueryStringField="email" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DynamicLayout="false" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100">
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

<%@ Page Title="" Language="C#" MasterPageFile="~/TrustBank.master" AutoEventWireup="true"
    CodeFile="Request_iBanking.aspx.cs" Inherits="Request_iBanking" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register src="CommonControl.ascx" tagname="CommonControl" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>iBanking Request - Trust Bank</title>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    iBanking Request
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ToolkitScriptManager ID="TrustScriptManager" runat="server" 
        CombineScripts="true"
        LoadScriptsBeforeUI="true" 
        ScriptMode="Release"
        CompositeScript-ScriptMode="Release">

    </asp:ToolkitScriptManager>
    <uc1:CommonControl ID="CommonControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>       
    
            <div class="row hidden-xs">
                <div class="col-md-7">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            My Personal Information</div>
                        <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" CssClass="table table-condensed table-hover"
                            HeaderText="" BorderColor="white" BorderStyle="None" ForeColor="Black" GridLines="None"
                            AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" 
                            ondatabound="DetailsView1_DataBound">
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
                                <div class="col-sm-3 has-feedback">
                                    <asp:TextBox ID="txtAccountNo" runat="server" CssClass="form-control" MaxLength="18" required></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtAccountNo" runat="server"
                                        ControlToValidate="txtAccountNo" ErrorMessage="*" SetFocusOnError="True" Display="Dynamic"
                                        class="form-control-feedback"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-sm-2 btn-option-advance">
                                    <a class="btn" title="Advanced Options">Customize my limits</a></div>
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
                                    <asp:TextBox ID="txtTransferLimit" runat="server" TextMode="Number" min="0" max="100000" step="1000"  CssClass="form-control" Text="40000"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RVtxtTransferLimit" ControlToValidate="txtTransferLimit"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="100000" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-5 courier">
                                    <div class="glyphicon glyphicon-info-sign pointer btn-lg" title="more info" id="btnInfo-TransferLimit">
                                    </div>
                                    <div id="lblInfo-TransferLimit" class="hidden pointer" title="hide">
                                        This amount will be per transaction maximum transfer limit. Enter 0 to stop this
                                        service. Maximum allowed limit is Tk. 100000 (one lac).
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
                                    <asp:TextBox ID="txtUtilityLimit" runat="server" TextMode="Number" min="0" max="50000" step="1000" required CssClass="form-control" Text="40000"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RangeValidatorUtilityLimit" ControlToValidate="txtUtilityLimit"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="50000" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-5 courier">
                                    <div class="glyphicon glyphicon-info-sign pointer btn-lg" title="more info" id="btnInfo-UtilityLimit">
                                    </div>
                                    <div id="lblInfo-UtilityLimit" class="hidden pointer" title="hide">
                                        This amount will be per transaction maximum utility bill payment limit. Enter 0
                                        to stop this service. Maximum allowed limit is Tk. 50000 (fifty thousand).
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
                                    <asp:TextBox ID="txtDailyTransactionLimit" runat="server" TextMode="Number" min="0" max="100000" step="1000" required CssClass="form-control"
                                        Text="100000"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RangeValidatorDailyTransactionLimit" ControlToValidate="txtDailyTransactionLimit"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="100000" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-5 courier">
                                    <div class="glyphicon glyphicon-info-sign pointer btn-lg" title="more info" id="btnInfo-DailyTransactionLimit">
                                    </div>
                                    <div id="lblInfo-DailyTransactionLimit" class="hidden pointer" title="hide">
                                        Enter your total transaction limit per day. Maximum allowed limit is Tk. 100000 (one lac).
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
                                    <asp:TextBox ID="txtMonthlyTransactionLimit" runat="server" TextMode="Number" min="0" max="1000000" step="1000" required CssClass="form-control"
                                        Text="1000000"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RangeValidatorMonthlyTransactionLimit" ControlToValidate="txtMonthlyTransactionLimit"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="1000000" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-5 courier">
                                    <div class="glyphicon glyphicon-info-sign pointer btn-lg" title="more info" id="btnInfo-MonthlyTransactionLimit">
                                    </div>
                                    <div id="lblInfo-MonthlyTransactionLimit" class="hidden pointer" title="hide">
                                        Enter your total transaction limit per month. Maximum allowed limit is Tk. 1000000 (ten lac).
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
                                    <asp:TextBox ID="txtPerDayNoOfTransaction" runat="server" TextMode="Number" min="0" max="10" required CssClass="form-control"
                                        MaxLength="2" Text="4"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RangeValidatorPerDayNoOfTransaction" ControlToValidate="txtPerDayNoOfTransaction"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="10" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-6 courier">
                                    <div class="glyphicon glyphicon-info-sign pointer btn-lg" title="more info" id="btnInfo-PerDayNoOfTransaction">
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
                                    <asp:TextBox ID="txtPerMonthNoOfTransaction" runat="server" TextMode="Number" min="0" max="100" required CssClass="form-control"
                                        MaxLength="3" Text="100"></asp:TextBox>
                                    <asp:RangeValidator runat="server" ID="RangeValidatorPerMonthNoOfTransaction" ControlToValidate="txtPerMonthNoOfTransaction"
                                        class="form-control-feedback" MinimumValue="0" MaximumValue="100" ErrorMessage="*"
                                        Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                                </div>
                                <div class="col-sm-6 courier">
                                    <div class="glyphicon glyphicon-info-sign pointer btn-lg" title="more info" id="btnInfo-PerMonthNoOfTransaction">
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
                            <div class="row">
                                <div class="col-sm-3 col-md-offset-4">
                                    <asp:Button ID="cmdAddAccount" runat="server" Text="Add Account" 
                                        CssClass="btn btn-success btn-block col-sm-2" onclick="cmdAddAccount_Click1" />
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="SELECT * FROM [v_Request_Master] WHERE (([Email] = @Email) AND ([KeyCode] = @KeyCode))"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Email" QueryStringField="email" Type="String" />
                    <asp:QueryStringParameter Name="KeyCode" QueryStringField="keycode" Type="String" />
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

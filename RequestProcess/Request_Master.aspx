<%@ Page Title="" Language="C#" MasterPageFile="~/TrustBank.master" AutoEventWireup="true"
    Inherits="RequestProcess.Request_Master" Culture="en-NZ" CodeBehind="Request_Master.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    eService Request Entry Form
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ToolkitScriptManager ID="TrustScriptManager" runat="server" ScriptMode="Release"
        CombineScripts="true" EnablePartialRendering="true">
    </asp:ToolkitScriptManager>
    <uc1:CommonControl ID="CommonControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="PanelOtp" runat="server" Visible="false" CssClass="row">
                <div class="col-md-6">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            Mobile Number Verification</div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-2 text-center">
                                    <img src="Images/sms-icon.png" width="64" height="64" />
                                </div>
                                <div class="col-md-10 courier">
                                    To verify your mobile number, please enter the Secret Code received in your mobile
                                    phone as SMS:
                                </div>
                            </div>
                            <div class="row">
                                <label class="control-label col-sm-4">
                                    Secret Code:</label>
                                <div class="col-sm-4 has-feedback">
                                    <asp:TextBox ID="txtOTP" CssClass="form-control " runat="server" MaxLength="10"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtOTP" runat="server" ControlToValidate="txtOTP"
                                        ErrorMessage="*" style="margin:5px" ForeColor="Red" Font-Size="25px"  Font-Bold="true" SetFocusOnError="True" CssClass="form-control-feedback"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-sm-3">
                                    <asp:Button ID="cmdOTPVerify" class="btn btn-warning btn-block" runat="server" Text="Verify"
                                        OnClick="cmdOTPVerify_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <div class="panel panel-success">
                <div class="panel-heading">
                    My Personal Information</div>
                <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" CssClass="table table-condensed table-hover"
                    HeaderText="" BorderColor="white" BorderStyle="None" ForeColor="Black" GridLines="None"
                    AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" OnItemUpdated="DetailsView1_ItemUpdated"
                    OnItemUpdating="DetailsView1_ItemUpdating">
                    <Fields>
                        <asp:TemplateField HeaderText="" ShowHeader="false">
                            <ItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 control-label hidden-xs">
                                        Email</label>
                                    <div class="col-sm-6">
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
                                    <label class="col-sm-2 control-label">
                                        Full Name</label>
                                    <div class="col-sm-10">
                                        <div class="form-control-static">
                                            <%# Eval("Title") %>
                                            <%# Eval("FirstName")%>
                                            <%# Eval("MiddleName")%>
                                            <%# Eval("LastName")%>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                        Full Name</label>
                                    <div class="col-sm-2">
                                        <asp:TextBox runat="server" ID="txtTitle" Text='<%# Bind("Title") %>' CssClass="form-control capitalize"
                                            MaxLength="50" placeholder="Title (Mr/Ms)"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-3 has-feedback">
                                        <asp:TextBox runat="server" AutoCompleteType="FirstName" CssClass="form-control capitalize"
                                            ID="txtFirstName" Text='<%# Bind("FirstName") %>' MaxLength="50" placeholder="First Name"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtFstName" runat="server" ControlToValidate="txtFirstName"
                                            ErrorMessage="*" style="margin:5px" ForeColor="Red" Font-Size="25px"  Font-Bold="true" SetFocusOnError="True" CssClass="form-control-feedback"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:TextBox runat="server" ID="txtMiddleName" CssClass="form-control capitalize" Text='<%# Bind("MiddleName") %>'
                                            MaxLength="50" placeholder="Middle" AutoCompleteType="MiddleName"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-3  has-feedback">
                                        <asp:TextBox runat="server" ID="txtLastName" Text='<%# Bind("LastName") %>' MaxLength="50"
                                            CssClass="form-control capitalize" placeholder="Last Name" AutoCompleteType="LastName"></asp:TextBox>
                                              <asp:RequiredFieldValidator ID="RequiredFieldValidatorLastName" runat="server" ControlToValidate="txtLastName"
                                        ErrorMessage="*" style="margin:5px" ForeColor="Red" Font-Size="25px"  Font-Bold="true" SetFocusOnError="True" CssClass="form-control-feedback"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                    Display Name
                                        </label>
                                    <div class="col-sm-10">
                                        <div class="form-control-static bold" id="lblFullName" style="font-size:150%">
                                            <%--<%# Eval("Title") %>
                                            <%# Eval("FirstName")%>
                                            <%# Eval("MiddleName")%>
                                            <%# Eval("LastName")%>--%>
                                        </div>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mobile No." ShowHeader="false">
                            <ItemTemplate>
                                <div class="row">
                                    <label class="col-sm-3 col-md-2 control-label">
                                        Mobile Number</label>                                    
                                    <div class="col-sm-6 col-md-6">
                                        <div class="form-control-static">
                                            <%# Eval("MobileNo","+{0}")%>
                                            <%# (Eval("MobileVarified").ToString() == "True") ? "<img src='Images/tick2.png' width='16' height='16' title='verified'>" : ""%>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 col-md-2 control-label hidden-sm">
                                        Mobile Number</label>
                                    <label class="col-sm-2 col-md-2 control-label hidden-lg hidden-xs hidden-md">
                                        Mobile No.</label>
                                    <div class="col-sm-4 col-md-3 has-feedback has-success has-error">
                                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" required Text='<%# Bind("MobileNo","+{0}") %>'></asp:TextBox>
                                        <span id="valid-msg" class="hide glyphicon glyphicon-ok form-control-feedback text-right">
                                        </span><span id="error-msg" class="hide glyphicon glyphicon-remove form-control-feedback text-right">
                                        </span>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date of Birth" SortExpression="DOB" ShowHeader="false">
                            <ItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                        Date of Birth</label>
                                    <div class="col-sm-2 col-md-1">
                                        <div class="form-control-static">
                                            <%# Eval("DOB", "{0:dd/MM/yyyy}")%>
                                        </div>
                                    </div>
                                    <label class="col-sm-1 control-label">
                                        Sex</label>
                                    <div class="col-sm-1">
                                        <div class="form-control-static">
                                            <%# Eval("Sex").ToString() == "F" ? "Female" : "Male" %>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                        Date of Birth</label>
                                    <div class="col-sm-3 has-feedback">
                                        <asp:TextBox CssClass="Date-DOB form-control" ID="txtDOB" MaxLength="10" runat="server"
                                            Text='<%# Bind("DOB","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorDOB" runat="server" ControlToValidate="txtDOB"
                                            ErrorMessage="*" style="margin:5px"   ForeColor="Red" Font-Size="25px"  Font-Bold="true" SetFocusOnError="True" Display="Dynamic" class="form-control-feedback">
                                           <%-- <img src="Images/star-icon.png" width="16" height="16" style="margin:8px" />--%>
                                        </asp:RequiredFieldValidator>
                                    </div>
                                    <label class="col-sm-1 control-label">
                                        Sex</label>
                                    <div class="col-sm-2">
                                        <asp:DropDownList ID="DropDownListSex" CssClass="form-control" runat="server" SelectedValue='<%# Bind("Sex") %>'>
                                            <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Occupation" SortExpression="Occupation" ShowHeader="false">
                            <ItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                        Occupation</label>
                                    <div class="col-sm-10">
                                        <div class="form-control-static">
                                            <%# Eval("Occupation")%>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                        Occupation</label>
                                    <div class="col-sm-5 has-feedback">
                                        <asp:TextBox ID="txtOccupation" CssClass="form-control capitalize" MaxLength="255" runat="server"
                                            Text='<%# Bind("Occupation") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtOccupation" runat="server" 
                                            ControlToValidate="txtOccupation" ErrorMessage="*"  style="margin:5px" ForeColor="Red" Font-Size="25px"  Font-Bold="true" SetFocusOnError="True" Display="Dynamic"
                                            class="form-control-feedback"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Identification" ShowHeader="false">
                            <ItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                        Identification</label>
                                    <div class="col-sm-10">
                                        <div class="form-control-static">
                                            <%# Eval("IDTypeName","{0}: ")%>
                                            <%# Eval("IdNumber1")%>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                        Identity</label>
                                    <div class="col-sm-3 has-feedback">
                                        <asp:DropDownList ID="ddl_ID_Type1" runat="server" CssClass="form-control" AppendDataBoundItems="true"
                                            DataSourceID="SqlDataSourceID" DataTextField="IDTypeName" DataValueField="IdTypeID"
                                            SelectedValue='<%# Bind("IdType1") %>'>
                                            <asp:ListItem Text="Select ID Type" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorddl_ID_Type1" runat="server"
                                            ControlToValidate="ddl_ID_Type1" ErrorMessage="*" style="margin:5px" ForeColor="Red" Font-Size="25px"  Font-Bold="true" SetFocusOnError="True" CssClass="form-control-feedback"></asp:RequiredFieldValidator>
                                    </div>
                                    <asp:SqlDataSource ID="SqlDataSourceID" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                                        SelectCommand="SELECT [IdTypeID],[IDTypeName],[Active] FROM [dbo].[ID_Types] WHERE ACTIVE = 1">
                                    </asp:SqlDataSource>
                                    <label class="col-sm-1 control-label">
                                        Number</label>
                                    <div class="col-sm-4 has-feedback">
                                        <asp:TextBox ID="txtIdNumber1" runat="server" Text='<%# Bind("IdNumber1") %>' CssClass="form-control"
                                            MaxLength="100"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtIdNumber1" runat="server"
                                            ControlToValidate="txtIdNumber1" ErrorMessage="*" style="margin:5px" ForeColor="Red" Font-Size="25px"  Font-Bold="true" CssClass="form-control-feedback"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contact Info" SortExpression="ContactAddress" HeaderStyle-VerticalAlign="Top"
                            ShowHeader="false">
                            <ItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                        Contact Info</label>
                                    <div class="col-sm-10">
                                        <div class="form-control-static">
                                            <%# Eval("ContactAddress").ToString().Replace("\n","<br>") %>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                    </label>
                                    <div class="col-sm-10">
                                        <div class="form-control-static">
                                            <div class="location-path" style="border-top: 1px dashed silver;">
                                                <%# Eval("DIV_NAME","<span title='Division'>{0}</span>")%>
                                                <%# Eval("DIST_NAME", "» <span title='District'>{0}</span>")%>
                                                <%# Eval("THANA_NAME", "» <span title='Thana'>{0}</span>")%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                        Country
                                    </label>
                                    <div class="col-sm-10">
                                        <div class="form-control-static">
                                            <%# Eval("COUNTRY_NAME") %>
                                        </div>
                                    </div>
                                </div>
                                <div class="row <%# Eval("ContactNo").ToString().Trim() == "" ? "hide" : "" %>">
                                    <label class="col-sm-2 control-label">
                                        Contact Numbers
                                    </label>
                                    <div class="col-sm-10">
                                        <div class="form-control-static">
                                            <%# Eval("ContactNo")%>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <label class="col-sm-2 control-label">
                                        Country</label>
                                    <div class="col-sm-5 has-feedback">
                                        <asp:SqlDataSource ID="SqlDataSourceDropDownListCountry" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                                            SelectCommand="SELECT COUNTRY_Code, COUNTRY_NAME FROM [dbo].[v_COUNTRY_CODES]  ORDER BY Country_Name">
                                        </asp:SqlDataSource>
                                        <asp:DropDownList ID="DropDownListCountry" CssClass="form-control" runat="server"
                                            AppendDataBoundItems="true" AutoPostBack="true" CausesValidation="false" DataSourceID="SqlDataSourceDropDownListCountry"
                                            DataTextField="COUNTRY_NAME" DataValueField="COUNTRY_Code" SelectedValue='<%# Bind("ContactCountry") %>'
                                            OnSelectedIndexChanged="DropDownListCountry_SelectedIndexChanged" OnDataBound="DropDownListCountry_SelectedIndexChanged">
                                            <asp:ListItem Text="Select Country" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorDropDownListCountry" runat="server"
                                            CssClass="form-control-feedback" ControlToValidate="DropDownListCountry" ErrorMessage="*" style="margin:5px" ForeColor="Red" Font-Size="25px"  Font-Bold="true"
                                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <asp:Panel Style="padding-top: 10px" ID="PanelLocation" runat="server" CssClass="row">
                                    <label class="col-sm-2 control-label">
                                        Location</label>
                                    <div class="col-sm-3 has-feedback">
                                        <asp:SqlDataSource ID="SqlDataSourceDivision" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                                            SelectCommand="SELECT DIV_CODE, DIV_NAME FROM [dbo].[v_BD_Division]"></asp:SqlDataSource>
                                        <asp:DropDownList ID="dboDivision2" runat="server" CssClass="form-control" AppendDataBoundItems="true"
                                            AutoPostBack="True" DataSourceID="SqlDataSourceDivision" DataTextField="DIV_NAME"
                                            DataValueField="DIV_CODE" OnSelectedIndexChanged="dboDivision2_SelectedIndexChanged1"
                                            SelectedValue='<%# Eval("Div_Code") %>'>
                                            <asp:ListItem Text="Select Division" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <asp:HiddenField ID="hidDistrict" runat="server" Value='<%# Eval("Dist_Code") %>' />
                                    <asp:HiddenField ID="hidThana" runat="server" Value='<%# Eval("ContactThanaID") %>' />
                                    <asp:SqlDataSource ID="SqlDataSourceDistrict" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                                        SelectCommand="SELECT DIST_CODE, DIST_NAME FROM [dbo].[v_BD_District] WHERE DIV_CODE = @DIV_CODE ORDER BY DIST_NAME">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="dboDivision2" Name="DIV_CODE" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <div class="col-sm-3 has-feedback">
                                        <asp:DropDownList ID="dboDistrict2" runat="server" CssClass="form-control" AutoPostBack="True"
                                            CausesValidation="false" DataSourceID="SqlDataSourceDistrict" DataTextField="DIST_Name"
                                            DataValueField="DIST_CODE" EnableViewState="true" OnDataBound="dboDistrict2_DataBound"
                                            OnSelectedIndexChanged="dboDistrict2_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                    <asp:SqlDataSource ID="SqlDataSourceThana" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                                        SelectCommand="SELECT [THANA_CODE],[THANA_NAME] FROM [dbo].[v_BD_Thana] WHERE DIST_CODE = @DIST_CODE ORDER BY THANA_NAME">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="dboDistrict2" Name="DIST_CODE" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <div class="col-sm-3 has-feedback">
                                        <asp:DropDownList ID="dboThana2" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceThana"
                                            DataTextField="THANA_NAME" DataValueField="THANA_CODE" OnDataBound="dboThana2_DataBound">
                                        </asp:DropDownList>
                                        <%--<asp:HiddenField ID="hidDistrict" runat="server" Value='<%# Eval("Dist_Code") %>' />--%>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorDiv" runat="server" ControlToValidate="dboDivision2"
                                            ErrorMessage="*" style="margin:5px" ForeColor="Red" Font-Size="25px"  Font-Bold="true" SetFocusOnError="True" CssClass="form-control-feedback"></asp:RequiredFieldValidator>
                                    </div>
                                </asp:Panel>
                                <%--<asp:HiddenField ID="hidThana" runat="server" Value='<%# Eval("ContactThanaID") %>' />--%>
                                <div class="row" style="padding-top: 10px">
                                    <label class="col-sm-2 control-label">
                                        Address</label>
                                    <div class="col-sm-5 has-feedback">
                                        <asp:TextBox ID="txtContactAddress" runat="server" CssClass="form-control" Text='<%# Bind("ContactAddress") %>'
                                            TextMode="MultiLine" Rows="4"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorPadd" runat="server" ControlToValidate="txtContactAddress"
                                            ErrorMessage="*" style="margin:5px" ForeColor="Red" Font-Size="25px"  Font-Bold="true" SetFocusOnError="True" CssClass="form-control-feedback"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <label class="col-sm-2 control-label">
                                        Contact Numbers</label>
                                    <div class="col-sm-5 has-feedback">
                                        <asp:TextBox ID="txtPCNo" CssClass="form-control" MaxLength="255" runat="server"
                                            Text='<%# Bind("ContactNo") %>'></asp:TextBox>
                                    </div>
                                </div>
                            </EditItemTemplate>
                            <HeaderStyle VerticalAlign="Top" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="false">
                            <ItemTemplate>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <div class="col-sm-3 col-md-offset-2 col-sm-offset-2">
                                        <asp:Button ID="cmdSaveInfo" runat="server" CssClass="btn btn-success btn-block col-sm-4"
                                            Text="Save Information" CommandName="Update" />
                                    </div>
                                    <asp:ConfirmButtonExtender ID="cmdSave_ConfirmButtonExtender" runat="server" ConfirmText="Do you want to Submit?"
                                        Enabled="True" TargetControlID="cmdSaveInfo">
                                    </asp:ConfirmButtonExtender>
                                    <div class="col-sm-6 small">
                                        <%# Eval("DT","Last update:<br>{0:ddd, dd MMMM, yyyy on h:mm tt}") %><br />
                                        <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <FooterStyle BackColor="#CCCC99" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                </asp:DetailsView>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="s_Request_Master" SelectCommandType="StoredProcedure"
                UpdateCommand="s_Request_Master_Edit" UpdateCommandType="StoredProcedure" OnUpdating="SqlDataSource1_Updating"
                OnUpdated="SqlDataSource1_Updated">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Email" QueryStringField="email" Type="String" />
                    <asp:QueryStringParameter Name="KeyCode" QueryStringField="keycode" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:Parameter Name="ID" Type="Int64" />
                    <asp:Parameter Name="Title" Type="String" ConvertEmptyStringToNull="false" DefaultValue="" />
                    <asp:Parameter Name="FirstName" Type="String" ConvertEmptyStringToNull="false" DefaultValue="" />
                    <asp:Parameter Name="MiddleName" Type="String" ConvertEmptyStringToNull="false" DefaultValue="" />
                    <asp:Parameter Name="LastName" Type="String" ConvertEmptyStringToNull="false" DefaultValue="" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="MobileNo" Type="Int64" />
                    <asp:Parameter Name="DOB" Type="DateTime" />
                    <asp:Parameter Name="Occupation" Type="String" />
                    <asp:Parameter Name="IdType1" Type="Int32" />
                    <asp:Parameter Name="IdNumber1" Type="String" />
                    <asp:Parameter Name="ContactNo" Type="String" />
                    <asp:Parameter Name="ContactAddress" Type="String" />
                    <asp:Parameter Name="ContactThanaID" Type="Int32" ConvertEmptyStringToNull="false"
                        DefaultValue="0" />
                    <asp:Parameter Name="ContactCountry" Type="String" />
                    <asp:Parameter Name="Status" Type="Int32" DefaultValue="1" />
                    <asp:Parameter Name="Sex" Type="String" />
                    <asp:Parameter Direction="InputOutput" Name="Done" Type="Boolean" DefaultValue="false" />
                    <asp:Parameter Direction="InputOutput" Name="Msg" Type="String" Size="255" DefaultValue="            " />
                    <asp:Parameter Direction="InputOutput" Name="OTP_Sent" Type="Boolean" DefaultValue="false" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="PanelNext" runat="server" Style="padding-bottom: 20px" Visible="false"
                CssClass="row">
                <div class="col-sm-3 col-md-offset-2 col-sm-offset-2 col-md-2">
                    <asp:Button ID="cmdNextStep" runat="server" Text="Next Step" CssClass="btn btn-success btn-block"
                        OnClick="cmdNextStep_Click" />
                </div>
                <div class="col-sm-3 col-md-2">
                    <asp:Button ID="cmdEditAgain" OnClick="cmdEditAgain_Click" runat="server" Text="Edit Again" CssClass="btn btn-link btn-block" />
                </div>
            </asp:Panel>
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

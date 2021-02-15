<%@ Page Title="" Language="C#" MasterPageFile="~/TrustBank.master" AutoEventWireup="true"
    Inherits="RequestProcess.Request" CodeBehind="Request.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title></title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Trust Bank eService Request
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ToolkitScriptManager ID="TrustScriptManager" runat="server" CombineScripts="true"
        LoadScriptsBeforeUI="true" ScriptMode="Release" CompositeScript-ScriptMode="Release">
    </asp:ToolkitScriptManager>
    <uc1:CommonControl ID="CommonControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel runat="server" ID="PanelMsg" class="alert alert-warning " role="alert">
                <button type="button" class="close" data-dismiss="alert">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <asp:Literal ID="litMsg" runat="server"></asp:Literal>
            </asp:Panel>

            <div class="row">
                <div class="col-md-7">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            My Personal Information</div>
                        <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" CssClass="table table-condensed table-hover"
                            HeaderText="" BorderColor="white" BorderStyle="None" ForeColor="Black" GridLines="None"
                            AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" OnDataBound="DetailsView1_DataBound">
                            <Fields>
                                <asp:TemplateField HeaderText="" ShowHeader="false">
                                    <ItemTemplate>
                                        <div class="row">
                                            <label class="col-sm-3 control-label">
                                                Request ID</label>
                                            <div class="col-sm-9">
                                                <div class="form-control-static">
                                                    <%# Eval("ReqID") %>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ShowHeader="false">
                                    <ItemTemplate>
                                        <div class="row">
                                            <label class="col-sm-3 control-label">
                                                Email</label>
                                            <div class="col-sm-9">
                                                <div class="form-control-static">
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
                                <asp:TemplateField HeaderText="Request Status" ShowHeader="false">
                                    <ItemTemplate>
                                        <div class="row">
                                            <label class="col-sm-3 control-label">
                                                Request Status</label>
                                            <div class="col-sm-9">
                                                <div class="form-control-static">
                                                    <%# Eval("Status_Name")%>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <%--  <ItemTemplate>
                                        <%# Eval("Status_Name")%>
                                    </ItemTemplate>--%>
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
            <asp:Panel ID="PanelLinkedAccount" runat="server" Visible="true">
                <div class="panel panel-success">
                    <%--  <div class="table-hover" >--%>
                    <div class="panel-heading">
                        iBanking Service Request Account List
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="grdvAccountList" runat="server" DataKeyNames="SL" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSourceAddAcc" CssClass="table table-striped table-bordered  table-condensed table-responsive"
                            BorderStyle="None" OnSelectedIndexChanged="grdvAccountList_SelectedIndexChanged"  OnDataBound="grdvAccountList_DataBound"
                            OnRowCommand="grdvAccountList_RowCommand" OnRowDataBound="grdvAccountList_RowDataBound">
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
                            </Columns>
                            <SelectedRowStyle CssClass="GridSelected" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>
             <asp:Panel runat="server" ID="panelTransferMode" Visible="false">
             <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            iBanking Fund Transfer Options </div>
            <asp:DetailsView ID="DetailsViewTransactionPrivelage" runat="server" BackColor="White" CssClass="table table-condensed table-hover"
                            HeaderText="" BorderColor="white" BorderStyle="None" ForeColor="Black" GridLines="None"
                            AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="SqlDataSourceTransactionPrivelage">
                            <Fields>
                                <asp:TemplateField HeaderText="" ShowHeader="false">
                                    <ItemTemplate>
                                        <div class="row">
                                            <label class="col-sm-8 control-label">
                                                Fund Transfer is Allowed to</label>
                                            <div class="col-sm-4">
                                                <div class="form-control-static">
                                                    <%# Eval("TransactionPrivilege")%>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ShowHeader="false">
                                    <ItemTemplate>
                                        <div class="row">
                                            <label class="col-sm-8 control-label">
                                                One Time Password (OTP) for Transaction will go through</label>
                                            <div class="col-sm-4">
                                                <div class="form-control-static">
                                                    <%# Eval("OtpGoThrough")%>
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
                        </div>
                        </asp:Panel>
						    <asp:SqlDataSource ID="SqlDataSourceTransactionPrivelage" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="SELECT * FROM iBankingReqOptionPrivilege WHERE ReqID=@ReqID">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ReqID" QueryStringField="reqid" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>






            <div class="row" style="padding: 0 0 15px 0;">
                <div class="col-sm-3 col-md-2 col-md-offset-4 col-sm-offset-3 hidden-xs">
                    <asp:HyperLink ID="hypPrint" runat="server" Text="Print" CssClass="btn btn-success btn-block"
                        Target="_blank" />
                </div>
                <div class="col-sm-3 col-md-2">
                    <asp:HyperLink ID="hypDownload" runat="server" Text="Download as Pdf" CssClass="btn btn-success btn-block" />
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
                SelectCommand="s_LoadiBankingReqDatatoGridReqIDWise" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ReqID" QueryStringField="reqid" Type="String" />
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

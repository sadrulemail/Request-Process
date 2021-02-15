<%@ Page Title="" Language="C#" MasterPageFile="~/TrustBank.master" AutoEventWireup="True"
    CodeBehind="Default.aspx.cs" Inherits="RequestProcess.DefaultPage" %>

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
        ScriptMode="Release" EnablePartialRendering="true">
    </asp:ToolkitScriptManager>
    <uc1:CommonControl ID="CommonControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="PanelStatus" runat="server" CssClass="alert alert-success" Visible="false">
                <div class="row">
                    <div class="col-sm-2 text-center">
                        <img src="Images/email-send-icon.png" width="72" height="72" border="0" /></div>
                    <div class="col-sm-10">
                        <asp:Label ID="lblStatus" Style="font-size: 120%" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="Panel1" runat="server">
                <div class="row">
                    <div class="col-md-2 text-center">
                        <img src="Images/service-icon.png" width="128" height="128" />
                    </div>
                    <div class="col-md-10">
                        <div class="text-left courier">
                            Please enter the following information to start the eService Request wizard.<br />
                            <br />
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Email Address</label>
                            <div class="col-sm-5">
                                <asp:TextBox ID="txtEmail" CssClass="form-control" TextMode="Email" runat="server"
                                    ToolTip="Email Address" AutoCompleteType="Email" MaxLength="255" placeholder="enter email address"
                                    required></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                            </label>
                            <div class="col-sm-9">
                                <img src='Images/loading1.gif' id="ImgChallenge" alt="Captcha" style="border: 1px solid silver;
                                    padding: 2px; border-radius: 4px; cursor: pointer" width="135" height="35" title="Another Challenge Image" />
                                <img src="Images/reload.png" id="ImgChallengeReload" style="cursor: pointer" title="Another Challenge Image"
                                    alt="Refresh" width="16" height="16" border="0" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Challenge Key</label>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtCaptcha" CssClass="form-control" runat="server" Width="130px"
                                    MaxLength="5" required placeholder="# # # # #" autocomplete="off" pattern="^\d{5}$"
                                    ToolTip="Enter Challenge Key Numbers"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3">
                            </label>
                            <div class="col-sm-2">
                                <asp:Button ID="cmd" CssClass="btn btn-success btn-block" runat="server" Text="Submit"
                                    OnClick="cmd_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="PanelFacebook" runat="server" CssClass="center" Style="margin: 50px 0"
                Visible="false">
                <asp:Literal ID="FB_iFrame" runat="server"></asp:Literal>
                <%--<div class="form-group" style="margin-top:10px;">
                    
                        <button id="cmdCloseWindow" class="btn btn-success" style="width:120px;" formnovalidate >Close</button>
                    

                    <input type="button" value="Close" onclick="window.close()" class="btn btn-success" style="width:120px;" formnovalidate />
                    
                </div>--%>
            </asp:Panel>
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

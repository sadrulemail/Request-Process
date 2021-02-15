<%@ Page Title="" Language="C#" MasterPageFile="~/TrustBank.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register src="CommonControl.ascx" tagname="CommonControl" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Trust Bank Service Request</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Trust Bank Service Request
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ToolkitScriptManager ID="TrustScriptManager" runat="server" CombineScripts="true"
        ScriptMode="Release" EnablePartialRendering="true">
    </asp:ToolkitScriptManager>
    <uc1:CommonControl ID="CommonControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="PanelStatus" runat="server" CssClass="div-error" Visible="true">
                <asp:Label ID="lblStatus" runat="server" Text="" Font-Bold="true"></asp:Label>
            </asp:Panel>
            <asp:Panel ID="Panel1" runat="server">
                <div class="row">
                    <div class="col-md-1 text-center">
                        <img src="Images/Receipt.png" width="42" height="50" />
                    </div>
                    <div class="col-md-11 text-left courier">
                        Please enter the following information to start the service request wizard.<br />
                        <br />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">
                        Request For</label>
                    <div class="col-sm-3">
                        <asp:DropDownList ID="dboReqType" CssClass="form-control" runat="server">
                            <asp:ListItem Text="iBanking Service" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
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
            </asp:Panel>
            <asp:Panel ID="PanelFacebook" runat="server" CssClass="center" style="margin:50px" Visible="false">
                <asp:Literal ID="FB_iFrame" runat="server"></asp:Literal>                
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
<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    Inherits="iBankingRequestShowDetails1" CodeFile="iBankingRequestShowDetails.aspx.cs" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function setReason(txt) {
            $(".iBankingRemarks").each(function () {
                $(this).val(txt);
            });
        }
    </script>
    <script type="text/javascript">
        function onClientUploadComplete(sender, e) {
            var id = e.get_fileId();
            var fileSize = getReadableFileSizeString(e.get_fileSize());
            var fileName = e.get_fileName();
            var ss = "<li><b>" + fileName + "</b> (" + fileSize + ")</li>";
            $('#ContentPlaceHolder2_AjaxFileUpload1').hide();
            $('#attachmentFileList').append(ss);
            $('#attachmentFileList').show();
            $('#ContentPlaceHolder2_cmdUpload').show();
            $('#ContentPlaceHolder2_hidFileID').val($('#ContentPlaceHolder2_hidFileID').val() + id + ',');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    iBanking Service Request Show Details
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <table>
                <tr>
                    <td valign="top">
                        <asp:Panel runat="server" ID="PanelRequester" CssClass="content-back" Style="display: table-cell">
                            <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" CssClass="Grid contentGrid"
                                ForeColor="Black" GridLines="Vertical" AutoGenerateRows="False" DataKeyNames="ReqID"
                                DataSourceID="SqlDataSource1" CellPadding="4" Width="450px">
                                <Fields>
                                    <asp:TemplateField HeaderText="Email" ShowHeader="true">
                                        <ItemTemplate>
                                            <span class="click-to-copy" title="Click to Copy" data-clipboard-text='<%# Eval("Email") %>'>
                                                <%# Eval("Email") %></span>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Requester Name" HeaderStyle-Wrap="false">
                                        <ItemTemplate>
                                            <%# Eval("FullName")%>
                                        </ItemTemplate>
                                        <ItemStyle Font-Size="Large" Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mobile No." ShowHeader="true">
                                        <ItemTemplate>
                                            <span class="click-to-copy" title="Click to Copy" data-clipboard-text='<%# Eval("MobileNo","+{0}")%>'>
                                                <%# Eval("MobileNo","+{0}")%></span>
                                            <%# (Eval("MobileVarified").ToString() == "True") ? "<img src='Images/tick2.png' width='14' height='14' title='verified'>" : ""%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date of Birth" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("DOB","{0:dd/MM/yyyy}")%>
                                            <span style="color: Gray; font-size: 85%; margin-left: 7px">
                                                <%# TrustControl1.getAge( Eval("DOB"))%></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Identity" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("IDTypeName", "{0}")%>:
                                            <%# Eval("IdNumber1", "{0}")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact Address">
                                        <ItemTemplate>
                                            <%# Eval("ContactAddress").ToString().Replace("\n", "<br>") %>
                                            <div class="location-path" style="border-top: 1px dashed silver;">
                                                <%# Eval("DIV_NAME","<span title='Division'>{0}</span>")%>
                                                <%# Eval("DIST_NAME", "» <span title='District'>{0}</span>")%>
                                                <%# Eval("THANA_NAME", "» <span title='Thana'>{0}</span>")%>
                                            </div>
                                            <%# Eval("COUNTRY_NAME", "Country: {0}")%>
                                            <%# Eval("ContactNo", "<br>Contact No: {0}")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Requested On">
                                        <ItemTemplate>
                                            <div title='<%# Eval("ReqDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                                <%# TrustControl1.ToRecentDateTime(Eval("ReqDT"))%>
                                                <time class="timeago" style="padding-left: 7px" datetime='<%# Eval("ReqDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Request Status">
                                        <ItemTemplate>
                                            <%# Eval("Status_Name")%>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Occupation">
                                        <ItemTemplate>
                                            <%# Eval("Occupation")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contact No.">
                                        <ItemTemplate>
                                            <%# Eval("ContactNo")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Browser Info" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("ReqBrowser", "{0}")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Requested IP" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("ReqIP", "{0}")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                <EmptyDataTemplate>
                                    No Data Found.
                                </EmptyDataTemplate>
                                <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" />
                                <FooterStyle BackColor="#CCCC99" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            </asp:DetailsView>
                        </asp:Panel>
                    </td>
                 <%--   <td valign="top" style="padding-left: 20px">
                        <asp:Panel ID="PanelRequestStatus" runat="server" Style="margin-bottom: 10px">
                            <div class="Panel3">
                                <asp:Label Font-Size="110%" Font-Bold="true" ID="lblRequestStatus" runat="server"
                                    Text=""></asp:Label>
                            </div>
                        </asp:Panel>--%>
                      <%--  <div id="uploadDialog">
                            <div style="font-weight: bold; padding-bottom: 10px">
                                If the account signatures are not found in Flora Core Banking System then<br />
                                Scan and Attach Customer's eService Request Form<br />
                                and Submit to Respective Branches
                            </div>
                            <asp:AjaxFileUpload ID="AjaxFileUpload1" runat="server" ViewStateMode="Enabled" OnUploadComplete="AjaxFileUpload1_UploadComplete"
                                OnClientUploadComplete="onClientUploadComplete" MaximumNumberOfFiles="20" EnableViewState="true"
                                Width="450px" AllowedFileTypes="pdf,jpg,jpeg" />
                            <ul id="attachmentFileList" style="display: none; list-style: none; padding-left: 0">
                            </ul>
                            <asp:HiddenField ID="hidFileID" runat="server" />
                            <asp:Button ID="cmdUpload" runat="server" Text="Attach" OnClick="cmdUpload_Click"
                                Width="100px" Height="30px" Style="display: none" />
                        </div>--%>
                       <%-- <asp:Panel ID="PanelAttachment" runat="server">
                            <asp:ListView ID="GridViewAttachment" runat="server" DataSourceID="SqlDataSourceAttachment"
                                DataKeyNames="AID">
                                <ItemTemplate>
                                    <div class="attachment-box">
                                        <div>
                                            <a href='<%# Eval("FileName").ToString().ToLower().EndsWith(".pdf") ? "Pdf.aspx" : "Attachment.ashx" %>?AID=<%# Eval("AID") %>&KEY=<%# Eval("FileKey") %><%# Eval("FileName").ToString().ToLower().EndsWith(".pdf") ? "" : "&view=yes" %>'
                                                target="_blank" title="Show">
                                                <img src='ShowImage.ashx?AID=<%# Eval("AID") %>&KEY=<%# Eval("FileKey") %>&P=1&W=150&H=150&R=1' />
                                            </a>
                                        </div>
                                        <div>
                                            <a href='Attachment.ashx?AID=<%# Eval("AID") %>&KEY=<%# Eval("FileKey") %>&view=yes'
                                                target="_blank" title="View" class="link" style="font-size: 85%"><b>
                                                    <%# Eval("FileName")%></b></a>
                                        </div>
                                        <div class="filesize" style="color: Gray; font-size: 80%">
                                            <%# Eval("FileSize") %>
                                        </div>
                                        <div style="font-size: 85%">
                                            Attached By:
                                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("InsertBy") %>' />
                                        </div>
                                        <div title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                        <asp:LinkButton ID="lnkDeleteBtn" runat="server" CommandName="Delete" ToolTip="Delete"
                                            Visible='<%# isHideDelete() %>'><img alt="Del" src="Images/delete.png" width="16" height="16" border="0" />
                                        </asp:LinkButton>
                                        <asp:ConfirmButtonExtender runat="server" ID="conDelAttach" ConfirmText="Do you want to Delete?"
                                            TargetControlID="lnkDeleteBtn">
                                        </asp:ConfirmButtonExtender>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                            <asp:SqlDataSource ID="SqlDataSourceAttachment" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                                SelectCommand="SELECT [AID], [ReqID], [FileName], [FileSize], [ContentType], [FileKey], [InsertBy], [InsertDT] FROM [Attachments] WHERE ([ReqID] = @ReqID)"
                                OnSelected="SqlDataSourceAttachment_Selected" DeleteCommand="s_Attachment_Delete"
                                DeleteCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="ReqID" QueryStringField="reqid" Type="Int64" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="AID" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                        </asp:Panel>--%>
                      <%--  <asp:Panel ID="PanelUpload" CssClass="PanelUpload" runat="server">
                            <asp:Button ID="cmdSubmitAttach" runat="server" Text="Submit to Respective Branches"
                                Width="200px" Height="35px" OnClick="cmdSubmitAttach_Click" />
                            <asp:ConfirmButtonExtender runat="server" ID="conSubmitToBranch" ConfirmText="Do you want to Submit to Respective Branches?"
                                TargetControlID="cmdSubmitAttach">
                            </asp:ConfirmButtonExtender>
                        </asp:Panel>--%>
                   <%-- </td>--%>
                </tr>
            </table>
            <asp:Panel runat="server" ID="panel2" CssClass="group">
                <h4>
                    iBanking Service Request Info under Email Address</h4>
                <div class="group-body">
                    <asp:GridView ID="grdvAccountList" runat="server" DataKeyNames="ID" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSourceAddAcc" CssClass="Grid" BorderStyle="None" BackColor="White"
                        BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="6" ForeColor="Black" GridLines="Vertical"
                        OnRowCommand="grdvAccountList_RowCommand">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblSL" runat="server" Text='<%# Eval("ID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="#" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div title='<%# Eval("ID") %>'>
                                        <%#Container.DataItemIndex + 1 %></div>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Request ID" SortExpression="ReqID">
                                <ItemTemplate>
                                    <a href='iBankingRequestShow.aspx?reqid=<%# Eval("ReqID") %>' title="View iBanking Request"
                                        target="_blank">
                                        <%# Eval("ReqID")%></a></ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Font-Bold="true" Wrap="false" />
                            </asp:TemplateField>
                            <%-- <asp:TemplateField HeaderText="ReqID" SortExpression="[ReqID]">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="lnkSelect" CausesValidation="False" CommandName="Select"
                                        ToolTip="Open"><%# Eval("[ReqID]")%></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Font-Bold="true" Wrap="false" />
                            </asp:TemplateField>--%>
                            <%--  <asp:TemplateField HeaderText="Full Name" SortExpression="[FullName]">
                                <ItemTemplate>
                                    <span class="click-to-copy" title="Click to Copy" data-clipboard-text='<%# Eval("[FullName]")%>'>
                                        <%# Eval("[FullName]")%></span>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:BoundField HeaderText="Full Name" DataField="FullName" ItemStyle-Wrap="false">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="MobileNo" HeaderText="Mobile No." ItemStyle-HorizontalAlign="Center">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Occupation" HeaderText="Occupation" ItemStyle-HorizontalAlign="Center">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Status_Name" HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Requested On">
                                <ItemTemplate>
                                    <div title='<%# Eval("ReqDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                        <%# TrustControl1.ToRecentDateTime(Eval("ReqDT"))%>
                                        <%--    <time class="timeago" style="padding-left: 7px" datetime='<%# Eval("ReqDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>--%>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ContactAddress" HeaderText="Contact Address" ItemStyle-HorizontalAlign="Center">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                        <EmptyDataTemplate>
                            No Data Found.
                        </EmptyDataTemplate>
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                        <SelectedRowStyle CssClass="GridSelected" BackColor="#FFFF80" />
                        <FooterStyle BackColor="#CCCC99" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>
                </div>
            </asp:Panel>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="s_Request_Master_Submitted_Select" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <%-- <asp:ControlParameter ControlID="txtRequestID" Name="ReqID" PropertyName="Text" />--%>
                    <asp:QueryStringParameter Name="ReqID" QueryStringField="reqid" Type="String" />
                    <asp:SessionParameter SessionField="EMPID" Name="EMPID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="hidSlNo" runat="server" Value="" />
            <asp:SqlDataSource ID="SqlDataSourceAddAcc" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
              
                SelectCommand="[s_LoadiBankingReqDatatoGridEmailWise]" SelectCommandType="StoredProcedure"
                >
                <SelectParameters>
                    <%-- <asp:ControlParameter ControlID="txtRequestID" Name="ReqID" PropertyName="Text" Type="Int64"
                        DefaultValue="-1" Size="20" />--%>
                    <asp:QueryStringParameter Name="ReqID" QueryStringField="reqid" Type="String" />
                </SelectParameters>
            <%--    <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>--%>
            </asp:SqlDataSource>
            <%-------------------------------Start Modal-----------------------------------------------------------%>
            <%-----------------------------------------------------End Modal------------------------------------------------%>
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

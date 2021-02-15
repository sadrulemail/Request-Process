<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    Inherits="iBankingRequestShow" CodeFile="iBankingRequestShow.aspx.cs" %>

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
    iBanking Service Request Show
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:Panel runat="server" ID="panelAddItem" CssClass="Panel1" Style="padding: 2px 7px;
                margin-bottom: 10px; display: inline-table">
                <table>
                    <tr>
                        <td style="margin: 5px; font-weight: bold">
                            Request ID
                        </td>
                        <td style="padding-left: 10px;">
                            <asp:TextBox ID="txtRequestID" runat="server" CssClass="Center" Width="240px" MaxLength="14"
                                Font-Size="X-Large" onfocus="this.select()" placeholder="Request ID"></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender1" TargetControlID="txtRequestID"
                                ValidChars="1234567890">
                            </asp:FilteredTextBoxExtender>
                        </td>
                        <td style="margin: 5x; padding-left: 10px;">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" Width="90px" Height="35px"
                                CommandName="Select" OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table>
                <tr>
                    <td valign="top">
                        <asp:Panel runat="server" ID="PanelRequester" CssClass="content-back" Style="display: table-cell">
                            <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" CssClass="Grid contentGrid"
                                ForeColor="Black" GridLines="Vertical" AutoGenerateRows="False" DataKeyNames="ReqID"
                                DataSourceID="SqlDataSource1" CellPadding="4" Width="450px" OnDataBound="DetailsView1_DataBound">
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
                                        <div style="float:left">
                                            <%# Eval("Status_Name")%>
                                            </div>
                                            <div style="float:right">
                                               
                                                 <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("ReqID","iBankingRequestShowDetails.aspx?reqid={0}") %>' Target="_blank" runat="server"  Visible='<%# isVisibleShowDetails() %>' >Show Details</asp:HyperLink>
                                         
                                            </div>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="true" />
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
                    <td valign="top" style="padding-left: 20px">
                        <asp:Panel ID="PanelRequestStatus" runat="server" Style="margin-bottom: 10px">
                            <div class="Panel3">
                                <asp:Label Font-Size="110%" Font-Bold="true" ID="lblRequestStatus" runat="server"
                                    Text=""></asp:Label>
                            </div>
                        </asp:Panel>
                        <div id="uploadDialog">
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
                        </div>
                        <asp:Panel ID="PanelAttachment" runat="server">
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
                        </asp:Panel>
                        <asp:Panel ID="PanelUpload" CssClass="PanelUpload" runat="server">
                            <asp:Button ID="cmdSubmitAttach" runat="server" Text="Submit to Respective Branches"
                                Width="200px" Height="35px" OnClick="cmdSubmitAttach_Click" />
                            <asp:ConfirmButtonExtender runat="server" ID="conSubmitToBranch" ConfirmText="Do you want to Submit to Respective Branches?"
                                TargetControlID="cmdSubmitAttach">
                            </asp:ConfirmButtonExtender>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
            <asp:Panel runat="server" ID="panel2" CssClass="group">
                <h4>
                    iBanking Service Request Account No List</h4>
                <div class="group-body">
                    <asp:GridView ID="grdvAccountList" runat="server" DataKeyNames="SL" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSourceAddAcc" CssClass="Grid" BorderStyle="None" BackColor="White"
                        BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="6" ForeColor="Black" GridLines="Vertical"
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
                                    <div title='<%# Eval("SL") %>'>
                                        <%#Container.DataItemIndex + 1 %></div>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account No" SortExpression="Accountno">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="lnkSelect" CausesValidation="False" CommandName="Select"
                                        CommandArgument='<%# Eval("Status") %>' ToolTip="Open"><%# Eval("Accountno") %></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Font-Bold="true" Wrap="false" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Customer" SortExpression="Customer">
                                <ItemTemplate>
                                    <span class="click-to-copy" title="Click to Copy" data-clipboard-text='<%# Eval("Customer")%>'>
                                        <%# Eval("Customer")%></span>
                                </ItemTemplate>
                            </asp:TemplateField>
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
                                <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
                            </asp:BoundField>
                        </Columns>
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
                    <br />
                    <asp:Panel runat="server" ID="panelTransferMode" CssClass="group">
                        <h4>
                            iBanking Fund Transfer Options
                        </h4>
                        <div class="group-body">
                            <asp:DetailsView ID="DetailsViewTransactionPrivelage" runat="server" BackColor="White"
                                CssClass="Grid" BorderColor="#DEDFDE" BorderStyle="None" ForeColor="Black" GridLines="Vertical"
                                AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="SqlDataSourceTransactionPrivelage"
                                BorderWidth="1px" CellPadding="5">
                                <Fields>
                                    <asp:TemplateField HeaderText="Fund Transfer is Allowed to">
                                        <ItemTemplate>
                                            <%# Eval("TransactionPrivilege")%>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText=" One Time Password (OTP) for Transaction will go through">
                                        <ItemTemplate>
                                            <%# Eval("OtpGoThrough")%>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                </Fields>
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                <EmptyDataTemplate>
                                    No Option Provided.
                                </EmptyDataTemplate>
                                <FooterStyle BackColor="#CCCC99" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle BackColor="#F7F7DE" />
                            </asp:DetailsView>
                        </div>
                    </asp:Panel>
                    <asp:SqlDataSource ID="SqlDataSourceTransactionPrivelage" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                        SelectCommand="SELECT * FROM iBankingReqOptionPrivilege WHERE ReqID=@ReqID">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ReqID" QueryStringField="reqid" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>
            <%--    </div>
                </div>
            </asp:Panel>--%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="s_Request_Master_Submitted_Select" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtRequestID" Name="ReqID" PropertyName="Text" />
                    <asp:SessionParameter SessionField="EMPID" Name="EMPID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="hidSlNo" runat="server" Value="" />
            <asp:SqlDataSource ID="SqlDataSourceAddAcc" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                DeleteCommand="Update iBanking_Req SET status=3 WHERE SL=@SL" DeleteCommandType="Text"
                SelectCommand="s_LoadiBankingReqDatatoGridReqIDWise" SelectCommandType="StoredProcedure"
                OnDeleted="SqlDataSourceAddAcc_Deleted">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtRequestID" Name="ReqID" PropertyName="Text" Type="Int64"
                        DefaultValue="-1" Size="20" />
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
                            <asp:TemplateField HeaderText="Request ID" SortExpression="ReqID">
                                <ItemTemplate>
                                    <%# Eval("ReqID") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblReqID" runat="server" Text='<%# Bind("ReqID") %>'></asp:Label>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account No" SortExpression="Accountno">
                                <ItemTemplate>
                                    <span style="font-size: 120%; font-weight: bold" class="click-to-copy" title="Click to Copy"
                                        data-clipboard-text='<%# Eval("Accountno")%>'>
                                        <%# Eval("Accountno")%></span> Customer ID: <span class="click-to-copy" title="Click to Copy"
                                            data-clipboard-text='<%# Eval("Customer")%>'>
                                            <%# Eval("Customer")%></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="acname" HeaderText="Account Name" SortExpression="acname"
                                ReadOnly="true">
                                <ItemStyle Font-Bold="false" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ReqType" HeaderText="Request Type" SortExpression="ReqType"
                                ReadOnly="true">
                                <ItemStyle Font-Bold="false" />
                            </asp:BoundField>
                            <%-- <asp:BoundField DataField="AlllowFund" HeaderText="Allow Fund" SortExpression="AlllowFund"
                                ReadOnly="true">
                                <ItemStyle Font-Bold="false" />
                            </asp:BoundField>--%>
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
                                    <asp:GridView ID="GridViewReasonOfUnpaid" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                                        BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px"
                                        CellPadding="3" DataSourceID="SqlDataSourceReason" GridLines="Vertical" ShowHeader="False">
                                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <a style="cursor: pointer" onclick="javascript:setReason('<%# Eval("Remarks") %>')">
                                                        <%# Eval("Remarks")%></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <AlternatingRowStyle BackColor="#DCDCDC" />
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="SqlDataSourceReason" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                                        SelectCommand="SELECT [Remarks] FROM [iBanking_Remarks] WHERE   ho_br = @ho_br ORDER BY Order_By">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="hiddenFieldBranch" Name="ho_br" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:TextBox CssClass="iBankingRemarks" ID="txtRemarks" runat="server" Width="350px"
                                        Font-Bold="true" Style="height: 22px" Text='<%# Bind("Remarks") %>' MaxLength="255"></asp:TextBox>
                                    <asp:DropDownExtender ID="DropDownExtendertxtUnpaidReason" runat="server" DropDownControlID="GridViewReasonOfUnpaid"
                                        DynamicServicePath="" Enabled="True" TargetControlID="txtRemarks">
                                    </asp:DropDownExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorRemarks" runat="server" ControlToValidate="txtRemarks"
                                        ErrorMessage="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
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
            <asp:ModalPopupExtender ID="modal" runat="server" CancelControlID="ModalClose" TargetControlID="cmdPopup"
                PopupControlID="ModalPanel" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="ModalTitleBar"
                RepositionMode="RepositionOnWindowResize" X="-1" Y="1" CacheDynamicResults="False"
                Drag="false">
            </asp:ModalPopupExtender>
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
                    <%--  <asp:Parameter Name="Remarks" Type="String" />--%>
                    <asp:Parameter Name="Remarks" Size="255" Type="String" />
                    <asp:Parameter DefaultValue="" Direction="InputOutput" Name="Msg" Size="255" Type="String" />
                    <asp:Parameter DefaultValue="false" Direction="InputOutput" Name="Done" Type="Boolean" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="hiddenFieldBranch" runat="server" />
            <asp:HiddenField ID="hiddenFieldSubmittedRequest" runat="server" />
            <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="[s_Status_Type_BrWise]" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hiddenFieldBranch" Name="ho_br" PropertyName="Value" />
                    <asp:ControlParameter ControlID="grdvAccountList" Name="SL" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
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

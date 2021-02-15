<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    Inherits="RequestSearchByAccount" CodeFile="RequestSearchByAccount.aspx.cs" %>

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
    Request Search By Account
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
                            Account No
                        </td>
                        <td style="padding-left: 10px;">
                            <asp:TextBox ID="txtAccountNo" runat="server" CssClass="Center" Width="240px" MaxLength="15" required
                                Font-Size="X-Large" onfocus="this.select()"></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender1" TargetControlID="txtAccountNo"
                                ValidChars="1234567890-">
                            </asp:FilteredTextBoxExtender>
                        </td>
                        <td style="margin: 5x; padding-left: 10px;">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" Width="90px" Height="35px"
                                CommandName="Select" OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
           
          <%--  <asp:Panel runat="server" ID="panel2" CssClass="group">
                <h4>
                    iBanking Service Request under this Account </h4>
                <div class="group-body">--%>
                    <asp:GridView ID="grdvAccountList" runat="server" DataKeyNames="SL" AutoGenerateColumns="False"
                DataSourceID="SqlDataSourceAddAcc" CssClass="Grid" BorderStyle="None" BackColor="White"
                BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="true" PagerSettings-Position="TopAndBottom"
                PageSize="10" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="20">
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
                    <asp:TemplateField HeaderText="Request ID" SortExpression="ReqID">
                        <ItemTemplate>
                            <a href='iBankingRequestShow.aspx?reqid=<%# Eval("ReqID") %>' title="View iBanking Request"
                                target="_blank">
                                <%# Eval("ReqID")%></a></ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Font-Bold="true" Wrap="false" />
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Account No" DataField="Accountno" SortExpression="Accountno"
                        ItemStyle-Wrap="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Requested By" DataField="Fullname" SortExpression="Fullname"
                        ItemStyle-Wrap="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Email & Mobile" SortExpression="Email">
                        <ItemTemplate>
                            <%# Eval("Email","<div>{0}</div>") %>
                            <%# Eval("MobileNo", "<div>+{0}</div>")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ReqType" HeaderText="Req Type" SortExpression="ReqType"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Status_Name" HeaderText="Status" SortExpression="Status_Name">
                        <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Request On" SortExpression="ReqDT">
                        <ItemTemplate>
                            <div title='<%# Eval("ReqDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("ReqDT"))%><br />
                                <time class="timeago" datetime='<%# Eval("ReqDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                        <ItemStyle ForeColor="Gray" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Modify" SortExpression="LastModified">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("LastModifiedBy") %>' />
                            <div title='<%# Eval("LastModified", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("LastModified"))%><br />
                                <time class="timeago" datetime='<%# Eval("LastModified","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
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
             
                    
                 <asp:SqlDataSource ID="SqlDataSourceAddAcc" runat="server" ConnectionString="<%$ ConnectionStrings:Request_ProcessConnectionString %>"
                SelectCommand="s_iBanking_RequestSearchByAccount" SelectCommandType="StoredProcedure">
                <SelectParameters>
                 
                    <asp:ControlParameter ControlID="txtAccountNo" Name="AccountNo" PropertyName="Text" Type="String"
                        Size="255" />
                  
                </SelectParameters>
            </asp:SqlDataSource>
        <%--        </div>
            </asp:Panel>
         --%>
        
 
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

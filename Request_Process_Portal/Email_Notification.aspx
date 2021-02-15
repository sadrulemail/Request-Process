<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Email_Notification.aspx.cs" Inherits="Email_Notification" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Literal ID="litTitle" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <table>
                <tr>
                    <td valign="top">
                        <table class="Panel1">
                            <tr>
                                <td class="bold">
                                    Account
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAcc" MaxLength="15" Font-Size="Medium" Width="200px" runat="server"
                                        placeholder="account number" onfocus="select()" 
                                        ontextchanged="txtAcc_TextChanged1" CausesValidation="false" AutoPostBack="true" ></asp:TextBox>
                                    <asp:Button ID="cmdShow" runat="server" Text="Show" OnClick="cmdShow_Click" />
                                    <asp:Label ID="lblAccName" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="bold" valign="top">
                                    Email
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmail" MaxLength="255" runat="server" Width="300px" placeholder="email address"></asp:TextBox>
                                    <asp:LinkButton ID="cmdEmail" runat="server" ToolTip="Add Email" OnClick="cmdEmail_Click"><img src="Images/add.gif" /></asp:LinkButton>
                                    <asp:LinkButton ID="cmdEmailRemove" runat="server" ToolTip="Remove Email" OnClick="cmdEmailRemove_Click"><img src="Images/delete.png" /></asp:LinkButton>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail1" runat="server"
                                        ForeColor="Red" Font-Bold="true" Display="Dynamic" ControlToValidate="txtEmail"
                                        ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    <br />
                                    <asp:Label ID="lblEmails" runat="server" Text="" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="bold">
                                    Reference
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRemarks" MaxLength="255" runat="server" Width="300px" placeholder="remarks/reason"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="bold" valign="top">
                                    Types
                                </td>
                                <td>
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SMSConnectionString %>"
                                        ProviderName="<%$ ConnectionStrings:SMSConnectionString.ProviderName %>" SelectCommand="s_EmailNotification_Check"
                                        SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="txtAcc" Name="AccountNo" PropertyName="Text" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow"
                                        BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataSourceID="SqlDataSource2"
                                        ForeColor="Black" CssClass="Grid" GridLines="None">
                                        <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                        <Columns>
                                            <asp:BoundField DataField="TransactionAlertCatagoryID" HeaderText="#" ReadOnly="True"
                                                SortExpression="TransactionAlertCatagoryID" />
                                            <asp:BoundField DataField="TransactionAlertCatagory" HeaderText="Notification Catagory"
                                                SortExpression="TransactionAlertCatagory" ItemStyle-HorizontalAlign="Left" />
                                            <asp:TemplateField HeaderText="CR" SortExpression="CR">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkCR" runat="server" Checked='<%# Bind("CR") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DR" SortExpression="DR">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkDR" runat="server" Checked='<%# Bind("DR") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="Tan" Font-Bold="True" ForeColor="White" />                                        
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button ID="cmdOK" runat="server" Text="Activate Email Notification" OnClick="cmdOK_Click" Height="30px" Enabled="false" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top" style="padding-left: 10px">
                        <asp:DetailsView ID="DetailsView3" runat="server" AutoGenerateRows="false" BackColor="White"
                            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="AccountNo"
                            DataSourceID="SqlDataSource3" ForeColor="Black" GridLines="Vertical" CssClass="Grid hide-blank-detailsview"
                            OnDataBound="DetailsView3_DataBound">
                            <Fields>
                                <asp:TemplateField HeaderText="A/C Name" ShowHeader="false" ItemStyle-CssClass="donothide">
                                    <ItemTemplate>
                                        <%# Eval("acName") %>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="true" Font-Size="Medium" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type">
                                    <ItemTemplate>
                                        <%# Eval("glhead","<div width:'100%'>{0}</div>")%>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="width100" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" SortExpression="Status">
                                    <ItemTemplate>
                                        <%# Eval("Status") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email(s)" SortExpression="Email">
                                    <ItemTemplate>
                                        <%# Eval("Email").ToString().Replace(";","<br>") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Added by">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="false" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Added on">
                                    <ItemTemplate>
                                        <div title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <%# TrustControl1.ToRecentDateTime(Eval("InsertDT"))%><br />
                                            <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="false" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Update by">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("EditBy") %>' />
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="false" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Update on">
                                    <ItemTemplate>
                                        <div title='<%# Eval("EditDate", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <%# TrustControl1.ToRecentDateTime(Eval("EditDate"))%><br />
                                            <time class="timeago" datetime='<%# Eval("EditDate","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="false" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="AutoActivated" HeaderText="Auto Added" HeaderStyle-Wrap="false">
                                </asp:BoundField>
                                <asp:BoundField DataField="Reference" HeaderText="Reference"
                                    ItemStyle-Font-Bold="true" />
                            </Fields>
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White"  />
                            <RowStyle BackColor="#FAFAD2" VerticalAlign="Top" />
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SMSConnectionString %>"
                            ProviderName="<%$ ConnectionStrings:SMSConnectionString.ProviderName %>" SelectCommand="s_EmailNotification_AccountInfo"
                            SelectCommandType="StoredProcedure" onselected="SqlDataSource3_Selected">
                            <SelectParameters>
                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                <asp:QueryStringParameter Name="AccountNo" QueryStringField="acc" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" DataKeyNames="AccountNo,TransactionType,DrCr"
                DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="TransactionType" HeaderText="Trn Type" ReadOnly="True"
                        SortExpression="TransactionType" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="TransactionAlertCatagory" HeaderText="Type Name" ReadOnly="True"
                        SortExpression="TransactionAlertCatagory" />
                    <asp:BoundField DataField="DrCr" HeaderText="DrCr" ReadOnly="True" SortExpression="DrCr"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="AutoPermission" HeaderText="Auto" SortExpression="AutoPermission"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="Inserted By" SortExpression="InsertBy">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Inserted on" SortExpression="InsertDate">
                        <ItemTemplate>
                            <div title='<%# Eval("InsertDate", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("InsertDate"))%><br />
                                <time class="timeago" datetime='<%# Eval("InsertDate","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Edited By" SortExpression="EditBy">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("EditBy") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Edited on" SortExpression="EditDate">
                        <ItemTemplate>
                            <div title='<%# Eval("EditDate", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("EditDate"))%><br />
                                <time class="timeago" datetime='<%# Eval("EditDate","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SMSConnectionString %>"
                ProviderName="<%$ ConnectionStrings:SMSConnectionString.ProviderName %>" SelectCommand="s_EmailNotification_Select"
                SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtAcc" Name="AccountNo" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
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

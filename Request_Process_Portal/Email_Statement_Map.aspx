<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" 
    AutoEventWireup="true" CodeFile="Email_Statement_Map.aspx.cs" 
    Inherits="Email_Statement_Map" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="CommonControl.ascx" TagName="CommonControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    eStatement Email Mapping
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:Panel runat="server" ID="panelAddItem" CssClass="Panel1" Style="padding: 6px;
                margin-bottom: 20px; display: inline-block" Min-Height="120px">
                <table>
                    <tr>
                        <td>
                        <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                            SelectCommand="SELECT BranchID_CBS BranchID, BranchName FROM ViewBranch where CommonBranchID = @BranchID OR @BranchID = 1 ORDER BY BranchName">
                            <SelectParameters>
                                <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:Florabank_OnlineConnectionString %>"
                            SelectCommand="SELECT classcode, classname FROM aclass ORDER BY classname">
                            
                        </asp:SqlDataSource>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceBranch"
                            DataTextField="BranchName" DataValueField="BranchID" 
                            OnDataBound="DropDownList1_DataBound" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="All Branch" Value="*"></asp:ListItem>
                        </asp:DropDownList>
                        </td>
                        <td style="padding-left: 15px;">
                            <asp:TextBox ID="txtAccountNo" runat="server" Width="120px" Watermark="a/c number" MaxLength="15"></asp:TextBox>
                            <asp:TextBox ID="txtCustomerID" runat="server" Width="100px" Watermark="customer id" MaxLength="10"></asp:TextBox>
                        </td>
                       <td>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource4"
                            DataTextField="classname" DataValueField="classcode" 
                            OnDataBound="DropDownList1_DataBound" AppendDataBoundItems="true">
                            <asp:ListItem Text="All Types" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                       </td>
                        
                    </tr>
                </table>
                <table><tr><td>
                <asp:TextBox ID="txtEmail" runat="server" Width="300px" placeholder="email address"></asp:TextBox>
                </td><td style="padding-left:10px">
                <asp:Button ID="Button1" runat="server" Text="Search" Width="70px" CausesValidation="false"
                                OnClick="btnSearch_Click" />
                                </td></tr></table>
            </asp:Panel>
            <asp:TabContainer runat="server" ID="TabContainer1" OnDemand="true" CssClass="NewsTab hidden-print" >
                <asp:TabPanel runat="server" ID="tab1">
                    <HeaderTemplate>Authorize Pending</HeaderTemplate>
                    <ContentTemplate>
                    
           <div style="margin-bottom:10px">Check the email addresses of each customer and click Authorize button to confirm regular eStatement receive.
            </div>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SMSConnectionString %>"
                SelectCommand="s_Email_eStatement_Error" SelectCommandType="StoredProcedure" 
                OnSelected="SqlDataSource1_Selected"
                DeleteCommand="s_Email_eStatement_Mapping_Authorize" 
                DeleteCommandType="StoredProcedure" ondeleted="SqlDataSource1_Deleted">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtAccountNo" Name="AccountNo" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                    <asp:ControlParameter ControlID="txtCustomerID" Name="CustomerID" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="BranchID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList2" Name="ClassCode" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Customer" Type="String" />
                    <asp:Parameter Name="Msg" Direction="InputOutput" Size="255" DefaultValue="*" />
                    <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />                    
                    <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />        
                </DeleteParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Customer"
                DataSourceID="SqlDataSource1" CssClass="Grid" BorderStyle="None" BackColor="White"
                BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="True"
                PageSize="25" onrowdatabound="GridView1_RowDataBound" 
                            onrowcommand="GridView1_RowCommand">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                   <asp:TemplateField HeaderText="Customer" SortExpression="Customer">
                        <ItemTemplate>
                            <a target="_blank" href='<%# ConfigurationManager.AppSettings["HOME"] %>/goAML/Customer.aspx?id=<%# Eval("Customer") %>'><%# Eval("Customer")%></a>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>                    
                   <asp:TemplateField HeaderText="Title" SortExpression="Title">
                        <ItemTemplate>
                            <%# Eval("Title")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Customer Name" SortExpression="CustomerName">
                        <ItemTemplate>
                            <%# Eval("CustomerName")%>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:BoundField HeaderText="Email1" DataField="Email1" SortExpression="Email1">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Email2" DataField="Email2" SortExpression="Email2">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                        <asp:Panel ID="PanelApprove" runat="server">
                            <asp:LinkButton ID="BtnDelete" runat="server" CommandName="Delete" ToolTip="Authorize" 
                                CommandArgument='<%# Eval("Customer") %>' >
                                <img src="Images/tick.png" width="20" height="20" />Authorize
                            </asp:LinkButton>
                             <asp:ConfirmButtonExtender runat="server" ID="conBtnDelete" ConfirmText="Do you want to Authorize for eStatement?"
                                TargetControlID="BtnDelete">
                            </asp:ConfirmButtonExtender>
                            </asp:Panel>
                            <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red"></asp:Label>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                   
                </Columns>
                <EmptyDataTemplate>
                    No Data Found.
                </EmptyDataTemplate>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" 
                    PageButtonCount="20" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                <FooterStyle BackColor="#CCCC99" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small"></asp:Label>
            
            </ContentTemplate>
                </asp:TabPanel> 
                <asp:TabPanel runat="server" ID="tab2">
                    <HeaderTemplate>No Email List</HeaderTemplate>
                    <ContentTemplate>    
                    <div style="margin-bottom:10px">
                        No email address is saved in the system of the following customers. It is not possible to send them eStatement.
                    </div>
                    <asp:GridView ID="GridView2" runat="server" DataKeyNames="customer" AutoGenerateColumns="False"
                DataSourceID="SqlDataSource2" CssClass="Grid" BorderStyle="None" BackColor="White"
                BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="true" PagerSettings-Position="TopAndBottom"
                PageSize="25" PagerSettings-Mode="NumericFirstLast" 
                PagerSettings-PageButtonCount="20" >
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                   <asp:TemplateField HeaderText="Customer" SortExpression="Customer">
                        <ItemTemplate>
                            <a target="_blank" href='../goAML/Customer.aspx?id=<%# Eval("Customer") %>'><%# Eval("Customer")%></a>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>                    
                   <asp:TemplateField HeaderText="Title" SortExpression="Title">
                        <ItemTemplate>
                            <%# Eval("Title")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Customer Name" SortExpression="CustomerName">
                        <ItemTemplate>
                            <%# Eval("CustomerName")%>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                      <asp:BoundField HeaderText="Email1" DataField="Busi_Email" SortExpression="Busi_Email"
                       ReadOnly="true" HtmlEncode="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                     <asp:BoundField HeaderText="Email2" DataField="per_email" SortExpression="per_email"
                       ReadOnly="true" HtmlEncode="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>                
                    
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
            <asp:Label ID="Label2" runat="server" Text="" Font-Size="Small"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SMSConnectionString %>"
                SelectCommand="s_Email_eStatement_NoEmail" SelectCommandType="StoredProcedure" 
                OnSelected="SqlDataSource2_Selected"
                UpdateCommand="" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtAccountNo" Name="AccountNo" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                    <asp:ControlParameter ControlID="txtCustomerID" Name="CustomerID" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="BranchID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList2" Name="ClassCode" PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Msg" Direction="InputOutput" Size="255" DefaultValue="*" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Reason" Size="255" />
                </UpdateParameters>
            </asp:SqlDataSource>
                     </ContentTemplate>      
                    </asp:TabPanel>
                
                <asp:TabPanel runat="server" ID="tab3">
                    <HeaderTemplate>Authorized Emails</HeaderTemplate>
                    <ContentTemplate>  
                    <div style="margin-bottom:10px">
                  
                        Authorised email list.
                        </div>
                        
                         <asp:GridView ID="GridView3" runat="server" DataKeyNames="ID" AutoGenerateColumns="False"
                DataSourceID="SqlDataSource3" CssClass="Grid" BorderStyle="None" BackColor="White"
                BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="true" PagerSettings-Position="TopAndBottom"
                PageSize="25" PagerSettings-Mode="NumericFirstLast" 
                PagerSettings-PageButtonCount="20" >
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                   <asp:TemplateField HeaderText="Customer" SortExpression="CustomerID">
                        <ItemTemplate>
                            <a target="_blank" href='../goAML/Customer.aspx?id=<%# Eval("CustomerID") %>'><%# Eval("CustomerID")%></a>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>                    
                  <asp:TemplateField HeaderText="Account No" SortExpression="AccountNo">
                        <ItemTemplate>
                        <%# Eval("AccountNo").ToString() == "*" ? "<div title='All Accounts'>*</div>" : "<a target='_blank' href='../goAML/Account.aspx?account=" + Eval("AccountNo") + "'>" + Eval("AccountNo") + "</a>"%>
                           
                        </ItemTemplate>
                        <ItemStyle Wrap="False" HorizontalAlign="Center" />
                    </asp:TemplateField>       
                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                        <ItemTemplate>
                            <%# Eval("Name")%>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                      <asp:BoundField HeaderText="Email" DataField="Email" SortExpression="Email"
                       ReadOnly="true" HtmlEncode="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                     <asp:BoundField HeaderText="Repeat" DataField="RepeatType" SortExpression="RepeatType"
                       ReadOnly="true" >
                        <ItemStyle Wrap="False" HorizontalAlign="Center" />
                    </asp:BoundField>                
                     <asp:TemplateField HeaderText="Insert" SortExpression="InsertDT">
                        <ItemTemplate>
                            <div title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("InsertDT"))%><br />
                                <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                        <ItemStyle ForeColor="Gray" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="By" SortExpression="InsertBy">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />                            
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delete" >
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete"><img alt="Delete" src="Images/delete.png" /></asp:LinkButton>                            
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
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
            <asp:Label ID="Label3" runat="server" Text="" Font-Size="Small"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SMSConnectionString %>"
                SelectCommand="s_Email_eStatement_Authorized_List" SelectCommandType="StoredProcedure" 
                OnSelected="SqlDataSource3_Selected"
                UpdateCommand="" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtAccountNo" Name="AccountNo" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                    <asp:ControlParameter ControlID="txtCustomerID" Name="CustomerID" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="BranchID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList2" Name="ClassCode" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Msg" Direction="InputOutput" Size="255" DefaultValue="*" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Reason" Size="255" />
                </UpdateParameters>
            </asp:SqlDataSource>
                   
                    </ContentTemplate>
                    </asp:TabPanel>
            </asp:TabContainer>
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


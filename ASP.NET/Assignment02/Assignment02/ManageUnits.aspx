<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageUnits.aspx.cs" Inherits="Assignment02.ManageUnits" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="height: 379px">
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="UnitCode" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" ShowFooter="True">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="UnitCode" SortExpression="UnitCode">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("UnitCode") %>'></asp:Label>
                        </EditItemTemplate>
                        <FooterTemplate>    
                            <asp:TextBox ID="txtUnitCode" runat="server" MaxLength="7" Width="70px"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valUnitCode1" ControlToValidate="txtUnitCode" ValidationExpression="^[A-Z]{3}[0-9]{4}$" ErrorMessage ="Format ABC1234!" runat="server"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="valUnitCode2" ControlToValidate="txtUnitCode" runat="server" ErrorMessage="Required!"></asp:RequiredFieldValidator>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("UnitCode") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="UnitTitle" SortExpression="UnitTitle">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("UnitTitle") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valUnitTitle1" ControlToValidate="TextBox1" runat="server" ErrorMessage="Required!" ForeColor="Red" ValidationGroup="VG1">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtUnitTitle" runat="server" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valUnitTitle2" ControlToValidate="txtUnitTitle" runat="server" ErrorMessage="Required!"></asp:RequiredFieldValidator>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("UnitTitle") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="UnitCoordinator" SortExpression="UnitCoordinator">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("UnitCoordinator") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valUnitCoordinator1" runat="server" ControlToValidate="TextBox2" ErrorMessage="Required!" ForeColor="Red" ValidationGroup="VG1">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtUnitCoordinator" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valUnitCoordinator2" runat="server" ControlToValidate="txtUnitCoordinator" ErrorMessage="Requried!"></asp:RequiredFieldValidator>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("UnitCoordinator") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="UnitOutlinePDFDocument" SortExpression="UnitOutlinePDFDocument">
                        <EditItemTemplate>
                            <asp:FileUpload ID="FileUpload2" runat="server" />
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:HyperLink ID="Label4" runat="server" NavigateUrl="#" Text='<%# Eval("UnitOutlinePDFDocument") %>'></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Manage Options" ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="VG1"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Insert" />
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"  OnClientClick="return confirm('Are you sure you wish to DELETE this record?');" AlternateText="Delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#F7F7DE" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:ValidationSummary ID ="VS01" ForeColor ="Red" runat ="server" Height="45px" />
            <br />
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Assignment02ConnectionString %>" DeleteCommand="DELETE FROM [UnitsModule] WHERE [UnitCode] = @UnitCode" InsertCommand="INSERT INTO [UnitsModule] ([UnitCode], [UnitTitle], [UnitCoordinator], [UnitOutlinePDFDocument]) VALUES (@UnitCode, @UnitTitle, @UnitCoordinator, @UnitOutlinePDFDocument)" SelectCommand="SELECT * FROM [UnitsModule]" UpdateCommand="UPDATE [UnitsModule] SET [UnitTitle] = @UnitTitle, [UnitCoordinator] = @UnitCoordinator, [UnitOutlinePDFDocument] = @UnitOutlinePDFDocument WHERE [UnitCode] = @UnitCode">
            <DeleteParameters>
                <asp:Parameter Name="UnitCode" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UnitCode" Type="String" />
                <asp:Parameter Name="UnitTitle" Type="String" />
                <asp:Parameter Name="UnitCoordinator" Type="String" />
                <asp:Parameter Name="UnitOutlinePDFDocument" Type="Object" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="UnitTitle" Type="String" />
                <asp:Parameter Name="UnitCoordinator" Type="String" />
                <asp:Parameter Name="UnitOutlinePDFDocument" Type="Object" />
                <asp:Parameter Name="UnitCode" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:LinkButton ID="lnkLoginPage" runat="server" OnClick="lnkLoginPage_Click" CausesValidation="False">&lt;&lt; Log Out</asp:LinkButton>
    </form>
</body>
</html>

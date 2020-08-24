<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageLogin.aspx.cs" Inherits="Assignment02.ManageLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="UserID: "></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtUserID" runat="server"></asp:TextBox>
            <br />
            <br />
        </div>
        <asp:Label ID="Label2" runat="server" Text="Password: "></asp:Label>
&nbsp;<asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Assignment02ConnectionString %>" SelectCommand="SELECT * FROM [LoginModule] WHERE (([UserID] = @UserID) AND ([UserPassword] = @UserPassword))">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtUserID" Name="UserID" PropertyName="Text" Type="Int16" />
                <asp:ControlParameter ControlID="txtPassword" Name="UserPassword" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>

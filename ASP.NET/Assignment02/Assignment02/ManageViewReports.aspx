<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageViewReports.aspx.cs" Inherits="Assignment02.ManageViewReports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 524px; width: 879px">
            <asp:Label ID="Label1" runat="server" Text="Search Criteria: "></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="StudentID: "></asp:Label>
&nbsp;<asp:TextBox ID="txtStudentID" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Unit Code: "></asp:Label>
&nbsp;<asp:TextBox ID="txtUnitCode" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Semester: "></asp:Label>
&nbsp;&nbsp;
            <asp:TextBox ID="txtSemester" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="Year:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtYear" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" />
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
            <br />
            <asp:Label ID="Label6" runat="server"></asp:Label>
            <br />
            <asp:Label ID="Label7" runat="server"></asp:Label>
            <br />
            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" OnClick="LinkButton2_Click">&lt;&lt; Manage Results</asp:LinkButton>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" OnClick="LinkButton1_Click">LogOut &gt;&gt;</asp:LinkButton>
            <br />
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Assignment02ConnectionString %>" SelectCommand="SELECT * FROM [ResultsModule]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>

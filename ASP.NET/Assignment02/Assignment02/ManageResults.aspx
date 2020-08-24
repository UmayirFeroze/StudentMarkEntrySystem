<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageResults.aspx.cs" Inherits="Assignment02.ManageResults" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 503px;
            width: 1386px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="UnitCode,StudentID" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" ShowFooter="True" style="margin-right: 3px">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="UnitCode" SortExpression="UnitCode">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("UnitCode") %>'></asp:Label>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtUnitCode" runat="server" MaxLength="7" Width="70px"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valUnitCode1" runat="server" ControlToValidate="txtUnitCode" ValidationExpression="^[A-Z]{3}[0-9]{4}$" ErrorMessage ="Format ABC1234!" ForeColor="Red" Text="*"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="valUnitCode2" runat="server" ControlToValidate="txtUnitCode" ErrorMessage="Required!" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("UnitCode") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="StudentID" SortExpression="StudentID">
                        <EditItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("StudentID") %>'></asp:Label>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtStudentID" runat="server" MaxLength="8" TextMode="Number" Width="70px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valStudentID1" runat="server" ControlToValidate="txtStudentID" ErrorMessage="Required!"  ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="valStudentID2" runat="server" ControlToValidate="txtStudentID" ValidationExpression="^[0-9]{8}$" ErrorMessage="08 digits!"  ForeColor="Red" Text="*"></asp:RegularExpressionValidator>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("StudentID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="StudentPhoto" SortExpression="StudentPhoto">
                        <EditItemTemplate>
                            <asp:FileUpload ID="FileUpload2" runat="server" />
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Image ID="Label8" runat="server" ImageUrl='<%# Eval("StudentPhoto") %>'></asp:Image>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Semester" SortExpression="Semester">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Semester") %>' ValidationGroup="VG1" MaxLength="1" TextMode="Number" Width="30px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valSemester1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Required!"  ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="valSemester2" runat="server" ControlToValidate="TextBox1" ErrorMessage="01 digit!" ValidateExpression="^[1-2]{1}$"  ForeColor="Red" Text="*"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtSemester" runat="server" MaxLength="1" TextMode="Number" Width="30px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valSemester3" runat="server" ControlToValidate="txtSemester" ErrorMessage="Required!"  ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="valSemester4" runat="server" ControlToValidate="txtSemester" ValidationExpression="^[1-2]{1}$" ErrorMessage="01 digit"  ForeColor="Red" Text="*" ></asp:RegularExpressionValidator>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Semester") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Year" SortExpression="Year">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Year") %>' ValidationGroup="VG1" MaxLength="4" TextMode="Number" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valYear1" runat="server" ControlToValidate="TextBox2" ErrorMessage="Required!"  ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="valYear2" runat="server" ControlToValidate="TextBox2" ValidationExpression="^[0-9]{4}$" ErrorMessage="Invalid Year!"  ForeColor="Red" Text="*"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtYear" runat="server" MaxLength="4" TextMode="Number" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valYear3" runat="server" ControlToValidate="txtYear" ErrorMessage="Required!"  ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="valYear4" runat="server" ControlToValidate="txtYear" ValidationExpression="^[0-9]{4}$" ErrorMessage="Invlaid Year!"  ForeColor="Red" Text="*" ></asp:RegularExpressionValidator> 
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Year") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Assessment1Score" SortExpression="Assessment1Score">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Assessment1Score") %>' ValidationGroup="VG1" MaxLength="2" TextMode="Number" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valA1Score1" runat="server" ControlToValidate="TextBox3" ErrorMessage="Required!"  ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="valA1Score2" runat="server" ControlToValidate="TextBox3" Type="Integer" MinimumValue="0" MaximumValue="20" ErrorMessage="Range 0-20!"  ForeColor="Red" Text="*"></asp:RangeValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtAssessment1Score" runat="server" MaxLength="2" TextMode="Number" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valA1Score3" runat="server" ControlToValidate="txtAssessment1Score" ErrorMessage="Required!" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="valA1Score4" runat="server" ControlToValidate="txtAssessment1Score" Type="Integer" MinimumValue="0" MaximumValue="20" ErrorMessage="Range 0-20!" ForeColor="Red" Text="*"></asp:RangeValidator>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("Assessment1Score") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Assessment2Score" SortExpression="Assessment2Score">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Assessment2Score") %>' ValidationGroup="VG1" MaxLength="2" TextMode="Number" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valA2Score1" runat="server" ControlToValidate="TextBox4" ErrorMessage="Required!" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="valA2Score2" runat="server" ControlToValidate="TextBox4" Type="Integer" MinimumValue="0" MaximumValue="20" ErrorMessage="Range 0-20" ForeColor="Red" Text="*"></asp:RangeValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtAssessment2Score" runat="server" MaxLength="2" TextMode="Number" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valA2Score3" runat="server" ControlToValidate="txtAssessment2Score" ErrorMessage="Required!" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="valA2Score4" runat="server" ControlToValidate="txtAssessment2Score" Type="Integer" MinimumValue="0" MaximumValue="20" ErrorMessage="Range 0-20!" ForeColor="Red" Text="*"></asp:RangeValidator>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("Assessment2Score") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ExamScore" SortExpression="ExamScore">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("ExamScore") %>' ValidationGroup="VG1" MaxLength="2" TextMode="Number" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valExamScore1" runat="server" ControlToValidate="TextBox5" ErrorMessage="Required!" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="valExamScore2" runat="server" ControlToValidate="TextBox5" Type="Integer" MinimumValue="0" MaximumValue="60" ErrorMessage="Range 0-60" ForeColor="Red" Text="*"></asp:RangeValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtExamScore" runat="server" MaxLength="2" TextMode="Number" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valExamScore3" runat="server" ControlToValidate="txtExamScore" ErrorMessage="Required!" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="valExamScore4" runat="server" ControlToValidate="txtExamScore" Type="Integer" MinimumValue="0" MaximumValue="60" ErrorMessage="Range 0-60" ForeColor="Red" Text="*"></asp:RangeValidator>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("ExamScore") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="UnitMarks" HeaderText="UnitMarks" SortExpression="UnitMarks" />
                    <asp:TemplateField HeaderText="Manage Results" ShowHeader="False">
                        <EditItemTemplate>
                             <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="VG1"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:Button ID="btnInsert" runat="server" OnClick="btnInsert_Click" Text="Insert" />
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you wish to DELETE this record?');" AlternateText="Delete"></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Assignment02ConnectionString %>" DeleteCommand="DELETE FROM [ResultsModule] WHERE [UnitCode] = @UnitCode AND [StudentID] = @StudentID" InsertCommand="INSERT INTO [ResultsModule] ([UnitCode], [StudentID], [StudentPhoto], [Semester], [Year], [Assessment1Score], [Assessment2Score], [ExamScore]) VALUES (@UnitCode, @StudentID, @StudentPhoto, @Semester, @Year, @Assessment1Score, @Assessment2Score, @ExamScore)" SelectCommand="SELECT UnitCode, StudentID, StudentPhoto, Semester, Year, Assessment1Score, Assessment2Score, ExamScore, Assessment1Score + Assessment2Score + ExamScore AS 'UnitMarks' FROM ResultsModule" UpdateCommand="UPDATE [ResultsModule] SET [StudentPhoto] = @StudentPhoto, [Semester] = @Semester, [Year] = @Year, [Assessment1Score] = @Assessment1Score, [Assessment2Score] = @Assessment2Score, [ExamScore] = @ExamScore WHERE [UnitCode] = @UnitCode AND [StudentID] = @StudentID" OnSelecting="SqlDataSource1_Selecting">
            <DeleteParameters>
                <asp:Parameter Name="UnitCode" Type="String" />
                <asp:Parameter Name="StudentID" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UnitCode" Type="String" />
                <asp:Parameter Name="StudentID" Type="String" />
                <asp:Parameter Name="StudentPhoto" Type="Object" />
                <asp:Parameter Name="Semester" Type="Int16" />
                <asp:Parameter Name="Year" Type="Int16" />
                <asp:Parameter Name="Assessment1Score" Type="Int16" />
                <asp:Parameter Name="Assessment2Score" Type="Int16" />
                <asp:Parameter Name="ExamScore" Type="Int16" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="StudentPhoto" Type="Object" />
                <asp:Parameter Name="Semester" Type="Int16" />
                <asp:Parameter Name="Year" Type="Int16" />
                <asp:Parameter Name="Assessment1Score" Type="Int16" />
                <asp:Parameter Name="Assessment2Score" Type="Int16" />
                <asp:Parameter Name="ExamScore" Type="Int16" />
                <asp:Parameter Name="UnitCode" Type="String" />
                <asp:Parameter Name="StudentID" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" OnClick="LinkButton3_Click">&lt;&lt; LogOut</asp:LinkButton>
&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" OnClick="LinkButton4_Click">View Report &gt;&gt;</asp:LinkButton>
    </form>
</body>
</html>

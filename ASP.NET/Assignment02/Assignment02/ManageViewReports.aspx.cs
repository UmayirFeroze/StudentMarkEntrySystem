using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Text;


namespace Assignment02
{
    public partial class ManageViewReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(@"Server = UMAIRPC\SQLEXPRESS; Database = Assignment02; Trusted_Connection = True");
            if (txtUnitCode.Text != "")
            {
                SqlCommand cmd = new SqlCommand("SELECT StudentID, Assessment1Score, Assessment2Score, ExamScore, Assessment1Score+Assessment2Score+ExamScore AS 'UnitMarks',"+
                                                "CASE WHEN (Assessment1Score + Assessment2Score + ExamScore) >= 80 " +
                                                "THEN 'HD' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 80 AND (Assessment1Score + Assessment2Score + ExamScore) >= 70 " +
                                                "THEN 'D' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 70 AND (Assessment1Score + Assessment2Score + ExamScore) >= 60 " +
                                                "THEN 'CR' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 60 AND (Assessment1Score + Assessment2Score + ExamScore) >= 50 " +
                                                "THEN 'C' ELSE 'F' END AS Grade FROM ResultsModule WHERE ( UnitCode like + '%' + @unitCode + '%')", con);
                cmd.Parameters.Add("@unitCode", SqlDbType.Char).Value = txtUnitCode.Text;
                con.Open();
                cmd.ExecuteNonQuery();
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds, "UnitCode");
                GridView1.DataSource = ds;
                GridView1.DataBind();
                Label6.Text = "Row: " + GridView1.Rows.Count;
                //int sum = 0;
                //for (int i=1;i<GridView1.Rows.Count;i++)
                //{
                //    sum += Convert.ToInt32(GridView1.Rows[i].Cells[5].Text);
                //}
                //double average = sum / GridView1.Rows.Count;
                //Label7.Text = "Average: " + average;
            }
            else if (txtStudentID.Text != "")
            {
                SqlCommand cmd = new SqlCommand("SELECT UnitCode, Semester, Year, Assessment1Score, Assessment2Score, ExamScore, Assessment1Score+Assessment2Score+ExamScore AS 'UnitMarks',"+
                                                "CASE WHEN (Assessment1Score + Assessment2Score + ExamScore) >= 80 " +
                                                "THEN 'HD' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 80 AND (Assessment1Score + Assessment2Score + ExamScore) >= 70 " +
                                                "THEN 'D' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 70 AND (Assessment1Score + Assessment2Score + ExamScore) >= 60 " +
                                                "THEN 'CR' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 60 AND (Assessment1Score + Assessment2Score + ExamScore) >= 50 " +
                                                "THEN 'C' ELSE 'F' END AS Grade FROM ResultsModule WHERE (StudentID like + '%' + @studentID + '%')", con);
                cmd.Parameters.Add("@studentID", SqlDbType.Char).Value = txtStudentID.Text;

                con.Open();
                cmd.ExecuteNonQuery();
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();

                da.Fill(ds, "StudentId");

                GridView1.DataSource = ds;
                GridView1.DataBind();
                Label6.Text = "Row: " + GridView1.Rows.Count;
            }

            else if (txtSemester.Text != "")
            {
                SqlCommand cmd = new SqlCommand("SELECT UnitCode,StudentID,Assessment1Score,Assessment2Score,ExamScore,Assessment1Score+Assessment2Score+ExamScore AS 'UnitMarks',StudentPhoto," +
                                                "CASE WHEN (Assessment1Score + Assessment2Score + ExamScore) >= 80 " +
                                                "THEN 'HD' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 80 AND (Assessment1Score + Assessment2Score + ExamScore) >= 70 " +
                                                "THEN 'D' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 70 AND (Assessment1Score + Assessment2Score + ExamScore) >= 60 " +
                                                "THEN 'CR' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 60 AND (Assessment1Score + Assessment2Score + ExamScore) >= 50 " +
                                                "THEN 'C' ELSE 'F' END AS Grade FROM ResultsModule WHERE ( Semester like + '%' + @semester + '%')", con);
                cmd.Parameters.Add("@semester", SqlDbType.Char).Value = txtSemester.Text;
                con.Open();
                cmd.ExecuteNonQuery();
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds, "Semester");
                GridView1.DataSource = ds;
                GridView1.DataBind();
                Label6.Text = "Row: " + GridView1.Rows.Count;
            }
            else if (txtYear.Text != "")
            {
                SqlCommand cmd = new SqlCommand("SELECT UnitCode, StudentID, Assessment1Score, Assessment2Score, ExamScore, Assessment1Score+Assessment2Score+ExamScore AS 'UnitMarks',"+
                                                "CASE WHEN (Assessment1Score + Assessment2Score + ExamScore) >= 80 " +
                                                "THEN 'HD' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 80 AND (Assessment1Score + Assessment2Score + ExamScore) >= 70 " +
                                                "THEN 'D' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 70 AND (Assessment1Score + Assessment2Score + ExamScore) >= 60 " +
                                                "THEN 'CR' " +
                                                "WHEN (Assessment1Score + Assessment2Score + ExamScore) < 60 AND (Assessment1Score + Assessment2Score + ExamScore) >= 50 " +
                                                "THEN 'C' ELSE 'F' END AS Grade FROM ResultsModule WHERE ( Year like + '%' + @year + '%')", con);
                cmd.Parameters.Add("@year", SqlDbType.Char).Value = txtYear.Text;
                con.Open();
                cmd.ExecuteNonQuery();
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds, "Year");
                GridView1.DataSource = ds;
                GridView1.DataBind();
                Label6.Text = "Row: " + GridView1.Rows.Count; 
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageResults.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageLogin.aspx");
        }
    }
}
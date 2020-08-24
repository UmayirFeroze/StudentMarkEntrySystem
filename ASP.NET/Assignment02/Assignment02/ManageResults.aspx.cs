using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient; 

namespace Assignment02
{
    public partial class ManageResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(@"Server = UMAIRPC\SQLEXPRESS; Database = Assignment02; Trusted_Connection = True");
            con.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO ResultsModule(UnitCode,StudentID,StudentPhoto,Semester,Year,Assessment1Score,Assessment2Score,ExamScore) VALUES (@unitCode,@studentID,@photo,@semester,@year,@assessment1,@assessment2,@exam)", con);
            TextBox txtUnitCode = GridView1.FooterRow.FindControl("txtUnitCode") as TextBox;
            TextBox txtStudentID = GridView1.FooterRow.FindControl("txtStudentID") as TextBox;
            FileUpload photo = GridView1.FooterRow.FindControl("FileUpload1") as FileUpload;
            TextBox txtSemester = GridView1.FooterRow.FindControl("txtSemester") as TextBox;
            TextBox txtYear = GridView1.FooterRow.FindControl("txtYear") as TextBox;
            TextBox txtAssessment1Score = GridView1.FooterRow.FindControl("txtAssessment1Score") as TextBox;
            TextBox txtAssessment2Score = GridView1.FooterRow.FindControl("txtAssessment2Score") as TextBox;
            TextBox txtExamScore = GridView1.FooterRow.FindControl("txtExamScore") as TextBox;

            if (photo.HasFile)
            {
                string fileName = photo.FileName.ToString();
                string path = "StudentPhoto/" + fileName;
                photo.PostedFile.SaveAs(Server.MapPath("/StudentPhoto/") + fileName);
                cmd.Parameters.AddWithValue("@photo", path);
            }
            else
            {
                cmd.Parameters.AddWithValue("@photo", DBNull.Value);
            }

            cmd.Parameters.AddWithValue("@unitCode", txtUnitCode.Text);
            cmd.Parameters.AddWithValue("@studentID", Convert.ToInt32(txtStudentID.Text));
            cmd.Parameters.AddWithValue("@semester", Convert.ToInt32(txtSemester.Text));
            cmd.Parameters.AddWithValue("@year", Convert.ToInt32(txtYear.Text));
            cmd.Parameters.AddWithValue("@assessment1", Convert.ToInt32(txtAssessment1Score.Text));
            cmd.Parameters.AddWithValue("@assessment2", Convert.ToInt32(txtAssessment2Score.Text));
            cmd.Parameters.AddWithValue("@exam", Convert.ToInt32(txtExamScore.Text));
            cmd.Connection = con;
            cmd.ExecuteNonQuery();
            GridView1.DataBind();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageLogin.aspx");
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageViewReports.aspx");
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}
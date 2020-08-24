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
    public partial class ManageUnits : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(@"Server=UMAIRPC\SQLEXPRESS; Database=Assignment02; Trusted_Connection=True");
            con.Open();
            SqlCommand insertUnit = new SqlCommand("INSERT INTO UnitsModule(UnitCode,UnitTitle,UnitCoordinator,UnitOutlinePDFDocument) VALUES (@unitCode,@unitTitle,@unitCoordinator,@PDF)", con);
            TextBox txtUnitCode = GridView1.FooterRow.FindControl("txtUnitCode") as TextBox;
            TextBox txtUnitTitle = GridView1.FooterRow.FindControl("txtUnitTitle") as TextBox;
            TextBox txtUnitCoordinator = GridView1.FooterRow.FindControl("txtUnitCoordinator") as TextBox;
            FileUpload FileUpload1 = GridView1.FooterRow.FindControl("FileUpload1") as FileUpload;

            if (FileUpload1.HasFile)
            {
                string fileName = FileUpload1.FileName.ToString();
                string path = "UnitOutline/" + fileName;
                FileUpload1.PostedFile.SaveAs(Server.MapPath("/UnitOutline/") + fileName);
                insertUnit.Parameters.AddWithValue("@PDF", path);
            }
            else
            {
                insertUnit.Parameters.AddWithValue("@PDF", DBNull.Value);
            }

            insertUnit.Parameters.AddWithValue("@unitCode", txtUnitCode.Text);
            insertUnit.Parameters.AddWithValue("@unitTitle", txtUnitTitle.Text);
            insertUnit.Parameters.AddWithValue("@unitCoordinator", txtUnitCoordinator.Text);
            insertUnit.Connection = con;
            insertUnit.ExecuteNonQuery();
            GridView1.DataBind();
        }



        protected void lnkLoginPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageLogin.aspx");   
        }

    }
}
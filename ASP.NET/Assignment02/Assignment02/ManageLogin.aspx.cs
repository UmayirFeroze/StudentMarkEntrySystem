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
    public partial class ManageLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            DataTable dt = null;
            try
            {
                dt = ((DataView)(SqlDataSource1.Select(DataSourceSelectArguments.Empty))).Table;
            }
            catch (FormatException ex)
            {
                Response.Write("Username has to be a Numeric Value!");
                Response.End();
            }
            if (dt.Rows.Count != 0)
            {
                if (int.Parse(dt.Rows[0][3].ToString()) == 0)
                {
                    Session["UserID"] = dt.Rows[0][0].ToString();
                    Session["UserEmail"] = dt.Rows[0][1].ToString();
                    Session["UserType"] = dt.Rows[0][2].ToString();
                    Response.Write("Log In Successful!");
                    Response.Redirect("~/ManageUnits.aspx");

                }
                else if (int.Parse(dt.Rows[0][3].ToString()) == 1)
                {
                    Session["UserID"] = dt.Rows[0][0].ToString();
                    Session["UserEmail"] = dt.Rows[0][1].ToString();
                    Session["UserType"] = dt.Rows[0][2].ToString();
                    Response.Write("Log In Successful!");
                    Response.Redirect("~/ManageResults.aspx");
                }
            }
        }
    }
}
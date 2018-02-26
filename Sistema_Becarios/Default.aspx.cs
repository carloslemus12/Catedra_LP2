using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
            Response.Write(Session["username"]);
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Session["username"] = this.txtUsername.Text.Trim();
        Response.Redirect("Administrador/Becas.aspx");
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contador_Becarios : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void table_becarios_SelectedIndexChanged(object sender, EventArgs e)
    {
        int id = int.Parse(this.table_becarios.SelectedValue.ToString());
        Response.Redirect("/Contador/Becario/" + id);
    }
}
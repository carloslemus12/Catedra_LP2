using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GestorEducativo_MasterGestorEducativo : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //En caso de que la seccion no esta abierta
        if (Session["usuario"] == null)
            Response.Redirect("/login");
        else
        {
            Usuarios usuario = (Usuarios)Session["usuario"];

            if (usuario.TipoUsuarios != 2)
            {
                Session.Abandon();
                Response.Redirect("/login");
            }
        }
    }

    protected void btnCerrar_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("/login");
    }
}

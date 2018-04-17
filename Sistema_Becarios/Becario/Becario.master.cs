using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Becario_Becario : System.Web.UI.MasterPage
{
    public Becarios becario;
    public DatosAcademicos datos;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["usuario"] == null)
            Response.Redirect("/login");
        else
        {
            Usuarios usuario = (Usuarios)Session["usuario"];

            if (usuario.TipoUsuarios != 4)
            {
                Session.Abandon();
                Response.Redirect("/login");
            }

            becario = usuario.Becarios.Last();
            datos = becario.DatosAcademicos.LastOrDefault();
        }
    }

    protected void btnCerrar_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("/login");
    }
}

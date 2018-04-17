using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Becario_Ciclo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Usuarios usuario = (Usuarios)Session["usuario"];
        Becarios becario = usuario.Becarios.LastOrDefault();
        DatosAcademicos datos = becario.DatosAcademicos.LastOrDefault();
        Presupuestos presupuesto = datos.Presupuestos.LastOrDefault();

        this.txt_datos.Text = "" + datos.ID;
        this.txt_presupuesto.Text = "" + presupuesto.ID;
    }
}
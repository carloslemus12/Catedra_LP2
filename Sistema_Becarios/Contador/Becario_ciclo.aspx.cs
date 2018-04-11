using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contador_Becario_ciclo : System.Web.UI.Page
{
    public Becarios becario;
    public Ciclos ciclo;
    public Presupuestos presupuesto;

    protected void Page_Load(object sender, EventArgs e)
    {
        int id = int.Parse(RouteData.Values["becario"].ToString());
        int id_ciclo = int.Parse(RouteData.Values["ciclo"].ToString());

        becario = BecariosModelo.Encontrar(id);
        ciclo = BecariosModelo.encontrarCiclo(id_ciclo);
        presupuesto = becario.DatosAcademicos.Last().Presupuestos.Last();

        this.txt_presupuesto.Text = "" + presupuesto.ID;
        this.txt_datos.Text = "" + becario.DatosAcademicos.Last().ID;
    }

    protected void tbl_desembolsos_RowCreated(object sender, GridViewRowEventArgs e)
    {

    }

    protected void btn_desembolsar_Click(object sender, EventArgs e)
    {
        int id_ciclo = ciclo.ID;
        double monto = double.Parse(this.txtDesembolso.Text.Trim());
        string tipo_desembolso = this.ddl_tipo.SelectedValue;

        if (!BecariosModelo.agregarDesembolso(presupuesto, id_ciclo, tipo_desembolso, monto))
            this._clientScript.InnerHtml = "<script>alert('Error: El monto es superior a los ingresos que posee');</script>";

        this.up_desembolso.DataBind();
    }

    protected void tbl_desembolsos_SelectedIndexChanged(object sender, EventArgs e)
    {
        int id_desembolso = int.Parse(this.tbl_desembolsos.SelectedValue.ToString());

        BecariosModelo.devolverDinero(presupuesto, id_desembolso);

        this.up_desembolso.DataBind();
    }

    protected void ddl_ciclos_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!this.ddl_ciclos.SelectedValue.ToString().Equals("-1"))
            Response.Redirect("/Contador/becario/" + becario.ID + "/ciclo/" + this.ddl_ciclos.SelectedValue);
    }
}
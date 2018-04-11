using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contador_becario : System.Web.UI.Page
{
    public Becarios becario;

    public decimal matricula = 0;
    public decimal manuntencion = 0;
    public decimal libros = 0;
    public decimal aranceles = 0;
    public decimal graduacion = 0;
    public decimal seguro = 0;

    Presupuestos presupuesto;

    protected void Page_Load(object sender, EventArgs e)
    {
        int id = int.Parse(RouteData.Values["becario"].ToString());
        becario = BecariosModelo.Encontrar(id);

        presupuesto = becario.DatosAcademicos.Last().Presupuestos.Last();

        this.txt_datos.Text = becario.DatosAcademicos.Last().ID.ToString();

        if (!IsPostBack)
        {
            // Total del dinero
            matricula = presupuesto.matricula;
            manuntencion = presupuesto.manutencion;
            libros = presupuesto.libros;
            aranceles = presupuesto.aranceles;
            graduacion = presupuesto.trabajo_graduacion;
            seguro = presupuesto.seguro;

            this.txt_matricula.Value = "" + matricula;
            this.txt_manuntencion.Value = "" + manuntencion;
            this.txt_colegiatura.Text = "" + libros;
            this.txt_otros.Value = "" + aranceles;
            this.txt_graduacion.Value = "" + graduacion;
            this.txt_seguro.Value = "" + seguro;
        }
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        matricula = decimal.Parse(this.txt_matricula.Value);
        manuntencion = decimal.Parse(this.txt_manuntencion.Value);
        libros = decimal.Parse(this.txt_colegiatura.Text);
        aranceles = decimal.Parse(this.txt_otros.Value);
        graduacion = decimal.Parse(this.txt_graduacion.Value);
        seguro = decimal.Parse(this.txt_seguro.Value);

        BecariosModelo becario_modelo = new BecariosModelo();
        becario_modelo.actualizarPresupuesto(presupuesto, graduacion, aranceles, libros, manuntencion, matricula, seguro);
    }

    protected void ddl_ciclos_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!this.ddl_ciclos.SelectedValue.ToString().Equals("-1"))
            Response.Redirect("/Contador/becario/" + becario.ID + "/ciclo/" + this.ddl_ciclos.SelectedValue);
    }
}
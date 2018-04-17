using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GestorEducativo_Ciclos : System.Web.UI.Page
{
    public Becarios becario;
    public Presupuestos presupuesto;
    public DatosAcademicos datos;

    public decimal matricula = 0;
    public decimal manuntencion = 0;
    public decimal libros = 0;
    public decimal aranceles = 0;
    public decimal graduacion = 0;
    public decimal seguro = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        int id_becario = int.Parse(Request.QueryString["id"]);
        int id_datos = int.Parse(Request.QueryString["datos"]);
        int id_presupuesto = int.Parse(Request.QueryString["presupuesto"]);

        becario = BecariosModelo.Encontrar(id_becario);
        presupuesto = BecariosModelo.encontrarPresupuesto(id_presupuesto);
        datos = BecariosModelo.encontrarDatosAcademicos(id_datos);

        // Si no posee ciclos
        if (!BecariosModelo.poseeCiclos(datos))
        {
            BecariosModelo.crearCiclo(datos);
            this.ddl_ciclos.DataBind();
            this.ddl_ciclos.SelectedIndex = 0;
        }

        // Obtenemos los datos del presupuesto global
        var desembolos = BecariosModelo.obtenerTotalDesembolsado(id_presupuesto);

        // Total del dinero
        matricula = presupuesto.matricula + desembolos.Matricula;
        manuntencion = presupuesto.manutencion + desembolos.Manuntencion;
        libros = presupuesto.libros + desembolos.Libro;
        aranceles = presupuesto.aranceles + desembolos.Araceles;
        graduacion = presupuesto.trabajo_graduacion + desembolos.Graduacion;
        seguro = presupuesto.seguro + desembolos.Seguro;

        if (ddl_ciclos.Items.Count > 0)
        {
            int id_ciclo = int.Parse(ddl_ciclos.SelectedValue.ToString());
            if (BecariosModelo.esElUltimoCiclo(datos, id_ciclo))
            {
                string script = "$('button').attr('disabled', true);";

                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "accion", script, true);
            }
        }
    }

    protected void tbl_materias_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Image ciclos = (Image)e.Row.Cells[9].Controls[0];
            //Image peresupuesto = (Image)e.Row.Cells[8].Controls[0];
            //Image datos = (Image)e.Row.Cells[7].Controls[0];
            Image modificar = (Image)e.Row.Cells[3].Controls[0];

            //ciclos.Attributes.Add("onClick", "$('#txtAccion').val('4').change();");
            //peresupuesto.Attributes.Add("onClick", "$('#txtAccion').val('3').change();");
            //datos.Attributes.Add("onClick", "$('#txtAccion').val('2').change();");
            //modificar.Attributes.Add("onClick", "$('#txtAccion').val('1').change();");

            //peresupuesto.Attributes.Add("data-toggle", "modal");
            //peresupuesto.Attributes.Add("data-target", "#manejo_presupuesto");

            modificar.Attributes.Add("data-toggle", "modal");
            modificar.Attributes.Add("data-target", "#modal_modificar_materia");

            //datos.Attributes.Add("data-toggle", "modal");
            //datos.Attributes.Add("data-target", "#modal_datos_academicos");
        }
    }

    protected void tbl_materias_SelectedIndexChanged(object sender, EventArgs e)
    {
        Notas materia = BecariosModelo.encontrarNota(int.Parse(this.tbl_materias.SelectedValue.ToString()));

        scr_manager.RegisterDataItem(this.txtModificarNombreMateria, materia.nombre_materia);
        scr_manager.RegisterDataItem(this.txtModificarNota, ""+materia.nota);
        scr_manager.RegisterDataItem(this.txtModificarUv, ""+materia.uv_materia);
        scr_manager.RegisterDataItem(this.txtModId, "" + materia.ID);
    }

    protected void btn_modificar_Click(object sender, EventArgs e)
    {
        Notas notas = BecariosModelo.encontrarNota(int.Parse(txtModId.Text.Trim()));

        string materia = this.txtModificarNombreMateria.Text.Trim();
        double nota = double.Parse(this.txtModificarNota.Text.Trim());
        int uv = int.Parse(this.txtModificarUv.Text.Trim());

        BecariosModelo.modificarMateria(notas, materia, nota, uv);
        this.up_materias.DataBind();
    }

    protected void btn_eliminarMateria_Click(object sender, EventArgs e)
    {
        Notas notas = BecariosModelo.encontrarNota(int.Parse(txtModId.Text.Trim()));
        BecariosModelo.eliminarrMateria(notas);
        this.up_materias.DataBind();
    }

    protected void btn_incidencia_Click(object sender, EventArgs e)
    {
        string incidencia = txtIncidencia.Text.Trim();

        BecariosModelo.agregarIncidente(int.Parse(ddl_ciclos.SelectedValue.ToString()), incidencia);

        this.up_incedentes.DataBind();
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int id = int.Parse(this.GridView1.SelectedValue.ToString());
        BecariosModelo.eliminarIncidente(id);
        this.up_incedentes.DataBind();
    }

    protected void btn_nuevoCiclo_Click(object sender, EventArgs e)
    {
        BecariosModelo.crearCiclo(datos);
        this.ddl_ciclos.DataBind();
    }

    protected void ddl_ciclos_DataBound(object sender, EventArgs e)
    {
        
    }
}
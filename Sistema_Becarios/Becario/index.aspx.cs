using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Becario_index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Usuarios usuario = (Usuarios)Session["usuario"];
        Becarios becario = usuario.Becarios.LastOrDefault();
        DatosAcademicos datos = becario.DatosAcademicos.LastOrDefault();

        Presupuestos presupuesto = datos.Presupuestos.LastOrDefault();
        Ciclos ciclo = datos.Ciclos.LastOrDefault();

        this.txt_ciclo.Text = "" + ciclo.ID;
        this.txt_presupuesto.Text = "" + presupuesto.ID;
    }

    protected void tbl_materias_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //Image ciclos = (Image)e.Row.Cells[9].Controls[0];
            //Image peresupuesto = (Image)e.Row.Cells[8].Controls[0];
            //Image datos = (Image)e.Row.Cells[7].Controls[0];
            Image modificar = (Image)e.Row.Cells[4].Controls[0];

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

    protected void btn_nuevaMateria_Click(object sender, EventArgs e)
    {
        string materia = this.txtNuevoNombreMateria.Text.Trim();
        double nota = double.Parse(this.txtNuevaNota.Text.Trim());
        int uv = int.Parse(this.txtNuevoUv.Text.Trim());

        BecariosModelo.guardarMateria(int.Parse(this.txt_ciclo.Text), materia, nota, uv);
        this.up_materias.DataBind();
    }


    protected void tbl_notas_SelectedIndexChanged(object sender, EventArgs e)
    {
        Notas materia = BecariosModelo.encontrarNota(int.Parse(this.tbl_notas.SelectedValue.ToString()));

        scr_manager.RegisterDataItem(this.txtModificarNombreMateria, materia.nombre_materia);
        scr_manager.RegisterDataItem(this.txtModificarNota, "" + materia.nota);
        scr_manager.RegisterDataItem(this.txtModificarUv, "" + materia.uv_materia);
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
}
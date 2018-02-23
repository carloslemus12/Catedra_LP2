using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrador_Carreras : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void tablaCarrera_PreRender(object sender, EventArgs e)
    {
        try
        {
            var tabla = (GridView)sender;
            var cabezera = (GridViewRow)tabla.Controls[0].Controls[0];

            cabezera.Cells[2].ColumnSpan = 2;
            cabezera.Cells.RemoveAt(3);
            cabezera.Cells[2].Text = "Opciones";
        }
        catch (Exception) { }
    }

    protected void tablaCarrera_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image update = (Image)e.Row.Cells[2].Controls[0];
            update.Attributes["data-toggle"] = "modal";
            update.Attributes["data-target"] = "#modalModificarCarrera";
        }
    }

    protected void btnNuevaCarrera_Click(object sender, EventArgs e)
    {
        try
        {
            string nombre = this.txtNombreNuevaCarrera.Text.Trim();
            this.sqlCarreras.InsertParameters["nombre"].DefaultValue = nombre;

            if (this.sqlCarreras.Insert() > 0)
                this.tablaCarrera.DataBind();
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error al guardar la carrera');", true);
        }
        catch (Exception)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error al guardar la carrera');", true);
        }
    }

    protected void tablaCarrera_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.scrControl.RegisterDataItem(this.txtIndiceCarrera, this.tablaCarrera.SelectedValue.ToString());
        this.scrControl.RegisterDataItem(this.txtModificarCarrera, this.tablaCarrera.SelectedRow.Cells[1].Text.Trim());
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        try
        {
            string indice = this.txtIndiceCarrera.Value.Trim();
            string nombre = this.txtModificarCarrera.Text.Trim();

            this.sqlCarreras.UpdateParameters["indice"].DefaultValue = indice;
            this.sqlCarreras.UpdateParameters["nombre"].DefaultValue = nombre;

            if (this.sqlCarreras.Update() > 0)
                this.DataBind();
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error al modificar la carrera');", true);

        }
        catch (Exception)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error al modificar la carrera');", true);
        }
    }
}
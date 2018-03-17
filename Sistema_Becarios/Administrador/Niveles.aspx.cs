using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrador_Niveles : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // En caso de que la seccion no esta abierta
        if (Session["usuario"] == null) Response.Redirect("/login");
    }

    protected void btnNuevaCarrera_Click(object sender, EventArgs e)
    {
        try
        {
            string nombre = this.txtNombreNuevoNivel.Text.Trim();
            this.sqlNiveles.InsertParameters["nivel_educativo"].DefaultValue = nombre;

            this.txtNombreNuevoNivel.Text = "";

            if (this.sqlNiveles.Insert() > 0)
                this.tablaNiveles.DataBind();
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error al guardar el nivel');", true);

        }
        catch (Exception)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error al guardar el nivel');", true);
        }
    }

    protected void tablaNiveles_PreRender(object sender, EventArgs e)
    {
        try 
        {
            var tabla = (GridView)sender;
            var cabezera = (GridViewRow)tabla.Controls[0].Controls[0];
            cabezera.Cells[2].ColumnSpan = 2;
            cabezera.Cells.RemoveAt(3);
        }
        catch (Exception){ }
    }

    protected void tablaNiveles_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image img = (Image)e.Row.Cells[2].Controls[0];
            img.Attributes["data-toggle"] = "modal";
            img.Attributes["data-target"] = "#modalModificarNivel";
        }
    }

    protected void tablaNiveles_SelectedIndexChanged(object sender, EventArgs e)
    {
        string indice = tablaNiveles.SelectedValue.ToString().Trim();
        string nombre = tablaNiveles.SelectedRow.Cells[1].Text.Trim();

        this.scrControl.RegisterDataItem(this.txtIndiceNivel, indice);
        this.scrControl.RegisterDataItem(this.txtNombreModificarNivel, nombre);
    }

    protected void btnModificarNivel_Click(object sender, EventArgs e)
    {
        try
        {
            string indice = this.txtIndiceNivel.Value.Trim();
            string nombre = this.txtNombreModificarNivel.Text.Trim();
            this.txtNombreModificarNivel.Text = "";

            this.sqlNiveles.UpdateParameters["ID"].DefaultValue = indice;
            this.sqlNiveles.UpdateParameters["nivel_educativo"].DefaultValue = nombre;

            if (this.sqlNiveles.Update() > 0)
                this.tablaNiveles.DataBind();
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error al modificar el nivel');", true);
        }
        catch (Exception)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error al modificar el nivel');", true);
        }
    }
}
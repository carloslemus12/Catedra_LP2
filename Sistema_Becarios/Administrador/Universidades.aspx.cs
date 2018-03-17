using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrador_Universidades : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // En caso de que la seccion no esta abierta
        if (Session["usuario"] == null) Response.Redirect("/login");
    }

    protected void tablaUniversidad_PreRender(object sender, EventArgs e)
    {
        try
        {
            var tabla = (GridView)sender;
            var cabezera = (GridViewRow)tabla.Controls[0].Controls[0];

            cabezera.Cells[2].Text = "Opciones";
            cabezera.Cells[2].ColumnSpan = 2;
            cabezera.Cells.RemoveAt(3);
        }
        catch (Exception) { }
    }

    protected void btnNuevaUniversidad_Click(object sender, EventArgs e)
    {
        try
        {
            string nombre = this.txtNombreNuevaUniversidad.Text.Trim();

            this.sqlUniversidades.InsertParameters["universidad"].DefaultValue = nombre;

            this.sqlUniversidades.Insert();

            this.txtNombreNuevaUniversidad.Text = "";
            this.tablaUniversidad.DataBind();
        }
        catch (Exception)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error al insertar los datos');", true);
        }
    }

    protected void tablaUniversidad_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image seleccionar = (Image)e.Row.Cells[2].Controls[0];
            seleccionar.Attributes["data-toggle"] = "modal";
            seleccionar.Attributes["data-target"] = "#modalModificarUniversidad";
        }
    }

    protected void tablaUniversidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        string indice = this.tablaUniversidad.SelectedValue.ToString().Trim();
        string nombre = this.tablaUniversidad.SelectedRow.Cells[1].Text.Trim();

        this.scrControl.RegisterDataItem(this.txtIndice, indice);
        this.scrControl.RegisterDataItem(this.txtNombreModificarUniversidad, nombre);
    }

    protected void btnModificarUniversidad_Click(object sender, EventArgs e)
    {
        try
        {
            string codigo = this.txtIndice.Value.Trim();
            string nombre = this.txtNombreModificarUniversidad.Text.Trim();

            this.sqlUniversidades.UpdateParameters["universidad"].DefaultValue = nombre;
            this.sqlUniversidades.UpdateParameters["ID"].DefaultValue = codigo;

            if (this.sqlUniversidades.Update() <= 0)
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('No se ha podido modificar la universidad');", true);
            else
                this.tablaUniversidad.DataBind();
        }
        catch (Exception)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('No se ha podido modificar la universidad');", true);
        }
    }
}
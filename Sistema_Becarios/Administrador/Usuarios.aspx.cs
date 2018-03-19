using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Administrador_Usuarios : System.Web.UI.Page
{
    Usuarios usuario;

    protected void Page_Load(object sender, EventArgs e)
    {
        // En caso de que la seccion no esta abierta
        if (Session["usuario"] == null) Response.Redirect("/login");

        this.usuario = (Usuarios)Session["usuario"];

        this.sqlUsuarios.SelectParameters["id"].DefaultValue = this.usuario.ID.ToString();

        // Obtenemos la fecha actual del servidor
        this._clientScript.InnerHtml = "<script>$('#txtFechaActual').val('" + DateTime.Today.ToString("yyyy-MM-dd") + "').change();</script>";
        this.txtNuevaClaveAleatoria.Attributes.Add("readonly", "readonly");
    }

    protected override void Render(HtmlTextWriter writer)
    {
        base.Render(writer);

        /*
        // setup a TextWriter to capture the markup
        TextWriter tw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(tw);

        // render the markup into our surrogate TextWriter
        base.Render(htw);

        // get the captured markup as a string
        string pageSource = tw.ToString();

        string enabledUnchecked = "<div>";
        string disabledChecked = "<div class='d-flex justify-content-center w-100'>";

        // TODO: need replacing ONLY inside a div with id="uwg"
        string updatedPageSource = pageSource;
        updatedPageSource = Regex.Replace(pageSource, enabledUnchecked, disabledChecked, RegexOptions.IgnoreCase);

        // render the markup into the output stream verbatim
        writer.Write(updatedPageSource);
        */
    }

    protected void btnNuevoUsuario_Click(object sender, EventArgs e)
    {
        this.txtNuevaClaveAleatoria.Attributes.Remove("readonly");
        
        string nombre = this.txtNuevoNombreUsuerio.Text.Trim();
        string apellido = this.txtNuevoApellidoUsuario.Text.Trim();
        string dui = this.txtNuevoDui.Text.Trim();
        string telefono = this.txtNuevoTelefonoUsuario.Text.Trim();
        string direccion = this.txtDireccion.Text.Trim();
        string coreo = this.txtNuevoCorreoElectronico.Text.Trim();
        string fecha = this.txtNuevaFecha.Text.Trim();
        string clave = this.txtNuevaClaveAleatoria.Text.Trim();
        string tipo = this.ddlTipoUsuario.SelectedValue;
        string estado = "1";

        this.txtNuevaClaveAleatoria.Attributes.Add("readonly", "readonly");
        
        this.sqlUsuarios.InsertParameters["Nombres"].DefaultValue = nombre;
        this.sqlUsuarios.InsertParameters["Apellidos"].DefaultValue = apellido;
        this.sqlUsuarios.InsertParameters["dui"].DefaultValue = dui;
        this.sqlUsuarios.InsertParameters["telefono"].DefaultValue = telefono;
        this.sqlUsuarios.InsertParameters["correo"].DefaultValue = coreo;
        this.sqlUsuarios.InsertParameters["direccion_be"].DefaultValue = direccion;
        this.sqlUsuarios.InsertParameters["fecha_nacimiento"].DefaultValue = fecha;
        this.sqlUsuarios.InsertParameters["contraseña"].DefaultValue = clave;
        this.sqlUsuarios.InsertParameters["TipoUsuarios"].DefaultValue = tipo;
        this.sqlUsuarios.InsertParameters["Estado"].DefaultValue = estado;

        if (this.sqlUsuarios.Insert() <= 0)
        {
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "alert", "alert('Error al registrar el usuario');", true);
        }
        else
        {
            this.txtNuevoNombreUsuerio.Text = "";
            this.txtNuevoApellidoUsuario.Text = "";
            this.txtNuevoDui.Text = "";
            this.txtNuevoTelefonoUsuario.Text = "";
            this.txtDireccion.Text = "";
            this.txtNuevoCorreoElectronico.Text = "";
            this.txtNuevaFecha.Text = "";
            this.txtNuevaClaveAleatoria.Text = "";
            this.ddlTipoUsuario.SelectedValue = "1";
        }
    }

    protected void tablaUsuario_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[5].ColumnSpan = 2;
            e.Row.Cells.RemoveAt(6);
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image eliminar = (Image)e.Row.Cells[5].Controls[0];
            Image modificar = (Image)e.Row.Cells[6].Controls[0];
            
            eliminar.Attributes.Add("onClick", "$('#txtAccion').val('1').change();");
            modificar.Attributes.Add("onClick", "$('#txtAccion').val('2').change();");
            modificar.Attributes.Add("data-toggle", "modal");
            modificar.Attributes.Add("data-target", "#modalModificarUsuario");
        }
    }

    protected void tablaUsuario_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Obtenemos el indice
        string indice = this.tablaUsuario.SelectedValue.ToString();

        // Segun que tipo de acciona a tomar
        if (this.txtAccion.Value.Trim().Equals("1")) // Eliminar
        {
            SqlConnection con = new SqlConnection(this.sqlUsuarios.ConnectionString);
            con.Open();
            SqlCommand comando = new SqlCommand("UPDATE Usuarios SET Estado = 0 WHERE ID = @ID", con);
            comando.Parameters.Add("@ID", System.Data.SqlDbType.Int);
            comando.Parameters["@ID"].Value = indice;
            comando.ExecuteNonQuery();
            con.Close();
            this.tablaUsuario.DataBind();
            this.upUsuario.Update();
        }
        else // Modificar
        {
            SqlConnection con = new SqlConnection(this.sqlUsuarios.ConnectionString);
            con.Open();

            SqlCommand comando = new SqlCommand("SELECT * FROM Usuarios WHERE ID = @ID", con);

            comando.Parameters.Add("@ID", System.Data.SqlDbType.Int);
            comando.Parameters["@ID"].Value = indice;

            SqlDataReader read = comando.ExecuteReader();

            string id = "", nombre = "", apellido = "", dui = "", telefono = "", direccion = "", coreo = "", fecha = "", clave = "", tipo = "", estado = "";

            if (read.Read())
            {
                id = read.GetInt32(0).ToString();
                nombre = read.GetString(1);
                apellido = read.GetString(2);
                dui = read.GetString(3);
                telefono = read.GetString(4);
                direccion = read.GetString(5);
                coreo = read.GetString(6);
                fecha = read.GetDateTime(7).ToString("yyyy-MM-dd");
                clave = read.GetString(8);
                tipo = read.GetInt32(9).ToString();
                estado = read.GetInt32(10).ToString();
            }

            scrUsuario.RegisterDataItem(this.txtModId, id);

            scrUsuario.RegisterDataItem(this.txtModificarUsuario, nombre);
            scrUsuario.RegisterDataItem(this.txtModificarApellido, apellido);
            scrUsuario.RegisterDataItem(this.txtModificarDui, dui);
            scrUsuario.RegisterDataItem(this.txtModificarTelefono, telefono);
            scrUsuario.RegisterDataItem(this.txtModificarDireccion, direccion);
            scrUsuario.RegisterDataItem(this.txtModificarCoreo, coreo);
            scrUsuario.RegisterDataItem(this.txtModificarFecha, fecha);
            scrUsuario.RegisterDataItem(this.txtModificarClave, clave);
            scrUsuario.RegisterDataItem(this.ddlModificarTipo, tipo);
            scrUsuario.RegisterDataItem(this.chkEstado, estado);

            con.Close();
            this.tablaUsuario.DataBind();
            this.upUsuario.Update();
        }
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        string id = this.txtModId.Value.Trim();
        string nombre = this.txtModificarUsuario.Text.Trim();
        string apellido = this.txtModificarApellido.Text.Trim();
        string dui = this.txtModificarDui.Text.Trim();
        string telefono = this.txtModificarTelefono.Text.Trim();
        string direccion = this.txtModificarDireccion.Text.Trim();
        string coreo = this.txtModificarCoreo.Text.Trim();
        string fecha = this.txtModificarFecha.Text.Trim();
        string tipo = this.ddlModificarTipo.SelectedValue;
        string estado = (this.chkEstado.Checked)? "1" : "0";

        this.sqlUsuarios.UpdateParameters["ID"].DefaultValue = id;
        this.sqlUsuarios.UpdateParameters["Nombres"].DefaultValue = nombre;
        this.sqlUsuarios.UpdateParameters["Apellidos"].DefaultValue = apellido;
        this.sqlUsuarios.UpdateParameters["dui"].DefaultValue = dui;
        this.sqlUsuarios.UpdateParameters["telefono"].DefaultValue = telefono;
        this.sqlUsuarios.UpdateParameters["correo"].DefaultValue = coreo;
        this.sqlUsuarios.UpdateParameters["direccion_be"].DefaultValue = direccion;
        this.sqlUsuarios.UpdateParameters["fecha_nacimiento"].DefaultValue = fecha;
        this.sqlUsuarios.UpdateParameters["TipoUsuarios"].DefaultValue = tipo;
        this.sqlUsuarios.UpdateParameters["Estado"].DefaultValue = estado;

        if (this.sqlUsuarios.Update() <= 0)
        {
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "alert", "alert('Error al actualizar el usuario');", true);
        }
        else
        {
            this.txtModId.Value = "";
            this.txtModificarUsuario.Text = "";
            this.txtModificarApellido.Text = "";
            this.txtModificarDui.Text = "";
            this.txtModificarTelefono.Text = "";
            this.txtModificarDireccion.Text = "";
            this.txtModificarCoreo.Text = "";
            this.txtModificarFecha.Text = "";
            this.txtModificarClave.Text = "";
            this.ddlModificarTipo.SelectedValue = "1";
        }
    }
}
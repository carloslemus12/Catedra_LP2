using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GestorEducativo_Becarios : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.txtAccion.Text = "";
        }

        this._clientScript.InnerHtml = "<script>$('#txtFechaActual').val('" + DateTime.Today.ToString("yyyy-MM-dd") + "').change();</script>";
        this.txtNuevaClaveAleatoria.Attributes.Add("readonly", "readonly");
    }

    protected void btn_guardar_Click(object sender, EventArgs e)
    {
        BecariosModelo becarios = new BecariosModelo();

        string nombre = this.txtNuevoNombreUsuerio.Text.Trim();
        string apellido = this.txtNuevoApellidoUsuario.Text.Trim();
        string telefono = this.txtNuevoTelefonoUsuario.Text.Trim();
        string direccion = this.txtDireccion.Text.Trim();
        string correo = this.txtNuevoCorreoElectronico.Text.Trim();
        string fecha = this.txtNuevaFecha.Text.Trim();
        string clave = this.txtNuevaClaveAleatoria.Text.Trim();
        string dui = this.txtNuevoDui.Text.Trim();
        string programa = this.ddl_programas.SelectedValue;

        this.txtNuevoNombreUsuerio.Text = "";
        this.txtNuevoApellidoUsuario.Text = "";
        this.txtNuevoTelefonoUsuario.Text = "";
        this.txtDireccion.Text = "";
        this.txtNuevoCorreoElectronico.Text = "";
        this.txtNuevaFecha.Text = "";
        this.txtNuevaClaveAleatoria.Text = "";
        this.txtNuevoDui.Text = "";
        this.ddl_programas.SelectedIndex = 0;

        becarios.GuardarBecario(nombre, apellido, telefono, direccion, correo, fecha, clave, programa, dui);

        this.up_content.DataBind();
    }

    protected void tbl_becarios_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }

    protected void tbl_becarios_SelectedIndexChanged(object sender, EventArgs e)
    {
        Becarios becario = BecariosModelo.Encontrar(int.Parse(tbl_becarios.SelectedValue.ToString()));
        Usuarios usuario = becario.Usuarios;

        if (txtAccion.Text.Trim().Equals("1"))
        {
            this.scr_manager.RegisterDataItem(this.txtModId, "" + becario.ID);
            this.scr_manager.RegisterDataItem(this.txtModificarNombreUsuerio, usuario.Nombres);
            this.scr_manager.RegisterDataItem(this.txtModificarApellidoUsuario, usuario.Apellidos);
            this.scr_manager.RegisterDataItem(this.txtModificarDui, usuario.dui);
            this.scr_manager.RegisterDataItem(this.txModificarTelefonoUsuario, usuario.telefono);
            this.scr_manager.RegisterDataItem(this.txtModificarDescripcion, usuario.direccion_be);
            this.scr_manager.RegisterDataItem(this.txtModificarCorreoElectronico, usuario.correo);
            this.scr_manager.RegisterDataItem(this.txtModificarFecha, usuario.fecha_nacimiento.ToString("yyyy-MM-dd"));
            this.scr_manager.RegisterDataItem(this.txtModificarClave, usuario.contraseña);
            this.scr_manager.RegisterDataItem(this.ddl_modificar_programas, becario.codigo_programa);
            this.scr_manager.RegisterDataItem(this.chkEstado, "" + usuario.Estado);
        }
        else if (txtAccion.Text.Trim().Equals("2"))
        {
            this.scr_manager.RegisterDataItem(this.txtModId, "" + becario.ID);
            DatosAcademicos datos_academicos = becario.DatosAcademicos.LastOrDefault();

            // Si posee datos
            if (datos_academicos != null)
            {
                this.scr_manager.RegisterDataItem(this.ddl_universidad, "" + datos_academicos.Universidad);
                this.scr_manager.RegisterDataItem(this.ddl_carrera, "" + datos_academicos.Carrera);
                this.scr_manager.RegisterDataItem(this.ddl_nivel_estudio, "" + datos_academicos.Nivel);
                this.scr_manager.RegisterDataItem(this.txtFechaIngreso, datos_academicos.fecha_inicio.ToString("yyyy-MM-dd"));
                this.scr_manager.RegisterDataItem(this.txtFechaFinalizacion, datos_academicos.fecha_finalizacion.ToString("yyyy-MM-dd"));
            }
        }
        else if (txtAccion.Text.Trim().Equals("3"))
        {
            this.scr_manager.RegisterDataItem(this.txtModId, "" + becario.ID);
            DatosAcademicos datos_academicos;
            Presupuestos presupuesto;

            if ((datos_academicos = becario.DatosAcademicos.LastOrDefault()) != null && (presupuesto = datos_academicos.Presupuestos.LastOrDefault()) != null)
            {
                this.scr_manager.RegisterDataItem(this.txtMontoAracele, "" + presupuesto.trabajo_graduacion);
                this.scr_manager.RegisterDataItem(this.txtMontoGraduacion, "" + presupuesto.aranceles);
                this.scr_manager.RegisterDataItem(this.txtMontoLibro, "" + presupuesto.libros);
                this.scr_manager.RegisterDataItem(this.txtMontoManutencion, "" + presupuesto.manutencion);
                this.scr_manager.RegisterDataItem(this.txtMontoMatricula, "" + presupuesto.matricula);
                this.scr_manager.RegisterDataItem(this.txtMontoSeguro, "" + presupuesto.seguro);
            }

        }
        else
        {
            DatosAcademicos datos_academicos;
            Presupuestos presupuesto;

            // Si posee datos
            if ((datos_academicos = becario.DatosAcademicos.LastOrDefault()) != null && (presupuesto = datos_academicos.Presupuestos.LastOrDefault()) != null)
            {
                Response.Redirect("/GestorEducativo/Ciclos?id=" + becario.ID + "&datos="+ datos_academicos.ID + "&presupuesto=" + presupuesto.ID);
            }
        }
    }

    protected void btn_modificar_Click(object sender, EventArgs e)
    {
        Becarios becario = BecariosModelo.Encontrar(int.Parse(this.txtModId.Text.Trim()));
        Usuarios usuario = becario.Usuarios;

        string nombre = this.txtModificarNombreUsuerio.Text.Trim();
        string apellido = this.txtModificarApellidoUsuario.Text.Trim();
        string telefono = this.txModificarTelefonoUsuario.Text.Trim();
        string direccion = this.txtModificarDescripcion.Text.Trim();
        string correo = this.txtModificarCorreoElectronico.Text.Trim();
        string fecha = this.txtModificarFecha.Text.Trim();
        string dui = this.txtModificarDui.Text.Trim();
        string programa = this.ddl_modificar_programas.SelectedValue;
        int estado = (this.chkEstado.Checked) ? 1 : 0;

        BecariosModelo becario_modelo = new BecariosModelo();
        becario_modelo.ModificarBecario(usuario, becario, nombre, apellido, telefono, direccion, correo, fecha, programa, estado, dui);

        this.txtModificarNombreUsuerio.Text = "";
        this.txtModificarApellidoUsuario.Text = "";
        this.txModificarTelefonoUsuario.Text = "";
        this.txtModificarDescripcion.Text = "";
        this.txtModificarCorreoElectronico.Text = "";
        this.txtModificarFecha.Text = "";
        this.txtModificarDui.Text = "";
        this.ddl_modificar_programas.SelectedIndex = 0;

        this.up_content.DataBind();
    }

    protected void btn_ActualizarDatosAcademido_Click(object sender, EventArgs e)
    {
        Becarios becario = BecariosModelo.Encontrar(int.Parse(this.txtModId.Text.Trim()));
        DatosAcademicos datos_academicos = becario.DatosAcademicos.LastOrDefault();

        int universidad = int.Parse(this.ddl_universidad.SelectedValue);
        int carrera = int.Parse(this.ddl_carrera.SelectedValue);
        int nivel = int.Parse(this.ddl_nivel_estudio.SelectedValue);
        string fecha_inicio = this.txtFechaIngreso.Text.Trim();
        string fecha_salida = this.txtFechaFinalizacion.Text.Trim();

        // Si posee datos
        if (datos_academicos == null)
        {
            BecariosModelo becas_modelo = new BecariosModelo();
            becas_modelo.guardarDatos(becario, universidad, carrera, nivel, fecha_inicio, fecha_salida);
        }
        else
        {
            BecariosModelo becas_modelo = new BecariosModelo();
            becas_modelo.actualizarDatos(datos_academicos, universidad, carrera, nivel, fecha_inicio, fecha_salida);
        }

        this.up_content.DataBind();
    }


    protected void btn_ActualizarPresupuesto_Click(object sender, EventArgs e)
    {
        Becarios becario = BecariosModelo.Encontrar(int.Parse(this.txtModId.Text.Trim()));
        DatosAcademicos datos_academicos = becario.DatosAcademicos.LastOrDefault();

        if (datos_academicos != null)
        {
            Presupuestos presupuesto;

            double graduacion = double.Parse(this.txtMontoGraduacion.Text.Trim().Replace(',', '.'));
            double aracele = double.Parse(this.txtMontoAracele.Text.Trim().Replace(',', '.'));
            double libro = double.Parse(this.txtMontoLibro.Text.Trim().Replace(',', '.'));
            double manuntencio = double.Parse(this.txtMontoManutencion.Text.Trim().Replace(',', '.'));
            double matricula = double.Parse(this.txtMontoMatricula.Text.Trim().Replace(',', '.'));
            double seguro = double.Parse(this.txtMontoSeguro.Text.Trim().Replace(',', '.'));

            if ((presupuesto = datos_academicos.Presupuestos.LastOrDefault()) == null)
            {
                BecariosModelo becario_modelo = new BecariosModelo();
                becario_modelo.guardarPresupuesto(datos_academicos, graduacion, aracele, libro, manuntencio, matricula, seguro);
            }
            else {
                BecariosModelo becario_modelo = new BecariosModelo();
                becario_modelo.actualizarPresupuesto(presupuesto, graduacion, aracele, libro, manuntencio, matricula, seguro);
            }
        } else
            this._clientScript.InnerHtml = "<script>alert('Error: no hay registros del becario');</script>";

        this.up_content.DataBind();
    }

    protected void tbl_becarios_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[6].ColumnSpan = 4;
            e.Row.Cells.RemoveAt(7);
            e.Row.Cells.RemoveAt(7);
            e.Row.Cells.RemoveAt(7);
        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image ciclos = (Image)e.Row.Cells[9].Controls[0];
            Image peresupuesto = (Image)e.Row.Cells[8].Controls[0];
            Image datos = (Image)e.Row.Cells[7].Controls[0];
            Image modificar = (Image)e.Row.Cells[6].Controls[0];

            ciclos.Attributes.Add("onClick", "$('#txtAccion').val('4').change();");
            peresupuesto.Attributes.Add("onClick", "$('#txtAccion').val('3').change();");
            datos.Attributes.Add("onClick", "$('#txtAccion').val('2').change();");
            modificar.Attributes.Add("onClick", "$('#txtAccion').val('1').change();");

            peresupuesto.Attributes.Add("data-toggle", "modal");
            peresupuesto.Attributes.Add("data-target", "#manejo_presupuesto");

            modificar.Attributes.Add("data-toggle", "modal");
            modificar.Attributes.Add("data-target", "#modal_modificar_becario");

            datos.Attributes.Add("data-toggle", "modal");
            datos.Attributes.Add("data-target", "#modal_datos_academicos");
        }
    }
}
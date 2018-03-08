using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrador : System.Web.UI.Page
{
    // Indice actual de la paginacion
    private int index = 1;
    private string urlNext = "";
    private string urlBack = "";
    private string cod = "";
    private string nombre = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string codFiltro = "%", nombreFiltro = "%";
        // Obtenemos los datos del indice
        if (Request.QueryString["indice"] != null)
            int.TryParse(Request.QueryString["indice"], out index);

        if (Request.QueryString["codigo"] != null)
        {
            codFiltro = Request.QueryString["codigo"];
            this.cod = "&codigo=" + codFiltro;
        }

        if (Request.QueryString["nombre"] != null)
        {
            nombreFiltro = Request.QueryString["nombre"];
            this.nombre = "&nombre=" + nombreFiltro;
        }

        // Manejamos la paginacion
        DataView lectorNumFila = (DataView)this.sqlProgramasBecasCantidad.Select(DataSourceSelectArguments.Empty);

        double longitudPaginas = 1;

        if (lectorNumFila.Count > 0)
            double.TryParse(lectorNumFila[0]["indice"].ToString(), out longitudPaginas);

        if (longitudPaginas <= 1)
        {
            this.btnAtrasPaginacion.Visible = false;
            this.btnSiguientePaginacion.Visible = false;
        }
        else
        {
            if (index <= 1)
                this.btnAtrasPaginacion.Visible = false;
            else
                this.urlBack = "/Administrador/Becas.aspx?indice=" + (index - 1);

            if (index >= longitudPaginas)
                this.btnSiguientePaginacion.Visible = false;
            else
                this.urlNext = "/Administrador/Becas.aspx?indice=" + (index + 1);
        }

        if (!IsPostBack)
        {
            if (Request.QueryString["codigo"] != null)
                this.txtCodigoFiltro.Text = Request.QueryString["codigo"];

            if (Request.QueryString["nombre"] != null)
                this.txtNombreFiltro.Text = Request.QueryString["nombre"];
        }

        // Manejamos los datos que mostraremos en el indice
        sqlProgramasBecas.SelectParameters["index"].DefaultValue = index.ToString();
        sqlProgramasBecas.SelectParameters["codigo"].DefaultValue = codFiltro;
        sqlProgramasBecas.SelectParameters["nombre"].DefaultValue = nombreFiltro;

        DataView lector = (DataView)this.sqlProgramasBecas.Select(DataSourceSelectArguments.Empty);

        if (lector.Count > 0)
        {
            int incremento = 0;
            foreach (DataRowView registro in lector)
            {
                incremento++;
                // Paneles que serviran para crear el card
                Panel divCard = new Panel();
                divCard.CssClass = "card";

                Panel divCardHeader = new Panel();
                divCardHeader.CssClass = "card-header bg-primary text-white";

                Panel divCardBody = new Panel();
                divCardBody.CssClass = "card-body";

                Panel divCardFooter = new Panel();
                divCardFooter.CssClass = "card-footer bg-dark d-flex justify-content-between";

                // Añadimos los controles a los elementos
                LiteralControl codigo = new LiteralControl();
                codigo.Text = "<h5 class='card-title'>Codigo: " + HttpUtility.HtmlDecode(registro["codigo"].ToString()) + "</h5>";

                divCardHeader.Controls.Add(codigo);

                LiteralControl nombre = new LiteralControl();
                nombre.Text = "<div class='alert alert-dark' role='alert'>Nombre: " + HttpUtility.HtmlDecode(registro["nombre"].ToString()) + "</div> ";

                divCardBody.Controls.Add(nombre);

                string textoDescripcion = (registro["descripcion"] == null || registro["descripcion"].ToString().Trim().Equals("")) ? "No hay descripcion" : "Descripcion: " + HttpUtility.HtmlDecode(registro["descripcion"].ToString());

                LiteralControl descripcion = new LiteralControl();
                descripcion.Text = "<div class='alert alert-success' role='alert'> " + textoDescripcion + " </div>";

                divCardBody.Controls.Add(descripcion);

                UpdatePanel up = new UpdatePanel();


                // Botones de accion
                Button btnModificar = new Button();
                btnModificar.CssClass = "btn btn-success";
                btnModificar.Text = "Modificar";
                btnModificar.Attributes["onclick"] = "$('#txtCodigoModificarBeca').val('" + HttpUtility.HtmlDecode(registro["codigo"].ToString()) + "');";
                btnModificar.Click += btnModificar_Click;
                btnModificar.Attributes["data-toggle"] = "modal";
                btnModificar.Attributes["data-target"] = "#modalModificarBecas";

                up.ContentTemplateContainer.Controls.Add(btnModificar);

                Button btnEliminar = new Button();
                btnEliminar.Text = "Eliminar";
                btnEliminar.CssClass = "btn btn-danger";
                btnEliminar.Attributes["onclick"] = "$('#txtCodigoModificarBeca').val('" + HttpUtility.HtmlDecode(registro["codigo"].ToString()) + "');";
                btnEliminar.Click += btnEliminar_Click;

                divCardFooter.Controls.Add(up);
                divCardFooter.Controls.Add(btnEliminar);

                // Añadimos los diferentes div
                divCard.Controls.Add(divCardHeader);
                divCard.Controls.Add(divCardBody);
                divCard.Controls.Add(divCardFooter);

                // Añadimos el div final
                this.divCardDeckProgramas.Controls.Add(divCard);
            }

            if (incremento <= 1)
            {
                this.divFooter.Attributes["class"] = "container-fluid m-0 p-0 fixed-bottom";
            }
        }
        else
        {
            // En caso de que no haya resultados
            this.divFooter.Attributes["class"] = "container-fluid m-0 p-0 fixed-bottom";
            this.divErrorCarga.InnerHtml = "<div class='alert alert-danger w-100 mt-3 text-center' role='alert'> ¡¡NO HAY DATOS!! </div>";
        }
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        SqlConnection sql = new SqlConnection(this.sqlProgramasBecas.ConnectionString);

        try
        {
            SqlCommand comando = new SqlCommand("SELECT nombre, descripcion FROM Programas WHERE codigo = @codigo", sql);
            comando.Parameters.Add("codigo", SqlDbType.Char);
            comando.Parameters["codigo"].Value = this.txtCodigoModificarBeca.Value;
            sql.Open();

            SqlDataReader datos = comando.ExecuteReader();

            while (datos.Read())
            {
                scrControl.RegisterDataItem(this.txtModificarCodigo, this.txtCodigoModificarBeca.Value.Trim());
                scrControl.RegisterDataItem(this.txtModificarNombrePrograma, datos["nombre"].ToString().Trim());
                scrControl.RegisterDataItem(this.txtModificarDescripcionProgrma, datos["descripcion"].ToString().Trim());
            }
        }
        catch (Exception)
        {

        }
        finally
        {
            sql.Close();
        }
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        try
        {
            // Eliminamos el codigo
            string codigo = this.txtCodigoModificarBeca.Value;
            this.sqlProgramasBecas.DeleteParameters["codigo"].DefaultValue = codigo;
            this.sqlProgramasBecas.Delete();

            Response.Redirect(Request.RawUrl);
        }
        catch (Exception)
        {
            // En caso de error
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error: no se ha podido eliminar el programa');", true);
        }
    }

    protected void btnGuardarPrograma_Click(object sender, EventArgs e)
    {
        try {
            string codigo = this.txtNuevoCodigo.Value.Trim();
            string nombre = this.txtNuevoNombrePrograma.Value.ToString();
            string descripcion = this.txtNuevaDescripcionProgrma.Value.ToString();

            this.sqlProgramasBecas.InsertParameters["codigo"].DefaultValue = codigo;
            this.sqlProgramasBecas.InsertParameters["nombre"].DefaultValue = nombre;
            this.sqlProgramasBecas.InsertParameters["descripcion"].DefaultValue = descripcion;

            this.txtNuevoCodigo.Value = "";
            this.txtNuevoNombrePrograma.Value = "";
            this.txtNuevaDescripcionProgrma.Value = "";

            this.sqlProgramasBecas.Insert();

            Response.Redirect(Request.RawUrl);
        }
        catch (Exception)
        {
            // En caso de error
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error: no se ha podido guardar el programa');", true);
        }
    }

    protected void btnModificarBeca_Click(object sender, EventArgs e)
    {
        // Obtenemos la informacion actual
        string codigoActual = this.txtCodigoModificarBeca.Value.Trim();
        string codigo = this.txtModificarCodigo.Value.Trim();
        string nombre = this.txtModificarNombrePrograma.Value.Trim();
        string descripcion = this.txtModificarDescripcionProgrma.Value.Trim();

        bool mismoCodigo = codigo.Equals(codigoActual);

        // Creamos la consulta
        string set = "SET nombre = @nombre, descripcion = @descripcion" + ((mismoCodigo) ? "" : ", codigo = @nuevo_codigo");

        string consulta = "UPDATE Programas " + set + " WHERE codigo = @codigo";

        SqlConnection sql = new SqlConnection(this.sqlProgramasBecas.ConnectionString);

        try
        {
            SqlCommand comando = new SqlCommand(consulta, sql);

            if (!mismoCodigo)
            {
                comando.Parameters.Add("nuevo_codigo", SqlDbType.Char);
                comando.Parameters["nuevo_codigo"].Value = codigo;
            }

            comando.Parameters.Add("nombre", SqlDbType.VarChar);
            comando.Parameters.Add("descripcion", SqlDbType.VarChar);
            comando.Parameters.Add("codigo", SqlDbType.Char);

            comando.Parameters["nombre"].Value = nombre;
            comando.Parameters["descripcion"].Value = descripcion;
            comando.Parameters["codigo"].Value = codigoActual;

            sql.Open();

            if (comando.ExecuteNonQuery() <= 0)
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error: no se ha podido modificar el programa');", true);

            sql.Close();

            Response.Redirect(Request.RawUrl);
        }
        catch (Exception)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Error: no se ha podido modificar el programa');", true);
        }
        finally
        {
            sql.Close();
        }
    }

    protected void btnAtrasPaginacion_Click(object sender, EventArgs e)
    {
        //Response.Write(this.urlBack + this.cod + this.nombre);
        Response.Redirect(this.urlBack + this.cod + this.nombre);
    }

    protected void btnSiguientePaginacion_Click(object sender, EventArgs e)
    {
        //Response.Write(this.urlNext + this.cod + this.nombre);
        Response.Redirect(this.urlNext + this.cod + this.nombre);
    }
    
    protected void btnFiltrar_Click(object sender, EventArgs e)
    {
        this.cod = this.txtCodigoFiltro.Text.Trim();

        if (!this.cod.Equals(""))
            this.cod = "&codigo=" + cod;
        else
            this.cod = "";

        this.nombre = this.txtNombreFiltro.Text.Trim();

        if (!this.nombre.Equals(""))
            this.nombre = "&nombre=" + nombre;
        else
            this.nombre = "";

        string url = "/Administrador/Becas.aspx?indice=" + this.index + this.cod + this.nombre;

        Response.Redirect(url);    
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrador : System.Web.UI.Page
{
    // Indice actual de la paginacion
    private int index = 1;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Obtenemos los datos del indice
        if (Request.QueryString["indice"] != null)
            int.TryParse(Request.QueryString["indice"], out index);

        // Manejamos la paginacion
        DataView lectorNumFila = (DataView)this.sqlProgramasBecasCantidad.Select(DataSourceSelectArguments.Empty);

        int longitudPaginas = 1;

        if (lectorNumFila.Count > 0)
            int.TryParse(lectorNumFila[0]["indice"].ToString(), out longitudPaginas);

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
                this.btnAtrasPaginacion.Attributes["href"] = "/Administrador/Becas.aspx?indice=" + (index - 1);

            if (index >= longitudPaginas)
                this.btnSiguientePaginacion.Visible = false;
            else
                this.btnSiguientePaginacion.Attributes["href"] = "/Administrador/Becas.aspx?indice=" + (index + 1);
        }

        // Manejamos los datos que mostraremos en el indice
        sqlProgramasBecas.SelectParameters["index"].DefaultValue = index.ToString();
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

                // Botones de accion
                Button btnModificar = new Button();
                btnModificar.CssClass = "btn btn-success";
                btnModificar.Text = "Modificar";
                btnModificar.Attributes["onclick"] = "$('#txtCodigoModificarBeca').val('" + HttpUtility.HtmlDecode(registro["codigo"].ToString()) + "');";
                btnModificar.Click += btnModificar_Click;

                Button btnEliminar = new Button();
                btnEliminar.Text = "Eliminar";
                btnEliminar.CssClass = "btn btn-danger";
                btnEliminar.Attributes["onclick"] = "$('#txtCodigoModificarBeca').val('" + HttpUtility.HtmlDecode(registro["codigo"].ToString()) + "');";
                btnEliminar.Click += btnEliminar_Click;

                divCardFooter.Controls.Add(btnModificar);
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
        Response.Write(this.txtCodigoModificarBeca.Value);
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        string codigo = this.txtCodigoModificarBeca.Value;
        this.sqlProgramasBecas.DeleteParameters["codigo"].DefaultValue = codigo;
        this.sqlProgramasBecas.Delete();

        Response.Redirect(Request.RawUrl);
    }

    protected void btnGuardarPrograma_Click(object sender, EventArgs e)
    {

        string codigo = this.txtNuevoCodigo.Value.Trim();
        string nombre = this.txtNuevoNombrePrograma.Value.ToString();
        string descripcion = this.txtNuevaDescripcionProgrma.Value.ToString();

        this.sqlProgramasBecas.InsertParameters["codigo"].DefaultValue = codigo;
        this.sqlProgramasBecas.InsertParameters["nombre"].DefaultValue = nombre;
        this.sqlProgramasBecas.InsertParameters["descripcion"].DefaultValue = descripcion;

        this.sqlProgramasBecas.Insert();

        Response.Redirect(Request.RawUrl);
    }
}
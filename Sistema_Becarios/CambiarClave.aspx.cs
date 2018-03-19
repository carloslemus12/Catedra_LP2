using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CambiarClave : System.Web.UI.Page
{
    Usuarios usuario;

    protected void Page_Load(object sender, EventArgs e)
    {
        // En caso de que la seccion no esta abierta
        if (Session["usuario"] == null) Response.Redirect("/login");

        usuario = (Usuarios)Session["usuario"];

        this.divUsuario.InnerHtml = "Usuario: " + (usuario.Nombres + " " + usuario.Apellidos).Trim();
    }

    protected void btnCambiarClave_Click(object sender, EventArgs e)
    {
        usuario.contraseña = this.txtPassword.Text.Trim();
        BecasFedisalEntities becas = new BecasFedisalEntities();

        //Obteniendo el tipo de cliente a modificar
        Usuarios user = becas.Usuarios.Find(usuario.ID);

        //Actualizando el valor del objeto
        becas.Entry(user).CurrentValues.SetValues(usuario);

        becas.SaveChanges();
        Response.Redirect("/login");    }
}
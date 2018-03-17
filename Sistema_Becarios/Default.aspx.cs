using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["usuario"] != null)
        {
            Usuarios usuario = (Usuarios)Session["usuario"];

            if (usuario.TipoUsuarios == 3)
            {
                Response.Redirect("/Administracion/Becas");
            }
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        // Informacion referente al usuario
        string correo = this.txtUsername.Text.Trim();
        string clave = this.txtPassword.Text.Trim();

        UsuarioModelo modelo = new UsuarioModelo();

        Usuarios usuario = modelo.ObtenerUsuario(correo, clave);

        if (usuario != null)
        {
            Session["usuario"] = usuario;

            if (usuario.TipoUsuarios == 3)
                Response.Redirect("Administracion/Becas");
            
        } else {
            this.divMsg.Attributes.Add("class", "alert alert-danger alert-dismissible fade show mb-0");
            this.spnMsg.InnerHtml = "La clave o la contraseña son incorrectas";
        }
    }
}
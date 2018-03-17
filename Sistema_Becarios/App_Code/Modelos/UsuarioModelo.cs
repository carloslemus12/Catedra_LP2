using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UsuarioModelo
/// </summary>
public class UsuarioModelo
{
    private BecasFedisalEntities becasFedisal;

    public UsuarioModelo()
    {
        this.becasFedisal = new BecasFedisalEntities();
    }

    public Usuarios ObtenerUsuario(string correo, string clave) {
        var usuario = (from u in becasFedisal.Usuarios
                      where u.correo.Equals(correo) && u.contraseña.Equals(clave)
                      select u).FirstOrDefault();

        return usuario;
    }
}
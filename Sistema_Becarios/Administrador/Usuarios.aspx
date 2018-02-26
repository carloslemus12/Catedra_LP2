<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Usuarios.aspx.cs" Inherits="Administrador_Usuarios" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestion Usuarios</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/estilos-app.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    
         <!-- Menu de navegacion -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
            <span class="navbar-brand">
                <img src="../img/jesus.svg" alt="" width="40" height="40" />
            </span>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu_principal" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="menu_principal">
                <ul class="navbar-nav mr-auto">
                    
                    <li class="nav-item active">
                        <a class="nav-link" href="/Administrador/Usuarios.aspx">Usuarios</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Becas.aspx">Programas de becas</a>
                    </li>
              
                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Universidades.aspx">Universidades</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Carreras.aspx">Carreras</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Niveles.aspx">Niveles de estudio</a>
                    </li>

                    <li class="nav-item d-block d-lg-none">
                        <a class="nav-link" href="#">Cambiar clave</a>
                    </li>

                    <li class="nav-item d-block d-lg-none">
                        <a class="nav-link" href="#">Cerrar secion</a>
                    </li>
                </ul>

                <div class="d-none flex-row justify-content-center d-lg-flex">
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <img src="../img/settings.svg" alt="" id="menuAjustes" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" width="30" height="30" />
                        

                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="menuAjustes">
                                <a class="dropdown-item" href="#">Cambiar clave</a>
                                <a class="dropdown-item" href="#">Cerrar secion</a>
                            </div>                           
                        </li>
                    </ul>

                </div>
            
            </div>
        </nav>

        <div class="modal fade" id="modalNuevoUsuario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">Nuevo Usuario</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <div class="form-group">
                            <label for="txtNuevoNombreUsuerio">Nombres:</label>
                            <asp:TextBox ID="txtNuevoNombreUsuerio" ValidationGroup="nuevoUsuario" runat="server" CssClass="form-control" placeholder="Nombre de usuario" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNuevoNombreUsuerio" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="El nombre del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtNuevoApellidoUsuario">Apellidos:</label>
                            <asp:TextBox ID="txtNuevoApellidoUsuario" ValidationGroup="nuevoUsuario" runat="server" CssClass="form-control" placeholder="Apellido de usuario" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNuevoApellidoUsuario" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="El apellido del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtNuevoCorreoElectronico">Correo electronico:</label>
                            <asp:TextBox ID="txtNuevoCorreoElectronico" ValidationGroup="nuevoUsuario" TextMode="Email" runat="server" CssClass="form-control" placeholder="Correo electronico" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNuevoCorreoElectronico" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="El correo electronico es obligatorio" CssClass="blockquote-footer text-danger"/>
                            <asp:RegularExpressionValidator ControlToValidate="txtNuevoCorreoElectronico" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="El correo electronico no es valido" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="ddlTipoUsuario">Tipo de usuario:</label>
                            <asp:DropDownList ID="ddlTipoUsuario" runat="server" CssClass="form-control">
                                <asp:ListItem Value="1">Contador</asp:ListItem>
                                <asp:ListItem Value="2">Gestor educativo</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="txtNuevaClaveAleatoria">Clave del usuario:</label>

                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <button id="btnClaveAleatoria" type="button" class="input-group-text btn btn-danger">Aleatorio</button>
                                </div>

                                <asp:TextBox CssClass="form-control" ID="txtNuevaClaveAleatoria" runat="server" ValidationGroup="nuevoUsuario" placeholder="Codigo" ReadOnly="true" />
                            </div>

                            <asp:RequiredFieldValidator ControlToValidate="txtNuevaClaveAleatoria" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="La clave es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnNuevoUsuario" ValidationGroup="nuevoUsuario" runat="server" CssClass="btn btn-primary" Text="Guardar usuario"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalModificarUsuarios" tabindex="-1" role="dialog" aria-labelledby="Modificar usuarios" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">Modificar Usuario</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <div class="form-group">
                            <label for="txtModificarNombreUsuerio">Nombres:</label>
                            <asp:TextBox ID="txtModificarNombreUsuerio" ValidationGroup="modificarUsuario" runat="server" CssClass="form-control" placeholder="Nombre de usuario" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarNombreUsuerio" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El nombre del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtModificarApellidoUsuario">Apellidos:</label>
                            <asp:TextBox ID="txtModificarApellidoUsuario" ValidationGroup="modificarUsuario" runat="server" CssClass="form-control" placeholder="Apellido de usuario" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarApellidoUsuario" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El apellido del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtModificarCorreoElectronico">Correo electronico:</label>
                            <asp:TextBox ID="txtModificarCorreoElectronico" ValidationGroup="modificarUsuario" TextMode="Email" runat="server" CssClass="form-control" placeholder="Correo electronico" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarCorreoElectronico" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El correo electronico es obligatorio" CssClass="blockquote-footer text-danger"/>
                            <asp:RegularExpressionValidator ControlToValidate="txtModificarCorreoElectronico" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="El correo electronico no es valido" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="ddlModificarTipoUsuario">Tipo de usuario:</label>
                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                <asp:ListItem Value="1">Contador</asp:ListItem>
                                <asp:ListItem Value="2">Gestor educativo</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="txtVerClaveUsuario">Clave del usuario:</label>
                            <asp:TextBox ID="txtVerClaveUsuario" runat="server" CssClass="form-control" ReadOnly="true"/>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnModificarUsuario" ValidationGroup="modificarUsuario" runat="server" CssClass="btn btn-primary" Text="Modificar usuario"/>
                    </div>
                </div>
            </div>
        </div>

    </form>

    <!-- Pie de la pagina web -->
    <div class="container-fluid m-0 p-0 fixed-bottom">
        <button type="button" class="btn btn-info ml-2 mb-2" data-toggle="modal" data-target="#modalNuevoUsuario">Nuevo usuario</button>
        
        <footer class="bg-danger text-white text-center py-2">
            <span class="font-weight-bold">Universidad Don Bosco<small class="font-weight-normal ml-1"> PILET 2018 </small></span>
        </footer>
    </div>

    <script src="../js/jquery-3.2.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#btnClaveAleatoria").click(function () {
                var letras = new Array("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0");
                var clave = letras[Math.floor(Math.random() * letras.length)];

                for (var i = 0; i < (Math.floor(Math.random() * 9) + 3); i++) {
                    clave += letras[Math.floor(Math.random() * letras.length)];
                }

                
                $("#txtNuevaClaveAleatoria").val(clave);
            });
        });
    </script>
</body>
</html>

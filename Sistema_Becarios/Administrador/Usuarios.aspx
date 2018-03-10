<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Usuarios.aspx.cs" Inherits="Administrador_Usuarios" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestion Usuarios</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/estilos-app.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>
    <form id="form1" runat="server">
        <input id="txtAccion" runat="server" type="hidden" />
        <asp:SqlDataSource ID="sqlUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" DeleteCommand="DELETE FROM [Usuarios] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Usuarios] ([Nombres], [Apellidos], [dui], [telefono], [correo], [direccion_be], [fecha_nacimiento], [contraseña], [TipoUsuarios], [Estado]) VALUES (@Nombres, @Apellidos, @dui, @telefono, @correo, @direccion_be, @fecha_nacimiento, @contraseña, @TipoUsuarios, @Estado)" SelectCommand="SELECT Usuarios.ID, CONCAT(Usuarios.Nombres, ' ', Usuarios.Apellidos) AS [Nombre completo], TipoUsuarios.tipo_usuario, CASE WHEN Usuarios.Estado = 1 THEN 'Activo' ELSE 'Inactivo' END AS [Estado] FROM Usuarios INNER JOIN TipoUsuarios ON Usuarios.TipoUsuarios = TipoUsuarios.ID" UpdateCommand="UPDATE [Usuarios] SET [Nombres] = @Nombres, [Apellidos] = @Apellidos, [dui] = @dui, [telefono] = @telefono, [correo] = @correo, [direccion_be] = @direccion_be, [fecha_nacimiento] = @fecha_nacimiento, [TipoUsuarios] = @TipoUsuarios, [Estado] = @Estado WHERE [ID] = @ID">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Nombres" Type="String" />
                <asp:Parameter Name="Apellidos" Type="String" />
                <asp:Parameter Name="dui" Type="String" />
                <asp:Parameter Name="telefono" Type="String" />
                <asp:Parameter Name="correo" Type="String" />
                <asp:Parameter Name="direccion_be" Type="String" />
                <asp:Parameter DbType="Date" Name="fecha_nacimiento" />
                <asp:Parameter Name="contraseña" Type="String" />
                <asp:Parameter Name="TipoUsuarios" Type="Int32" />
                <asp:Parameter Name="Estado" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Nombres" Type="String" />
                <asp:Parameter Name="Apellidos" Type="String" />
                <asp:Parameter Name="dui" Type="String" />
                <asp:Parameter Name="telefono" Type="String" />
                <asp:Parameter Name="correo" Type="String" />
                <asp:Parameter Name="direccion_be" Type="String" />
                <asp:Parameter DbType="Date" Name="fecha_nacimiento" />
                <asp:Parameter Name="TipoUsuarios" Type="Int32" />
                <asp:Parameter Name="Estado" Type="Int32" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <input id="txtFechaActual" type="date" runat="server" class="d-none" />

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

        <section>
            <asp:ScriptManager ID="scrUsuario" runat="server"></asp:ScriptManager>

            <script>
                Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(PageLoadingHandler);
                function PageLoadingHandler(sender, args) {
                    var datos = args.get_dataItems();

                    /*
                        txtModId
                        txtModificarUsuario
                        txtModificarApellido
                        txtModificarDui
                        txtModificarTelefono
                        txtModificarDireccion
                        txtModificarCoreo
                        txtModificarFecha
                        txtModificarClave
                        ddlModificarTipo
                        chkEstado
                    */

                    if (datos['ddlModificarTipo'] !== null)
                        $('#ddlModificarTipo').val(datos['ddlModificarTipo']);

                    if (datos['chkEstado'] !== null)
                        if (datos['chkEstado'] == "1")
                            $('#chkEstado').prop('checked', true);
                        else
                            $('#chkEstado').prop('checked', false);

                    $('.myCheckbox').prop('checked', false);
                        $('#chkEstado').val(datos['chkEstado']);

                    if (datos['txtModificarClave'] !== null)
                        $('#txtModificarClave').val(datos['txtModificarClave']);

                    if (datos['txtModificarFecha'] !== null)
                        $('#txtModificarFecha').val(datos['txtModificarFecha']);

                    if (datos['txtModId'] !== null)
                        $('#txtModId').val(datos['txtModId']);

                    if (datos['txtModificarUsuario'] !== null)
                        $('#txtModificarUsuario').val(datos['txtModificarUsuario']);

                    if (datos['txtModificarApellido'] !== null)
                        $('#txtModificarApellido').val(datos['txtModificarApellido']);

                    if (datos['txtModificarDui'] !== null)
                        $('#txtModificarDui').val(datos['txtModificarDui']);

                    if (datos['txtModificarTelefono'] !== null)
                        $('#txtModificarTelefono').val(datos['txtModificarTelefono']);

                    if (datos['txtModificarDireccion'] !== null)
                        $('#txtModificarDireccion').val(datos['txtModificarDireccion']);

                    if (datos['txtModificarCoreo'] !== null)
                        $('#txtModificarCoreo').val(datos['txtModificarCoreo']);
                }
            </script>

            <asp:UpdatePanel ID="upUsuario" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class='d-flex justify-content-center w-100'>
                        <div class="w-75">
                            <asp:GridView PageIndex="5" CssClass="table table-dark table-hover table-bordered text-center mt-3 w-100" ID="tablaUsuario" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sqlUsuarios" OnRowDataBound="tablaUsuario_RowDataBound1" OnSelectedIndexChanged="tablaUsuario_SelectedIndexChanged" AllowPaging="True">
                                <Columns>
                                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Image runat="server" ImageUrl="~/img/user.png"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Nombre completo" HeaderText="Nombre completo" ReadOnly="True" SortExpression="Nombre completo" />
                                    <asp:BoundField DataField="tipo_usuario" HeaderText="Tipo de usuario" SortExpression="tipo_usuario" />
                                    <asp:BoundField DataField="Estado" HeaderText="Estado" ReadOnly="True" SortExpression="Estado" />
                                    <asp:CommandField ButtonType="Image" HeaderText="Opciones" SelectImageUrl="~/img/delete.png" ShowSelectButton="True" />
                                    <asp:CommandField ButtonType="Image" SelectImageUrl="~/img/update.png" ShowSelectButton="True" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="tablaUsuario" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="btnModificar" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnNuevoUsuario" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </section>

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
                            <label for="txtNuevoTelefonoUsuario">Numero telefonico:</label>
                            <asp:TextBox ID="txtNuevoTelefonoUsuario" ValidationGroup="nuevoUsuario" TextMode="Phone" runat="server" CssClass="form-control" placeholder="Numero telefonico" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNuevoTelefonoUsuario" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="El numero de telefono es obligatorio" CssClass="blockquote-footer text-danger"/>
                            <asp:RegularExpressionValidator ControlToValidate="txtNuevoTelefonoUsuario" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ValidationExpression="[2,7][0-9]{3}-[0-9]{4}" ErrorMessage="El numero telefonico no es valido" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtNuevoDui">DUI:</label>
                            <asp:TextBox ID="txtNuevoDui" ValidationGroup="nuevoUsuario" TextMode="Phone" runat="server" CssClass="form-control" placeholder="DUI" />
                            <asp:RegularExpressionValidator ControlToValidate="txtNuevoDui" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ValidationExpression="[0-9]{8}-[0-9]" ErrorMessage="El dui es invalido" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtNuevaFecha">Fecha de nacimiento:</label>
                            <asp:TextBox ID="txtNuevaFecha" ValidationGroup="nuevoUsuario" TextMode="Date" runat="server" CssClass="form-control" placeholder="Fecha" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNuevaFecha" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="La fecha es obligatoria" CssClass="blockquote-footer text-danger"/>
                            <asp:CompareValidator ControlToValidate="txtNuevaFecha" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="La fecha debe de ser inferior" ControlToCompare="txtFechaActual" Type="Date" Operator="LessThanEqual" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="ddlTipoUsuario">Tipo de usuario:</label>
                            <asp:DropDownList ID="ddlTipoUsuario" runat="server" CssClass="form-control">
                                <asp:ListItem Value="1">Contador</asp:ListItem>
                                <asp:ListItem Value="2">Gestor educativo</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="txtDireccion">Direccion:</label>
                            <asp:TextBox ID="txtDireccion" ValidationGroup="nuevoUsuario" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Direccion" />
                            <asp:RequiredFieldValidator ControlToValidate="txtDireccion" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="La direccion es obligatoria" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtNuevaClaveAleatoria">Clave del usuario:</label>

                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <button id="btnClaveAleatoria" type="button" class="input-group-text btn btn-danger">Aleatorio</button>
                                </div>

                                <asp:TextBox CssClass="form-control" ID="txtNuevaClaveAleatoria" runat="server" ValidationGroup="nuevoUsuario" placeholder="Codigo"/>
                            </div>

                            <asp:RequiredFieldValidator ControlToValidate="txtNuevaClaveAleatoria" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="La clave es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnNuevoUsuario" ValidationGroup="nuevoUsuario" runat="server" CssClass="btn btn-primary" Text="Guardar usuario" OnClick="btnNuevoUsuario_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de modificar -->
        <div class="modal fade" id="modalModificarUsuario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">Modificar Usuario</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input id="txtModId" runat="server" type="hidden" />

                        <div class="form-group">
                            <label for="txtModificarUsuario">Nombres:</label>
                            <asp:TextBox ID="txtModificarUsuario" ValidationGroup="modificarUsuario" runat="server" CssClass="form-control" placeholder="Nombre de usuario" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarUsuario" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El nombre del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtModificarApellido">Apellidos:</label>
                            <asp:TextBox ID="txtModificarApellido" ValidationGroup="modificarUsuario" runat="server" CssClass="form-control" placeholder="Apellido de usuario" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarApellido" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El apellido del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtModificarCoreo">Correo electronico:</label>
                            <asp:TextBox ID="txtModificarCoreo" ValidationGroup="modificarUsuario" TextMode="Email" runat="server" CssClass="form-control" placeholder="Correo electronico" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarCoreo" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El correo electronico es obligatorio" CssClass="blockquote-footer text-danger"/>
                            <asp:RegularExpressionValidator ControlToValidate="txtModificarCoreo" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="El correo electronico no es valido" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtModificarTelefono">Numero telefonico:</label>
                            <asp:TextBox ID="txtModificarTelefono" ValidationGroup="modificarUsuario" TextMode="Phone" runat="server" CssClass="form-control" placeholder="Numero telefonico" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarTelefono" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El numero de telefono es obligatorio" CssClass="blockquote-footer text-danger"/>
                            <asp:RegularExpressionValidator ControlToValidate="txtModificarTelefono" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ValidationExpression="[2,7][0-9]{3}-[0-9]{4}" ErrorMessage="El numero telefonico no es valido" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtModificarDui">DUI:</label>
                            <asp:TextBox ID="txtModificarDui" ValidationGroup="modificarUsuario" TextMode="Phone" runat="server" CssClass="form-control" placeholder="DUI" />
                            <asp:RegularExpressionValidator ControlToValidate="txtModificarDui" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ValidationExpression="[0-9]{8}-[0-9]" ErrorMessage="El dui es invalido" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtModificarFecha">Fecha de nacimiento:</label>
                            <asp:TextBox ID="txtModificarFecha" ValidationGroup="modificarUsuario" TextMode="Date" runat="server" CssClass="form-control" placeholder="Fecha" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarFecha" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="La fecha es obligatoria" CssClass="blockquote-footer text-danger"/>
                            <asp:CompareValidator ControlToValidate="txtModificarFecha" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="La fecha debe de ser inferior" ControlToCompare="txtFechaActual" Type="Date" Operator="LessThanEqual" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="ddlModificarTipo">Tipo de usuario:</label>
                            <asp:DropDownList ID="ddlModificarTipo" runat="server" CssClass="form-control">
                                <asp:ListItem Value="1">Contador</asp:ListItem>
                                <asp:ListItem Value="2">Gestor educativo</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="txtModificarDireccion">Direccion:</label>
                            <asp:TextBox ID="txtModificarDireccion" ValidationGroup="modificarUsuario" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Direccion" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarDireccion" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="La direccion es obligatoria" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtModificarClave">Clave del usuario:</label>

                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <button id="btnModClaveAleatoria" type="button" class="input-group-text btn btn-danger"><i id="contenidoIcon" class="material-icons">remove_red_eye</i></button>
                                </div>

                                <asp:TextBox CssClass="form-control" ID="txtModificarClave" TextMode="Password" runat="server" ValidationGroup="nuevoUsuario" placeholder="Clave"/>
                            </div>

                            <asp:RequiredFieldValidator ControlToValidate="txtModificarClave" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="La clave es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-check">
                            <input type="checkbox" runat="server" class="form-check-input" id="chkEstado" />
                            <label class="form-check-label" for="chkEstado">Activo.</label>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnModificar" ValidationGroup="modificarUsuario" runat="server" CssClass="btn btn-primary" Text="Modificar usuario" OnClick="btnModificar_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Pie de la pagina web -->
        <div class="container-fluid m-0 p-0 fixed-bottom">
            <button type="button" class="btn btn-info ml-2 mb-2" data-toggle="modal" data-target="#modalNuevoUsuario">Nuevo usuario</button>
        
            <footer class="bg-danger text-white text-center py-2">
                <span class="font-weight-bold">Universidad Don Bosco<small class="font-weight-normal ml-1"> PILET 2018 </small></span>
            </footer>
        </div>
    
        <script src="../js/jquery-3.2.1.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>

        <div id="_clientScript" runat="server"></div>

        <script>
            $(document).ready(function () {
                function nuevaClave() {
                    var letras = new Array("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0");
                    var clave = letras[Math.floor(Math.random() * letras.length)];

                    for (var i = 0; i < (Math.floor(Math.random() * 9) + 3) ; i++) {
                        clave += letras[Math.floor(Math.random() * letras.length)];
                    }


                    $("#txtNuevaClaveAleatoria").val(clave);
                }
                $("#modalNuevoUsuario").on('shown.bs.modal', function (e) {
                    $('#txtNuevaFecha').val($('#txtFechaActual').val()).change();
                    nuevaClave();
                });

                $('#btnNuevoUsuario').click(function () {
                    $('#modalNuevoUsuario').modal('toggle');
                });

                $("#modalModificarUsuario").on('shown.bs.modal', function (e) {
                    $("#contenidoIcon").html("remove_red_eye");
                    $('#txtModificarClave').prop('type', 'password');
                });

                $("#btnClaveAleatoria").click(function () {
                    nuevaClave();
                });

                $('#btnModificar').click(function () {
                    $('#modalModificarUsuario').modal('toggle');
                });


                $('#btnModClaveAleatoria').click(function () {
                    if ($("#contenidoIcon").html() == "format_clear") {
                        $("#contenidoIcon").html("remove_red_eye");
                        $('#txtModificarClave').prop('type', 'password');
                    }
                    else {
                        $("#contenidoIcon").html("format_clear");
                        $('#txtModificarClave').prop('type', 'text');
                    }
                });
            });
        </script>
    </form>
</body>
</html>

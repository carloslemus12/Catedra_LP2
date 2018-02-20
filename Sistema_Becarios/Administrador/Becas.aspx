<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Becas.aspx.cs" Inherits="Administrador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestion Becarios</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
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
                    
                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Usuarios.aspx">Usuarios</a>
                    </li>

                    <li class="nav-item active">
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

        <section class="container">

            <asp:SqlDataSource ID="sqlProgramasBecas" runat="server"></asp:SqlDataSource>
            <asp:GridView CssClass="table table-dark table-hover" ID="tablaProgramasBecas" runat="server" AllowPaging="True" DataSourceID="sqlProgramasBecas" PageSize="10"></asp:GridView>

        </section>

        <!-- // ///////////////////////////////////////////// -->

        <div class="modal fade" id="modalNuevoPrograma" tabindex="-1" role="dialog" aria-labelledby="modalNuevoPrograma" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Nuevo programa de beca</h5>
                
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                    
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <button id="btnCambiarTxtNuevoCodigo" type="button" class="input-group-text bg-danger text-white">&#128273;</button>
                                </div>
                                
                                <input type="text" maxlength="4" class="form-control" id="txtNuevoCodigo" placeholder="Codigo" runat="server" readonly/>
                            </div>

                            <asp:RequiredFieldValidator ControlToValidate="txtNuevoCodigo" ValidationGroup="nuevoPrograma" ErrorMessage="El codigo del programa es obligatorio" runat="server" Display="Dynamic" CssClass="blockquote-footer text-danger" />
                            <asp:RegularExpressionValidator ControlToValidate="txtNuevoCodigo" ValidationGroup="nuevoPrograma" ErrorMessage="El codigo no es permitido" runat="server" Display="Dynamic" CssClass="blockquote-footer text-danger" ValidationExpression="^[A-Z]{4}$"/>
                        </div>

                        <div class="form-group">
                            <label for="txtNuevoNombrePrograma">Nombre del programa</label>
                            <input class="form-control" id="txtNuevoNombrePrograma" runat="server" placeholder="Nombre" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNuevoNombrePrograma" ValidationGroup="nuevoPrograma" ErrorMessage="El nombre del programa es obligatorio" runat="server" Display="Dynamic" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtNuevaDescripcionProgrma">Decripcion del programa</label>
                            <textarea class="form-control" id="txtNuevaDescripcionProgrma" runat="server" rows="3"></textarea>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnGuardarPrograma" runat="server" ValidationGroup="nuevoPrograma" CssClass="btn btn-success" Text="Guardar programa" />
                    </div>
                </div>
            </div>
        </div>

    </form>

    <!-- Pie de la pagina web -->
    <div class="container-fluid m-0 p-0 fixed-bottom">
        <button type="button" class="btn btn-info ml-2 mb-2" data-toggle="modal" data-target="#modalNuevoPrograma">Nueva programa de becas</button>
        
        <footer class="bg-danger text-white text-center py-2">
            <span class="font-weight-bold">Universidad Don Bosco<small class="font-weight-normal ml-1"> PILET 2018 </small></span>
        </footer>
    </div>

    <script src="../js/jquery-3.2.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script>
        // Funcion para obtener solo los primeros 4 numeros
        function ObtenerCodigoPorNombre(txtNombre) {
            var tamaño = txtNombre.length;

            var limite = (tamaño >= 4) ? 4 : tamaño;

            var r = "";

            for (var i = 0; i < limite; i++) {
                r += txtNombre.charAt(i);
            }

            return r.toUpperCase();
        }

        $(document).ready(function () {
            // Textboxs con informacion sobre los programas de becas
            var $txtNuevoCodigo = $("#txtNuevoCodigo");
            var $txtNuevoNombre = $('#txtNuevoNombrePrograma');

            $("#btnCambiarTxtNuevoCodigo").click(function () {
                var desactivado = $txtNuevoCodigo.prop('readonly');
                
                if (desactivado) {
                    $txtNuevoCodigo.prop('readonly', false);
                    $txtNuevoCodigo.val("").change();
                } else {
                    $txtNuevoCodigo.prop('readonly', true);
                    $txtNuevoCodigo.val(ObtenerCodigoPorNombre($txtNuevoNombre.val())).change();
                }
            });


            $txtNuevoNombre.on('input', function (e) {
                var desactivado = $txtNuevoCodigo.prop('readonly');

                if (desactivado) {
                    $txtNuevoCodigo.val(ObtenerCodigoPorNombre($(this).val())).change();
                }
            });

        });
    </script>
</body>
</html>

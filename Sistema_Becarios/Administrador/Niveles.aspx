<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Niveles.aspx.cs" Inherits="Administrador_Niveles" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestion niveles de estudio</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/estilos-app.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="txtIndiceNivel" runat="server" />
        <asp:SqlDataSource ID="sqlNiveles" runat="server" ConnectionString="<%$ ConnectionStrings:OdioTodoConnectionString %>" DeleteCommand="DELETE FROM [Niveles] WHERE [indice] = @indice" InsertCommand="INSERT INTO [Niveles] ([nombre]) VALUES (@nombre)" SelectCommand="SELECT [indice], [nombre] FROM [Niveles] WHERE ([nombre] LIKE '%' + @nombre + '%')" UpdateCommand="UPDATE [Niveles] SET [nombre] = @nombre WHERE [indice] = @indice">
            <DeleteParameters>
                <asp:Parameter Name="indice" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nombre" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtNombreFiltro" DefaultValue="%" Name="nombre" PropertyName="Text" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="nombre" Type="String" />
                <asp:Parameter Name="indice" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

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

                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Becas.aspx">Programas de becas</a>
                    </li>
              
                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Universidades.aspx">Universidades</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Carreras.aspx">Carreras</a>
                    </li>

                    <li class="nav-item active">
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

        <div class="container-fluid bg-dark d-flex justify-content-center">
            <div class="form-inline my-2">

                <div class="form-group">
                    <asp:TextBox CssClass="form-control my-0" ID="txtNombreFiltro" Text="" runat="server" />
                </div>

                <button type="submit" class="btn btn-danger ml-2 my-0" id="btnFiltrar" runat="server">Filtrar</button>
            </div>
        </div>

        <asp:ScriptManager ID="scrControl" runat="server"></asp:ScriptManager>
        <script>
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(PageLoadingHandler);
            function PageLoadingHandler(sender, args) {
                var datos = args.get_dataItems();

                if (datos['txtIndiceNivel'] !== null)
                    $('#txtIndiceNivel').val(datos['txtIndiceNivel']);

                if (datos['txtNombreModificarNivel'] !== null)
                    $('#txtNombreModificarNivel').val(datos['txtNombreModificarNivel']);
            }
        </script>

        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:GridView ID="tablaNiveles" CssClass="mt-3 table table-dark table-hover text-center" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="indice" DataSourceID="sqlNiveles" OnPreRender="tablaNiveles_PreRender" OnRowCreated="tablaNiveles_RowCreated" OnSelectedIndexChanged="tablaNiveles_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="indice" HeaderText="indice" InsertVisible="False" ReadOnly="True" SortExpression="indice" Visible="False" />
                        <asp:BoundField DataField="nombre" HeaderText="Carrera" SortExpression="nombre" />
                        <asp:CommandField ButtonType="Image" HeaderText="Opciones" SelectImageUrl="~/img/update.png" ShowSelectButton="True" />
                        <asp:CommandField ButtonType="Image" DeleteImageUrl="~/img/delete.png" ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="modal fade" id="modalNuevoNivel" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Nuevo nivel estudiantil</h5>
                        
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                    
                        <div class="form-group">
                            <label for="txtNombreNuevoNivel">Nivel estudiantil:</label>
                            <asp:TextBox CssClass="form-control" ID="txtNombreNuevoNivel" ValidationGroup="nuevoNivel" runat="server" placeholder="Nivel" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNombreNuevoNivel" ValidationGroup="nuevoNivel" runat="server" ErrorMessage="El nombre del nivel es obligatoria" CssClass="text-danger blockquote-footer text-danger" />
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnNuevaCarrera" runat="server" CssClass="btn btn-success" Text="Guardar nivel" ValidationGroup="nuevoNivel" OnClick="btnNuevaCarrera_Click"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalModificarNivel" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">Modificar nivel estudiantil</h5>
                        
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                    
                        <div class="form-group">
                            <label for="txtNombreModificarNivel">Nivel estudiantil:</label>
                            <asp:TextBox CssClass="form-control" ID="txtNombreModificarNivel" ValidationGroup="modificarNivel" runat="server" placeholder="Nivel" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNombreModificarNivel" ValidationGroup="modificarNivel" runat="server" ErrorMessage="El nombre del nivel es obligatoria" CssClass="text-danger blockquote-footer text-danger" />
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnModificarNivel" runat="server" CssClass="btn btn-success" Text="Modificar nivel" ValidationGroup="modificarNivel" OnClick="btnModificarNivel_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Pie de la pagina web -->
    <div class="container-fluid m-0 p-0 fixed-bottom">
        <button type="button" class="btn btn-info ml-2 mb-2" data-toggle="modal" data-target="#modalNuevoNivel">Nuevo nivel</button>
        
        <footer class="bg-danger text-white text-center py-2">
            <span class="font-weight-bold">Universidad Don Bosco<small class="font-weight-normal ml-1"> PILET 2018 </small></span>
        </footer>
    </div>

    <script src="../js/jquery-3.2.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Universidades.aspx.cs" Inherits="Administrador_Universidades" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestion Universidades</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/estilos-app.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <input type="hidden" id="txtIndice" runat="server" />

        <asp:SqlDataSource ID="sqlUniversidades" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" DeleteCommand="DELETE FROM [Universidades] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Universidades] ([universidad]) VALUES (@universidad)" SelectCommand="SELECT [ID], [universidad] FROM [Universidades] WHERE ([universidad] LIKE '%' + @universidad + '%')" UpdateCommand="UPDATE [Universidades] SET [universidad] = @universidad WHERE [ID] = @ID">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="universidad" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtNombreFiltro" DefaultValue="%" Name="universidad" PropertyName="Text" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="universidad" Type="String" />
                <asp:Parameter Name="ID" Type="Int32" />
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
                        <a class="nav-link" href="/Administracion/Usuarios">Usuarios</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administracion/Becas">Programas de becas</a>
                    </li>
              
                    <li class="nav-item active">
                        <a class="nav-link" href="/Administracion/Universidades">Universidades</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administracion/Carreras">Carreras</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administracion/Niveles_Educativos">Niveles de estudio</a>
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

        <div class="modal fade" id="modalNuevaUniversidad" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Nueva universidad</h5>
                        
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                    
                        <div class="form-group">
                            <label for="txtNombreNuevaUniversidad">Nombre universidad:</label>
                            <asp:TextBox CssClass="form-control" ValidationGroup="nuevaUniversidad" ID="txtNombreNuevaUniversidad" runat="server" placeholder="Universidad" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNombreNuevaUniversidad" ValidationGroup="nuevaUniversidad" runat="server" ErrorMessage="El nombre de la universidad es obligatoria" CssClass="text-danger blockquote-footer text-danger" />
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnNuevaUniversidad" runat="server" CssClass="btn btn-success" Text="Guardar universidad" ValidationGroup="nuevaUniversidad" OnClick="btnNuevaUniversidad_Click"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalModificarUniversidad" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">Modificar universidad</h5>
                        
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                    
                        <div class="form-group">
                            <label for="txtNombreModificarUniversidad">Nombre universidad:</label>
                            <asp:TextBox CssClass="form-control" ValidationGroup="modificarUniversidad" ID="txtNombreModificarUniversidad" runat="server" placeholder="Universidad" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNombreModificarUniversidad" ValidationGroup="modificarUniversidad" runat="server" ErrorMessage="El nombre de la universidad es obligatoria" CssClass="text-danger blockquote-footer text-danger" />
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnModificarUniversidad" runat="server" CssClass="btn btn-success" Text="Modificar universidad" ValidationGroup="modificarUniversidad" OnClick="btnModificarUniversidad_Click"/>
                    </div>
                </div>
            </div>
        </div>

        <asp:ScriptManager ID="scrControl" runat="server"></asp:ScriptManager>
        <script>
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(PageLoadingHandler);
            function PageLoadingHandler(sender, args) {
                var datos = args.get_dataItems();

                if (datos['txtIndice'] !== null)
                    $('#txtIndice').val(datos['txtIndice']);

                if (datos['txtNombreModificarUniversidad'] !== null)
                    $('#txtNombreModificarUniversidad').val(datos['txtNombreModificarUniversidad']);
            }
        </script>

        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:GridView ID="tablaUniversidad" CssClass="table table-dark table-hover mt-3 text-center" PageSize="5" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sqlUniversidades" AllowPaging="True" OnPreRender="tablaUniversidad_PreRender" OnRowCreated="tablaUniversidad_RowCreated" OnSelectedIndexChanged="tablaUniversidad_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
                        <asp:BoundField DataField="universidad" HeaderText="Universidad" SortExpression="universidad" />
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/img/update.png" ShowSelectButton="True" />
                        <asp:CommandField ButtonType="Image" DeleteImageUrl="~/img/delete.png" ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>

        <!-- Pie de la pagina web -->
        <div id="divFooter" runat="server" class="container-fluid m-0 p-0 fixed-bottom">
            <button type="button" class="btn btn-info ml-2 mb-2" data-toggle="modal" data-target="#modalNuevaUniversidad">Nueva universidad</button>
        
            <footer class="bg-danger text-white text-center py-2">
                <span class="font-weight-bold">Universidad Don Bosco<small class="font-weight-normal ml-1"> PILET 2018 </small></span>
            </footer>
        </div>

    </form>

    <script src="../js/jquery-3.2.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>

</body>
</html>

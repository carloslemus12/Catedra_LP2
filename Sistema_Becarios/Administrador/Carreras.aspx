<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Carreras.aspx.cs" Inherits="Administrador_Carreras" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestion carreras</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/estilos-app.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:SqlDataSource ID="sqlCarreras" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" DeleteCommand="DELETE FROM [Carreras] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Carreras] ([carrera]) VALUES (@carrera)" SelectCommand="SELECT [ID], [carrera] FROM [Carreras] WHERE ([carrera] LIKE '%' + @carrera + '%')" UpdateCommand="UPDATE [Carreras] SET [carrera] = @carrera WHERE [ID] = @ID">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="carrera" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtNombreFiltro" DefaultValue="%" Name="carrera" PropertyName="Text" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="carrera" Type="String" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <input id="txtIndiceCarrera" runat="server" type="hidden" />

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
              
                    <li class="nav-item">
                        <a class="nav-link" href="/Administracion/Universidades">Universidades</a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="/Administracion/Carreras">Carreras</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administracion/Niveles_Educativos">Niveles de estudio</a>
                    </li>

                    <li class="nav-item d-block d-lg-none">
                        <a class="nav-link" href="/Clave">Cambiar clave</a>
                    </li>

                    <li class="nav-item d-block d-lg-none">
                        <asp:Button style="background-color:transparent; border:none; cursor: pointer;" CssClass="text-secundary text-left w-100 nav-link" runat="server" Text="Cerrar secion" OnClick="btnCerrarSecion_Click" />
                    </li>
                </ul>

                <div class="d-none flex-row justify-content-center d-lg-flex">
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <img src="../img/settings.svg" alt="" id="menuAjustes" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" width="30" height="30" />
                        

                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="menuAjustes">
                                <a class="dropdown-item" href="/Clave">Cambiar clave</a>
                                <asp:Button style="background-color:transparent; border:none; cursor: pointer;" CssClass="text-dark text-center w-100 nav-link" runat="server" Text="Cerrar secion" OnClick="btnCerrarSecion_Click" />
                            </div>                           
                        </li>
                    </ul>

                </div>
            
            </div>
        </nav>

        <div class="container-fluid bg-dark d-flex justify-content-center">
            <div class="form-inline my-2">

                <div class="form-group">
                    <asp:TextBox AutoPostBack="true" CssClass="form-control my-0" ID="txtNombreFiltro" Text="" runat="server" />
                </div>

            </div>
        </div>

        <asp:ScriptManager ID="scrControl" runat="server"></asp:ScriptManager>
        <script>
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(PageLoadingHandler);
            function PageLoadingHandler(sender, args) {
                var datos = args.get_dataItems();

                if (datos['txtIndiceCarrera'] !== null)
                    $('#txtIndiceCarrera').val(datos['txtIndiceCarrera']);

                if (datos['txtModificarCarrera'] !== null)
                    $('#txtModificarCarrera').val(datos['txtModificarCarrera']);
            }
        </script>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class='d-flex justify-content-center w-100'>
                    <div class="w-75">
                        <asp:GridView ID="tablaCarrera" PageSize="5" runat="server" CssClass="table table-dark table-hover mt-3 text-center" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sqlCarreras" OnPreRender="tablaCarrera_PreRender" OnRowCreated="tablaCarrera_RowCreated" OnSelectedIndexChanged="tablaCarrera_SelectedIndexChanged">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
                                <asp:BoundField DataField="carrera" HeaderText="Carrera" SortExpression="carrera" />
                                <asp:CommandField ButtonType="Image" SelectImageUrl="~/img/update.png" ShowSelectButton="True" HeaderText="Opciones" />
                                <asp:CommandField ButtonType="Image" DeleteImageUrl="~/img/delete.png" ShowDeleteButton="True" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtNombreFiltro" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>

        <div class="modal fade" id="modalNuevaCarreras" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Nueva carrera</h5>
                        
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                    
                        <div class="form-group">
                            <label for="txtNombreNuevaCarrera">Nombre carrera:</label>
                            <asp:TextBox CssClass="form-control" ID="txtNombreNuevaCarrera" ValidationGroup="nuevaCarrera" runat="server" placeholder="Carrera" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNombreNuevaCarrera" ValidationGroup="nuevaCarrera" runat="server" ErrorMessage="El nombre de la carrera es obligatoria" CssClass="text-danger blockquote-footer text-danger" />
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnNuevaCarrera" runat="server" CssClass="btn btn-success" Text="Guardar carrera" ValidationGroup="nuevaCarrera" OnClick="btnNuevaCarrera_Click"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalModificarCarrera" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title">Modificar carrera</h5>
                        
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                    
                        <div class="form-group">
                            <label for="txtModificarCarrera">Nombre carrera:</label>
                            <asp:TextBox CssClass="form-control" ID="txtModificarCarrera" ValidationGroup="modificarCarrera" runat="server" placeholder="Carrera" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarCarrera" ValidationGroup="modificarCarrera" runat="server" ErrorMessage="El nombre de la carrera es obligatoria" CssClass="text-danger blockquote-footer text-danger" />
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnModificar" runat="server" CssClass="btn btn-success" Text="Modificar carrera" ValidationGroup="modificarCarrera" OnClick="btnModificar_Click"/>
                    </div>
                </div>
            </div>
        </div>

    </form>

    <!-- Pie de la pagina web -->
    <div class="container-fluid m-0 p-0 fixed-bottom">
        <button type="button" class="btn btn-info ml-2 mb-2" data-toggle="modal" data-target="#modalNuevaCarreras">Nueva carrera</button>
        
        <footer class="bg-danger text-white text-center py-2">
            <span class="font-weight-bold">Universidad Don Bosco<small class="font-weight-normal ml-1"> PILET 2018 </small></span>
        </footer>
    </div>

    <script src="../js/jquery-3.2.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</body>
</html>

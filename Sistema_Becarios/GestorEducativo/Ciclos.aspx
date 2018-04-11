<%@ Page Title="" Language="C#" MasterPageFile="~/GestorEducativo/MasterGestorEducativo.master" AutoEventWireup="true" CodeFile="Ciclos.aspx.cs" Inherits="GestorEducativo_Ciclos" %>

<asp:Content ID="cont_titulo" ContentPlaceHolderID="content_titulo" Runat="Server">
    Ciclos
</asp:Content>

<asp:Content ID="cont_menu" ContentPlaceHolderID="content_menu" Runat="Server">
    <li class="nav-item">
        <a class="nav-link" href="/GestorEducativo/Becarios">Volver</a>
    </li>

    <asp:Button ID="btn_nuevoCiclo" runat="server" CssClass="btn btn-danger" data-toggle="modal" data-target="#modal_nuevo_becario" Text="Nuevo ciclo" OnClick="btn_nuevoCiclo_Click" />
</asp:Content>

<asp:Content ID="cont_cuerpo" ContentPlaceHolderID="content_body" Runat="Server">
    <asp:SqlDataSource ID="sql_incidencia" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT ID, detalle FROM Incidentes WHERE Ciclo  = @Ciclo" >
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_ciclos" Name="Ciclo" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_desembolso" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT Desembolsos.ID, Desembolsos.TipoDesembolso, CONCAT(Desembolsos.monto_desembolso, '$') AS [monto_desembolso], Desembolsos.fecha_desembolso 
FROM Ciclos 
INNER JOIN Desembolsos 
ON Ciclos.ID = Desembolsos.Ciclo
WHERE Ciclos.ID =  @ciclo 
AND Desembolsos .Presupuesto = @presupuesto" >
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_ciclos" Name="ciclo" PropertyName="SelectedValue" />
            <asp:QueryStringParameter Name="presupuesto" QueryStringField="presupuesto" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_ciclos" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT CONCAT( 'Ciclo #', ROW_NUMBER() OVER(ORDER BY Ciclos.ID ASC)) as [Ciclo], Ciclos.ID FROM Ciclos INNER JOIN DatosAcademicos ON Ciclos.Datos_becario = DatosAcademicos.ID WHERE DatosAcademicos.ID = @datos" >
        <SelectParameters>
            <asp:QueryStringParameter Name="datos" QueryStringField="datos" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_materias" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT Notas.ID, Notas.nombre_materia, Notas.uv_materia FROM Notas INNER JOIN Ciclos ON Notas.Ciclo = Ciclos.ID WHERE Ciclos.ID = @datos" DeleteCommand="DELETE FROM [Becarios] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Becarios] ([codigo_programa], [fecha_ingreso], [codigo_becario], [Usuario]) VALUES (@codigo_programa, @fecha_ingreso, @codigo_becario, @Usuario)" UpdateCommand="UPDATE [Becarios] SET [codigo_programa] = @codigo_programa, [fecha_ingreso] = @fecha_ingreso, [codigo_becario] = @codigo_becario, [Usuario] = @Usuario WHERE [ID] = @ID" >
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="codigo_programa" Type="String" />
            <asp:Parameter Name="fecha_ingreso" Type="String" />
            <asp:Parameter Name="codigo_becario" Type="String" />
            <asp:Parameter Name="Usuario" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_ciclos" Name="datos" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="codigo_programa" Type="String" />
            <asp:Parameter Name="fecha_ingreso" Type="String" />
            <asp:Parameter Name="codigo_becario" Type="String" />
            <asp:Parameter Name="Usuario" Type="Int32" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <div class="w-100 d-flex justify-content-center align-content-center px-5">
        <asp:DropDownList AutoPostBack="true" CssClass="form-control" ID="ddl_ciclos" runat="server" DataSourceID="sql_ciclos" DataTextField="Ciclo" DataValueField="ID" OnDataBound="ddl_ciclos_DataBound"></asp:DropDownList>
    </div>

    <asp:ScriptManager ID="scr_manager" runat="server"></asp:ScriptManager>
    <script>
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(PageLoadingHandler);

            function PageLoadingHandler(sender, args) {
                var datos = args.get_dataItems();
                /*
                    
                */

                if (datos['txtModificarNombreMateria'] !== null)
                    $('#txtModificarNombreMateria').val(datos['txtModificarNombreMateria']);

                if (datos['txtModificarNota'] !== null)
                    $('#txtModificarNota').val(datos['txtModificarNota']);

                if (datos['txtModificarUv'] !== null)
                    $('#txtModificarUv').val(datos['txtModificarUv']);

                if (datos['txtModId'] !== null)
                    $('#txtModId').val(datos['txtModId']);
            }
        </script>

    <div class="container mt-3" id="div_cont" runat="server">
        <div class="row">
            <div class="col-sm-12 col-md-4">
                <div class="card" style="width: 100%;">
                    <center> <img class="card-img-top mt-2" src="../img/books.svg" style="width: 10rem;" /> </center>
                    <div class="card-body">
                        <h5 class="card-title">Materias:</h5>
                        <asp:UpdatePanel ID="up_materias" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="tbl_materias" border="0" BorderColor="White" CssClass="table-hover text-center w-100" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sql_materias" OnRowCreated="tbl_materias_RowCreated" AllowPaging="True" OnSelectedIndexChanged="tbl_materias_SelectedIndexChanged">
                                    <Columns>
                                        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
                                        <asp:BoundField DataField="nombre_materia" HeaderText="Materia" SortExpression="nombre_materia" />
                                        <asp:BoundField DataField="uv_materia" HeaderText="UV" SortExpression="uv_materia" />
                                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/img/edit.png" ShowSelectButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="card-footer bg-danger">
                        <button type="button" class="btn btn-danger w-100" data-toggle="modal" data-target="#modal_nueva_materia">
                            Añadir nueva materiar nueva materia</button>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md">
                <div class="card">
                    <div class="card-header bg-warning text-white display-4 text-center" style="font-size: 2rem;">
                        Informacion del becario
                    </div>
                    <div class="card-body">
                        <blockquote class="blockquote mb-0">
                            <p>
                                El becario <%= (becario.Usuarios.Nombres + " " + becario.Usuarios.Apellidos).Trim() %> esta curzando la carrera <strong><%= datos.Carreras.carrera %></strong>
                                , en el nivel educativo de <strong><%= datos.Niveles.nivel_educativo %></strong> en la Universidad: <strong><%= datos.Universidades.universidad %></strong>.
                            </p>
                            <footer class="blockquote-footer">
                                Telefono: <cite title="Source Title"><%= becario.Usuarios.telefono %></cite>
                                Dui: <cite title="Source Title"><%= becario.Usuarios.dui %></cite>
                                Email: <cite title="Source Title"><%= becario.Usuarios.correo %></cite>
                            </footer>
                            <table class="table table-dark table-hover text-center mb-0" style="font-size: 15px;">
                                <thead>
                                    <tr>
                                        <th scope="col" class="bg-danger">Tipo</th>
                                        <th scope="col">Presupuesto</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    <tr>
                                        <th scope="row" class="bg-danger">Matricula</th>
                                        <td><%= "" + matricula + "$" %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="bg-danger">Manuntencion</th>
                                        <td><%= "" + manuntencion + "$" %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="bg-danger">Libro</th>
                                        <td><%= "" + libros + "$" %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="bg-danger">Araceles</th>
                                        <td><%= "" + aranceles + "$" %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="bg-danger">Graduacion</th>
                                        <td><%= "" + graduacion + "$" %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="bg-danger">Seguro</th>
                                        <td><%= "" + seguro + "$" %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </blockquote>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12 col-md-9 mt-sm-2 mt-md-1">
                <div class="card text-center">
                    <div class="card-header bg-dark text-white">
                        Historial de desembolso
                    </div>
                    <div class="card-body p-0">
                        <asp:UpdatePanel ID="up_desembolso" runat="server">
                            <ContentTemplate>
                                <asp:GridView BorderColor="White" CssClass="table table-hover table-bordered w-100 my-0" ID="tbl_desembolsos" runat="server" AutoGenerateColumns="False" DataSourceID="sql_desembolso" DataKeyNames="ID" OnSelectedIndexChanged="tbl_desembolsos_SelectedIndexChanged">
                                    <Columns>
                                        <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                        <asp:BoundField DataField="TipoDesembolso" HeaderText="Tipo" SortExpression="TipoDesembolso" />
                                        <asp:BoundField DataField="monto_desembolso" HeaderText="Cantidad" ReadOnly="True" SortExpression="monto_desembolso" />
                                        <asp:BoundField DataField="fecha_desembolso" HeaderText="Fecha" SortExpression="fecha_desembolso" />
                                        <asp:CommandField ButtonType="Image" HeaderText="Devolver" SelectImageUrl="~/img/money-back.png" ShowSelectButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="card-footer bg-secondary p-0">
                        <button type="button" class="btn btn-secondary w-100" data-toggle="modal" data-target="#modal_desembolsar">
                            Desembolsar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12 mt-sm-2 mt-md-1">
                <div class="card text-center">
                    <div class="card-header bg-dark text-white">
                        Historial de incidencias
                    </div>
                    <div class="card-body p-0">
                        <asp:UpdatePanel ID="up_incedentes" runat="server">
                            <ContentTemplate>
                                <asp:GridView ShowHeader="false" BorderColor="White" CssClass="table table-dark table-hover table-bordered w-100 my-0" ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sql_incidencia" DataKeyNames="ID" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                    <Columns>
                                        <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                        <asp:BoundField DataField="detalle" HeaderText="detalle" SortExpression="detalle" />
                                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/img/delete_icon.png" ShowSelectButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="card-footer bg-warning mb-5 p-0 text-white">
                        <button type="button" class="btn btn-warning text-white w-100" data-toggle="modal" data-target="#modal_incidencias">
                            Añadir incidencia</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="modal fade" id="modal_incidencias" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success">
                    <h5 class="modal-title text-white">Nueva incidencia</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" class="text-white">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="txtIncidencia">Incidencia:</label>
                        <asp:TextBox ClientIDMode="Static" ID="txtIncidencia" ValidationGroup="incidencia" runat="server" CssClass="form-control" placeholder="Incidencia" TextMode="MultiLine" />
                        <asp:RequiredFieldValidator ControlToValidate="txtIncidencia" ValidationGroup="incidencia" Display="Dynamic" runat="server" ErrorMessage="El nombre del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btn_incidencia" ValidationGroup="incidencia" runat="server" CssClass="btn btn-success" Text="Añadir incidencia" OnClick="btn_incidencia_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- //////////////////////////////////////////////////////////////////////////// -->

    <div class="modal fade" id="modal_desembolsar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-dark text-white">
                    <h5 class="modal-title">Desembolsar:</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" class="text-white">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="ddl_tipo">Tipo de desembolso:</label>
                        <asp:DropDownList CssClass="form-control" ID="ddl_tipo" runat="server" ClientIDMode="Static">
                            <asp:ListItem Text="Trabajo de graduacion" Value="Trabajo de graduacion" />
                            <asp:ListItem Text="Araceles" Value="Araceles" />
                            <asp:ListItem Text="Libros" Value="Libros" />
                            <asp:ListItem Text="Manuntencion" Value="Manuntencion" />
                            <asp:ListItem Text="Matricula" Value="Matricula" />
                            <asp:ListItem Text="Seguro" Value="Seguro" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label for="txtDesembolso">Cantidad a desembolsar:</label>
                        <asp:TextBox ID="txtDesembolso" Text="1" ValidationGroup="desembolsar" type="number" runat="server" CssClass="form-control" placeholder="Cantdad a desembolsar" min="0" step="0.01" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtDesembolso" ValidationGroup="desembolsar" Display="Dynamic" runat="server" ErrorMessage="El desemolso es obligatorio" CssClass="blockquote-footer text-danger"/>
                        <asp:CompareValidator ControlToValidate="txtDesembolso" ValidationGroup="desembolsar" Display="Dynamic" runat="server" ErrorMessage="El desembolso debe de ser mayor que 0" ValueToCompare="0" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btn_desembolsar" runat="server" CssClass="btn btn-primary" Text="Desembolsar" OnClick="btn_desembolsar_Click" />
                </div>
            </div>
        </div>
    </div>

    <div id="_clientScript" runat="server"></div>

    <!-- /////////////////////////////////////////////////////////////////////////// -->

        <!-- Modal de las materias -->
        <div class="modal fade" id="modal_nueva_materia" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="txtNuevoNombreMateria">Materia:</label>
                            <asp:TextBox ClientIDMode="Static" ID="txtNuevoNombreMateria" ValidationGroup="nuevaMateria" runat="server" CssClass="form-control" placeholder="Nombre de usuario" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNuevoNombreMateria" ValidationGroup="nuevaMateria" Display="Dynamic" runat="server" ErrorMessage="El nombre del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtNuevaNota">Nota de la materia:</label>
                            <asp:TextBox ID="txtNuevaNota" Text="0" ValidationGroup="nuevaMateria" type="number" runat="server" CssClass="form-control" placeholder="Nota de la materia" min="0" step="0.01" max="10" ClientIDMode="Static" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNuevaNota" ValidationGroup="nuevaMateria" Display="Dynamic" runat="server" ErrorMessage="La nota es obligatoria" CssClass="blockquote-footer text-danger"/>
                            <asp:CompareValidator ControlToValidate="txtNuevaNota" ValidationGroup="nuevaMateria" Display="Dynamic" runat="server" ErrorMessage="La nota debe de ser mayor que 0" ValueToCompare="0" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                            <asp:CompareValidator ControlToValidate="txtNuevaNota" ValidationGroup="nuevaMateria" Display="Dynamic" runat="server" ErrorMessage="La nota debe de ser menor que 10" Type="Double" ValueToCompare="10" Operator="LessThanEqual" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtNuevoUv">UV de la materia:</label>
                            <asp:TextBox ID="txtNuevoUv" ClientIDMode="Static" Text="1" ValidationGroup="nuevaMateria" type="number" runat="server" CssClass="form-control" placeholder="UVS" min="1" max="5"/>
                            <asp:RequiredFieldValidator ControlToValidate="txtNuevoUv" ValidationGroup="nuevaMateria" Display="Dynamic" runat="server" ErrorMessage="El UV es obligatoria" CssClass="blockquote-footer text-danger"/>
                            <asp:CompareValidator ControlToValidate="txtNuevoUv" ValidationGroup="nuevaMateria" Display="Dynamic" runat="server" ErrorMessage="El UV debe de ser mayor que 1" ValueToCompare="1" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                            <asp:CompareValidator ControlToValidate="txtNuevoUv" ValidationGroup="nuevaMateria" Display="Dynamic" runat="server" ErrorMessage="El UV debe de ser menor que 5" ValueToCompare="5" Operator="LessThanEqual" CssClass="blockquote-footer text-danger" />
                        </div>
                    </div>
                    <div class="modal-footer"> 
                        <asp:Button ID="btn_nuevaMateria" runat="server" ValidationGroup="nuevaMateria" CssClass="btn btn-primary" Text="Añadir materia" OnClick="btn_nuevaMateria_Click" />
                    </div>
                </div>
            </div>
        </div>
    <!-- /////////////////////////////////////////////////////////////////////////// -->
    <asp:TextBox ID="txtModId" runat="server" type="hidden" ClientIDMode="Static" />
    <div class="modal fade" id="modal_modificar_materia" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Modificar materia</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="txtModificarNombreMateria">Materia:</label>
                            <asp:TextBox ID="txtModificarNombreMateria" ClientIDMode="Static" ValidationGroup="modificarMateria" runat="server" CssClass="form-control" placeholder="Nombre de usuario" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarNombreMateria" ValidationGroup="modificarMateria" Display="Dynamic" runat="server" ErrorMessage="El nombre del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtModificarNota">Nota de la materia:</label>
                            <asp:TextBox ID="txtModificarNota" Text="0" ClientIDMode="Static" ValidationGroup="modificarMateria" type="number" runat="server" CssClass="form-control" placeholder="Nota de la materia" min="0" step="0.01" max="10" />
                            <asp:RequiredFieldValidator ControlToValidate="txtNuevaNota" ValidationGroup="modificarMateria" Display="Dynamic" runat="server" ErrorMessage="La nota es obligatoria" CssClass="blockquote-footer text-danger"/>
                            <asp:CompareValidator ControlToValidate="txtModificarNota" ValidationGroup="modificarMateria" Display="Dynamic" runat="server" ErrorMessage="La nota debe de ser mayor que 0" ValueToCompare="0" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                            <asp:CompareValidator ControlToValidate="txtModificarNota" ValidationGroup="modificarMateria" Display="Dynamic" runat="server" ErrorMessage="La nota debe de ser menor que 10" Type="Double" ValueToCompare="10" Operator="LessThanEqual" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtModificarUv">UV de la materia:</label>
                            <asp:TextBox ID="txtModificarUv" Text="1" ClientIDMode="Static" ValidationGroup="modificarMateria" type="number" runat="server" CssClass="form-control" placeholder="UVS" min="1" max="5" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarUv" ValidationGroup="modificarMateria" Display="Dynamic" runat="server" ErrorMessage="El UV es obligatoria" CssClass="blockquote-footer text-danger"/>
                            <asp:CompareValidator ControlToValidate="txtModificarUv" ValidationGroup="modificarMateria" Display="Dynamic" runat="server" ErrorMessage="El UV debe de ser mayor que 1" ValueToCompare="1" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                            <asp:CompareValidator ControlToValidate="txtModificarUv" ValidationGroup="modificarMateria" Display="Dynamic" runat="server" ErrorMessage="El UV debe de ser menor que 5" ValueToCompare="5" Operator="LessThanEqual" CssClass="blockquote-footer text-danger" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btn_eliminarMateria" runat="server" CssClass="btn btn-danger" Text="Eliminar materia" OnClick="btn_eliminarMateria_Click" />
                        <asp:Button ID="btn_modificar" runat="server" ValidationGroup="modificarMateria" CssClass="btn btn-primary" Text="Modificar materia" OnClick="btn_modificar_Click" />
                    </div>
                </div>
            </div>
        </div>
    <!-- /////////////////////////////////////////////////////////////////////////// -->
</asp:Content>

<asp:Content ID="cont_script" ContentPlaceHolderID="cont_script" Runat="Server">
</asp:Content>


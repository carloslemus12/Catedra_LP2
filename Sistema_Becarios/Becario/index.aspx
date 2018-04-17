<%@ Page Title="" Language="C#" MasterPageFile="~/Becario/Becario.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="Becario_index" %>

<asp:Content ID="cont_titulo" ContentPlaceHolderID="content_titulo" Runat="Server">
    Becario - Carlos Lemus
</asp:Content>
<asp:Content ID="cont_menu" ContentPlaceHolderID="content_menu" Runat="Server">
    
    <li class="nav-item">
        <a class="nav-link" href="/Becario/Ciclos.aspx">Historial de ciclos</a>
    </li>

    <li class="nav-item">
        <a class="nav-link" href="/Becario/Presupuesto.aspx">Presupuestos</a>
    </li>
</asp:Content>

<asp:Content ID="cont_body" ContentPlaceHolderID="content_body" Runat="Server">
    <div class="container d-flex justify-content-center">
        <img class="card-img-top py-2" src="../img/jesus.svg" style="width: 7rem;" alt="Card image cap" />
    </div>

    <asp:TextBox ID="txt_ciclo" runat="server" type="hidden" />
    <asp:TextBox ID="txt_presupuesto" runat="server" type="hidden" />
    <asp:TextBox ID="txtModId" runat="server" type="hidden" ClientIDMode="Static" />

    <asp:SqlDataSource ID="sql_desembolso" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT Desembolsos.ID, Desembolsos.TipoDesembolso, CONCAT(Desembolsos.monto_desembolso, '$') AS [monto_desembolso], Desembolsos.fecha_desembolso 
FROM Ciclos 
INNER JOIN Desembolsos 
ON Ciclos.ID = Desembolsos.Ciclo
WHERE Ciclos.ID =  @ciclo 
AND Desembolsos .Presupuesto = @presupuesto" >
        <SelectParameters>
            <asp:ControlParameter ControlID="txt_ciclo" Name="ciclo" PropertyName="Text" />
            <asp:ControlParameter ControlID="txt_presupuesto" Name="presupuesto" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sql_incidencia" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT ID, detalle FROM Incidentes WHERE Ciclo  = @Ciclo" >
        <SelectParameters>
            <asp:ControlParameter ControlID="txt_ciclo" Name="Ciclo" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sql_materias" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT Notas.ID, Notas.nombre_materia, Notas.uv_materia, Notas.nota FROM Notas INNER JOIN Ciclos ON Notas.Ciclo = Ciclos.ID WHERE (Ciclos.ID = @ciclo)" DeleteCommand="DELETE FROM [Becarios] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Becarios] ([codigo_programa], [fecha_ingreso], [codigo_becario], [Usuario]) VALUES (@codigo_programa, @fecha_ingreso, @codigo_becario, @Usuario)" UpdateCommand="UPDATE [Becarios] SET [codigo_programa] = @codigo_programa, [fecha_ingreso] = @fecha_ingreso, [codigo_becario] = @codigo_becario, [Usuario] = @Usuario WHERE [ID] = @ID" >
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
            <asp:ControlParameter ControlID="txt_ciclo" Name="ciclo" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="codigo_programa" Type="String" />
            <asp:Parameter Name="fecha_ingreso" Type="String" />
            <asp:Parameter Name="codigo_becario" Type="String" />
            <asp:Parameter Name="Usuario" Type="Int32" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:ScriptManager ID="scr_manager" runat="server">

    </asp:ScriptManager>

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

    <div class="container">
        <div class="row">

             <div class="col-sm-12 col-md-4">
                <div class="card bg-dark text-white">
                    <div class="card-body">
                        <h5 class="card-title">Notas:</h5>
                        <hr class="bg-white text-white border-white my-0" />
                        <div class="card-body p-0">
                            <asp:UpdatePanel ID="up_materias" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="tbl_notas" CssClass="table table-hover text-center" border="0" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sql_materias" OnRowCreated="tbl_materias_RowCreated" OnSelectedIndexChanged="tbl_notas_SelectedIndexChanged">
                                        <Columns>
                                            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
                                            <asp:BoundField DataField="nombre_materia" HeaderText="Materia" SortExpression="nombre_materia" />
                                            <asp:BoundField DataField="uv_materia" HeaderText="Uv" SortExpression="uv_materia" />
                                            <asp:BoundField DataField="nota" HeaderText="Nota" SortExpression="nota" />
                                            <asp:CommandField ButtonType="Image" HeaderText="Opciones" SelectImageUrl="~/img/note.png" ShowSelectButton="True" />
                                        </Columns>

                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <div class="card-footer bg-danger p-0">
                            <button type="button" class="btn btn-danger w-100 m-0" data-toggle="modal" data-target="#modal_nueva_materia">
                                Añadir materiar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-12 col-md-8">
                <div class="card text-center">
                    <div class="card-header bg-primary text-white">
                        Historial de desembolso
                    </div>
                    <div class="card-body p-0">
                        <asp:UpdatePanel ID="up_desembolso" runat="server">
                            <ContentTemplate>
                                <asp:GridView BorderColor="White" CssClass="table table-hover table-bordered w-100 my-0" ID="tbl_desembolsos" runat="server" AutoGenerateColumns="False" DataSourceID="sql_desembolso" DataKeyNames="ID">
                                    <Columns>
                                        <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                        <asp:BoundField DataField="TipoDesembolso" HeaderText="Tipo" SortExpression="TipoDesembolso" />
                                        <asp:BoundField DataField="monto_desembolso" HeaderText="Cantidad" ReadOnly="True" SortExpression="monto_desembolso" />
                                        <asp:BoundField DataField="fecha_desembolso" HeaderText="Fecha" SortExpression="fecha_desembolso" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>

        </div>

        <div class="row">
            <div class="col-sm-12 mt-sm-2 mt-md-1">
                <div class="card text-center">
                    <div class="card-header bg-white text-dark">
                        Historial de incidencias
                    </div>
                    <div class="card-body p-0">
                        <asp:UpdatePanel ID="up_incedentes" runat="server">
                            <ContentTemplate>
                                <asp:GridView HeaderStyle-CssClass="bg-white text-dark" ShowHeader="false" BorderColor="White" CssClass="table table-dark table-hover table-bordered w-100 my-0" ID="tbl_incidencias" runat="server" AutoGenerateColumns="False" DataSourceID="sql_incidencia" DataKeyNames="ID">
                                    <Columns>
                                        <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                        <asp:BoundField DataField="detalle" HeaderText="detalle" SortExpression="detalle" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>

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
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarNota" ValidationGroup="modificarMateria" Display="Dynamic" runat="server" ErrorMessage="La nota es obligatoria" CssClass="blockquote-footer text-danger"/>
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

</asp:Content>

<asp:Content ID="cont_script" ContentPlaceHolderID="content_script" Runat="Server">
</asp:Content>


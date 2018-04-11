<%@ Page Title="" Language="C#" MasterPageFile="~/GestorEducativo/MasterGestorEducativo.master" AutoEventWireup="true" CodeFile="Becarios.aspx.cs" Inherits="GestorEducativo_Becarios" %>

<asp:Content ID="cont_titulo" ContentPlaceHolderID="content_titulo" Runat="Server">
    Becarios
</asp:Content>

<asp:Content ID="cont_menu" ContentPlaceHolderID="content_menu" runat="server">
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal_nuevo_becario">
        Añadir becario
    </button>
</asp:Content>

<asp:Content ID="cont_body" ContentPlaceHolderID="content_body" Runat="Server">
    <asp:TextBox ID="txtAccion" runat="server" ClientIDMode="Static" type="hidden" /> 
    <asp:SqlDataSource ID="sql_programas" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [codigo], [nombre] FROM [Programas]" />
    <asp:SqlDataSource ID="sql_universidades" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [ID], [universidad] FROM [Universidades]" />
    <asp:SqlDataSource ID="sql_niveles" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [ID], [nivel_educativo] FROM [Niveles]" />
    <asp:SqlDataSource ID="sql_carrera" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [ID], [carrera] FROM [Carreras]" />

     <!-- Sistema de filtrado -->
    <div class="w-100 bg-danger py-3 d-flex justify-content-center form-inline">
        <div class="form-group m-0 p-0">
            <asp:DropDownList AppendDataBoundItems="true" ID="ddl_programas_becas" runat="server" CssClass="form-control" style="min-width: 200px;" AutoPostBack="True" DataSourceID="sql_programas" DataTextField="nombre" DataValueField="codigo" >
                <asp:ListItem Value="0" Text="Programas de becas" />
            </asp:DropDownList>
        </div>
    </div>

    <asp:SqlDataSource ID="sql_becarios" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT Becarios.ID, Becarios.codigo_becario, CONCAT(Usuarios.Nombres, CASE WHEN (Usuarios.Nombres ! = '' AND Usuarios.Apellidos ! = '') THEN ' ' ELSE '' END, Usuarios.Apellidos), Usuarios.dui, Programas.nombre, CASE WHEN (Usuarios.Estado = 1) THEN 'Activo' ELSE 'Desactivado' END FROM Becarios INNER JOIN Usuarios ON Becarios.Usuario = Usuarios.ID INNER JOIN Programas ON Becarios.codigo_programa = Programas.codigo WHERE Becarios.codigo_programa = @Cod_programa OR @Cod_programa = '0'">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_programas_becas" DbType="String" DefaultValue="0" Name="Cod_programa" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:TextBox id="txtFechaActual" TextMode="Date" runat="server" class="d-none" ClientIDMode="Static" />
    
    <div class="d-flex justify-content-center mt-3">
        <asp:ScriptManager ID="scr_manager" runat="server" ClientIDMode="Static">
        </asp:ScriptManager>
        <script>
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(PageLoadingHandler);

            function PageLoadingHandler(sender, args) {
                var datos = args.get_dataItems();
                /*
                    
                */

                if (datos['ddl_modificar_programas'] !== null)
                    $('#ddl_modificar_programas').val(datos['ddl_modificar_programas']);

                if (datos['chkEstado'] !== null)
                    if (datos['chkEstado'] == "1")
                        $('#chkEstado').prop('checked', true);
                    else
                        $('#chkEstado').prop('checked', false);

                //$('.myCheckbox').prop('checked', false);
                //$('#chkEstado').val(datos['chkEstado']);

                if (datos['txtModificarClave'] !== null) {
                    $('#txtModificarClave').val(datos['txtModificarClave']).change();
                }

                if (datos['txtModificarFecha'] !== null) {
                    $('#txtModificarFecha').val(datos['txtModificarFecha']).change();
                }

                if (datos['txtModificarCorreoElectronico'] !== null)
                    $('#txtModificarCorreoElectronico').val(datos['txtModificarCorreoElectronico']);

                if (datos['txtModificarDescripcion'] !== null)
                    $('#txtModificarDescripcion').val(datos['txtModificarDescripcion']);

                if (datos['txModificarTelefonoUsuario'] !== null)
                    $('#txModificarTelefonoUsuario').val(datos['txModificarTelefonoUsuario']);

                if (datos['txtModificarDui'] !== null)
                    $('#txtModificarDui').val(datos['txtModificarDui']);

                if (datos['txtModificarApellidoUsuario'] !== null)
                    $('#txtModificarApellidoUsuario').val(datos['txtModificarApellidoUsuario']);

                if (datos['txtModificarNombreUsuerio'] !== null)
                    $('#txtModificarNombreUsuerio').val(datos['txtModificarNombreUsuerio']);

                if (datos['txtModId'] !== null)
                    $('#txtModId').val(datos['txtModId']);

                // ///////////////////////////////////////////////////7
                if (datos['ddl_universidad'] !== null)
                    $('#ddl_universidad').val(datos['ddl_universidad']);

                if (datos['ddl_carrera'] !== null)
                    $('#ddl_carrera').val(datos['ddl_carrera']);

                if (datos['ddl_nivel_estudio'] !== null)
                    $('#ddl_nivel_estudio').val(datos['ddl_nivel_estudio']);

                if (datos['txtFechaIngreso'] !== null)
                    $('#txtFechaIngreso').val(datos['txtFechaIngreso']);

                if (datos['txtFechaFinalizacion'] !== null)
                    $('#txtFechaFinalizacion').val(datos['txtFechaFinalizacion']);

                // ////////////////////////////////////////////////////////////
                if (datos['txtMontoAracele'] !== null)
                    $('#txtMontoAracele').val(datos['txtMontoAracele']);

                if (datos['txtMontoGraduacion'] !== null)
                    $('#txtMontoGraduacion').val(datos['txtMontoGraduacion']);

                if (datos['txtMontoLibro'] !== null)
                    $('#txtMontoLibro').val(datos['txtMontoLibro']);

                if (datos['txtMontoManutencion'] !== null)
                    $('#txtMontoManutencion').val(datos['txtMontoManutencion']);

                if (datos['txtMontoMatricula'] !== null)
                    $('#txtMontoMatricula').val(datos['txtMontoMatricula']);

                if (datos['txtMontoSeguro'] !== null)
                    $('#txtMontoSeguro').val(datos['txtMontoSeguro']);
            }
        </script>
        <asp:UpdatePanel ID="up_content" runat="server">
            <ContentTemplate>
                <asp:GridView ID="tbl_becarios" PageSize="6" CssClass="table table-dark table-hover text-center" runat="server" AutoGenerateColumns="False" DataSourceID="sql_becarios" AllowPaging="True" OnRowDataBound="tbl_becarios_RowDataBound" OnSelectedIndexChanged="tbl_becarios_SelectedIndexChanged" DataKeyNames="ID" OnRowCreated="tbl_becarios_RowCreated">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" InsertVisible="False" Visible="False" />
                        <asp:BoundField DataField="codigo_becario" HeaderText="Codigo" ReadOnly="True" SortExpression="codigo_becario" />
                        <asp:BoundField DataField="Column1" HeaderText="Nombre" SortExpression="Column1" ReadOnly="True" />
                        <asp:BoundField DataField="dui" HeaderText="Dui" SortExpression="dui" />
                        <asp:BoundField DataField="nombre" HeaderText="Programa" SortExpression="nombre" />
                        <asp:BoundField DataField="Column2" HeaderText="Estado" ReadOnly="True" SortExpression="Column2" />
                        <asp:CommandField ButtonType="Image" HeaderText="Opciones" SelectImageUrl="~/img/edit.png" ShowSelectButton="True" />
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/img/note.png" ShowSelectButton="True" />
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/img/credit-card.png" ShowSelectButton="True" />
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/img/office-material.png" ShowSelectButton="True" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddl_programas_becas" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    
    <!-- ////////////////////////////////////////////////////////////////////////////////////// -->

    <div class="modal fade" id="modal_nuevo_becario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="card modal-content">
                <div class="modal-header card-header">
                    <h5 class="modal-title">Nuevo becario</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body card-body">
                    <div class="form-group">
                        <label for="txtNuevoNombreUsuerio">Nombres:</label>
                        <asp:TextBox ID="txtNuevoNombreUsuerio" ValidationGroup="nuevoUsuario" runat="server" CssClass="form-control" placeholder="Nombre de usuario" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtNuevoNombreUsuerio" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="El nombre del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                    </div>

                    <div class="form-group">
                        <label for="txtNuevoApellidoUsuario">Apellidos:</label>
                        <asp:TextBox ID="txtNuevoApellidoUsuario" ValidationGroup="nuevoUsuario" runat="server" CssClass="form-control" placeholder="Apellido de usuario" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtNuevoApellidoUsuario" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="El apellido del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                    </div>

                    <div class="form-group">
                        <label for="txtNuevoCorreoElectronico">Correo electronico:</label>
                        <asp:TextBox ID="txtNuevoCorreoElectronico" ValidationGroup="nuevoUsuario" TextMode="Email" runat="server" CssClass="form-control" placeholder="Correo electronico" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtNuevoCorreoElectronico" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="El correo electronico es obligatorio" CssClass="blockquote-footer text-danger"/>
                        <asp:RegularExpressionValidator ControlToValidate="txtNuevoCorreoElectronico" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="El correo electronico no es valido" CssClass="blockquote-footer text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtNuevoTelefonoUsuario">Numero telefonico:</label>
                        <asp:TextBox ID="txtNuevoTelefonoUsuario" ValidationGroup="nuevoUsuario" TextMode="Phone" runat="server" CssClass="form-control" placeholder="Numero telefonico" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtNuevoTelefonoUsuario" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="El numero de telefono es obligatorio" CssClass="blockquote-footer text-danger"/>
                        <asp:RegularExpressionValidator ControlToValidate="txtNuevoTelefonoUsuario" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ValidationExpression="[2,7][0-9]{3}-[0-9]{4}" ErrorMessage="El numero telefonico no es valido" CssClass="blockquote-footer text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtNuevoDui">DUI:</label>
                        <asp:TextBox ID="txtNuevoDui" ValidationGroup="nuevoUsuario" TextMode="Phone" runat="server" CssClass="form-control" placeholder="DUI" ClientIDMode="Static" />
                        <asp:RegularExpressionValidator ControlToValidate="txtNuevoDui" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ValidationExpression="[0-9]{8}-[0-9]" ErrorMessage="El dui es invalido" CssClass="blockquote-footer text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtNuevaFecha">Fecha de nacimiento:</label>
                        <asp:TextBox ID="txtNuevaFecha" ValidationGroup="nuevoUsuario" TextMode="Date" runat="server" CssClass="form-control" placeholder="Fecha" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtNuevaFecha" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="La fecha es obligatoria" CssClass="blockquote-footer text-danger"/>
                        <asp:CompareValidator ControlToValidate="txtNuevaFecha" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="La fecha debe de ser inferior" ControlToCompare="txtFechaActual" Type="Date" Operator="LessThanEqual" CssClass="blockquote-footer text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtDireccion">Direccion:</label>
                        <asp:TextBox ID="txtDireccion" ValidationGroup="nuevoUsuario" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Direccion" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtDireccion" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="La direccion es obligatoria" CssClass="blockquote-footer text-danger"/>
                    </div>

                    <div class="form-group">
                        <label for="ddl_programas">Programa de becas:</label>
                        <asp:dropdownlist ID="ddl_programas" runat="server" CssClass="form-control" DataSourceID="sql_programas" DataTextField="nombre" DataValueField="codigo"></asp:dropdownlist>
                    </div>

                    <div class="form-group">
                        <label for="txtNuevaClaveAleatoria">Clave del usuario:</label>

                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                                <asp:Button ID="btnClaveAleatoria" runat="server" ClientIDMode="Static" CssClass="input-group-text btn btn-danger" Text="Aleatorio" OnClientClick="return false;" />
                            </div>

                            <asp:TextBox CssClass="form-control" ID="txtNuevaClaveAleatoria" runat="server" ValidationGroup="nuevoUsuario" placeholder="Codigo" ClientIDMode="Static"/>
                        </div>

                        <asp:RequiredFieldValidator ControlToValidate="txtNuevaClaveAleatoria" ValidationGroup="nuevoUsuario" Display="Dynamic" runat="server" ErrorMessage="La clave es obligatorio" CssClass="blockquote-footer text-danger"/>
                    </div>
                </div>
                <div class="modal-footer card-footer text-muted">
                    <asp:Button ID="btn_guardar" ValidationGroup="nuevoUsuario" runat="server" CssClass="btn btn-secondary" Text="Guardar becario" ClientIDMode="Static" OnClick="btn_guardar_Click" />
                    <button type="reset" class="btn btn-primary">Limpiar datos</button>
                </div>
            </div>
        </div>
    </div>

    <!-- ////////////////////////////////////////////////////////////////////////////////////// -->
    <asp:TextBox ID="txtModId" runat="server" type="hidden" ClientIDMode="Static" />
    <!-- ////////////////////////////////////////////////////////////////////////////////////// -->
        <div class="modal fade" id="modal_modificar_becario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="card modal-content">
                    <div class="modal-header card-header">
                        <h5 class="modal-title">Modificar becario</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body card-body">
                        
                        <div class="form-group">
                            <label for="txtModificarNombreUsuerio">Nombres:</label>
                            <asp:TextBox ID="txtModificarNombreUsuerio" ValidationGroup="modificarUsuario" runat="server" CssClass="form-control" placeholder="Nombre de usuario" ClientIDMode="Static" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarNombreUsuerio" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El nombre del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtModificarApellidoUsuario">Apellidos:</label>
                            <asp:TextBox ID="txtModificarApellidoUsuario" ValidationGroup="modificarUsuario" runat="server" CssClass="form-control" placeholder="Apellido de usuario" ClientIDMode="Static" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarApellidoUsuario" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El apellido del usuario es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="txtModificarCorreoElectronico">Correo electronico:</label>
                            <asp:TextBox ID="txtModificarCorreoElectronico" ValidationGroup="modificarUsuario" TextMode="Email" runat="server" CssClass="form-control" placeholder="Correo electronico" ClientIDMode="Static" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarCorreoElectronico" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El correo electronico es obligatorio" CssClass="blockquote-footer text-danger"/>
                            <asp:RegularExpressionValidator ControlToValidate="txtModificarCorreoElectronico" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="El correo electronico no es valido" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txModificarTelefonoUsuario">Numero telefonico:</label>
                            <asp:TextBox ID="txModificarTelefonoUsuario" ValidationGroup="modificarUsuario" TextMode="Phone" runat="server" CssClass="form-control" placeholder="Numero telefonico" ClientIDMode="Static" />
                            <asp:RequiredFieldValidator ControlToValidate="txModificarTelefonoUsuario" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="El numero de telefono es obligatorio" CssClass="blockquote-footer text-danger"/>
                            <asp:RegularExpressionValidator ControlToValidate="txModificarTelefonoUsuario" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ValidationExpression="[2,7][0-9]{3}-[0-9]{4}" ErrorMessage="El numero telefonico no es valido" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtModificarDui">DUI:</label>
                            <asp:TextBox ID="txtModificarDui" ValidationGroup="modificarUsuario" TextMode="Phone" runat="server" CssClass="form-control" placeholder="DUI" ClientIDMode="Static" />
                            <asp:RegularExpressionValidator ControlToValidate="txtModificarDui" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ValidationExpression="[0-9]{8}-[0-9]" ErrorMessage="El dui es invalido" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtModificarFecha">Fecha de nacimiento:</label>
                            <asp:TextBox ID="txtModificarFecha" ValidationGroup="modificarUsuario" TextMode="Date" runat="server" CssClass="form-control" placeholder="Fecha" ClientIDMode="Static" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarFecha" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="La fecha es obligatoria" CssClass="blockquote-footer text-danger"/>
                            <asp:CompareValidator ControlToValidate="txtNuevaFecha" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="La fecha debe de ser inferior" ControlToCompare="txtFechaActual" Type="Date" Operator="LessThanEqual" CssClass="blockquote-footer text-danger" />
                        </div>

                        <div class="form-group">
                            <label for="txtModificarDescripcion">Direccion:</label>
                            <asp:TextBox ID="txtModificarDescripcion" ValidationGroup="modificarUsuario" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Direccion" ClientIDMode="Static" />
                            <asp:RequiredFieldValidator ControlToValidate="txtModificarDescripcion" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="La direccion es obligatoria" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="ddl_modificar_programas">Programa de becas:</label>
                            <asp:dropdownlist ID="ddl_modificar_programas" runat="server" CssClass="form-control" DataSourceID="sql_programas" DataTextField="nombre" DataValueField="codigo" ClientIDMode="Static"></asp:dropdownlist>
                        </div>

                        <div class="form-group">
                            <label for="txtModificarClave">Clave del usuario:</label>

                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <button id="btnModClaveAleatoria" type="button" class="input-group-text btn btn-danger"><i id="contenidoIcon" class="material-icons">remove_red_eye</i></button>
                                </div>

                                <asp:TextBox CssClass="form-control" ID="txtModificarClave" TextMode="Password" runat="server" ValidationGroup="nuevoUsuario" placeholder="Clave" ReadOnly="true" ClientIDMode="Static"/>
                            </div>

                            <asp:RequiredFieldValidator ControlToValidate="txtModificarClave" ValidationGroup="modificarUsuario" Display="Dynamic" runat="server" ErrorMessage="La clave es obligatorio" CssClass="blockquote-footer text-danger"/>
                        </div>

                        <div class="form-check">
                            <asp:CheckBox runat="server" CssClass="form-check-input" ID="chkEstado" ClientIDMode="Static" />
                            <label class="form-check-label" for="chkEstado">Activo.</label>
                        </div>
                    </div>
                    <div class="modal-footer card-footer text-muted">
                        <asp:Button ID="btn_modificar" ValidationGroup="modificarUsuario" runat="server" CssClass="btn btn-secondary" Text="Modificar becario" ClientIDMode="Static" OnClick="btn_modificar_Click" />
                        <button type="reset" class="btn btn-primary">Limpiar datos</button>
                    </div>
                </div>
            </div>
        </div>
    <!-- ////////////////////////////////////////////////////////////////////////////////////// -->

    <!-- ////////////////////////////////////////////////////////////////////////////////////// -->
    <div class="modal fade" id="modal_datos_academicos" tabindex="-1" role="dialog" aria-labelledby="modal_datos_academicos" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title" id="exampleModalLabel">Datos Academicos</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                 </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label for="ddl_universidad">Universidad de estudio:</label>
                        <asp:dropdownlist ID="ddl_universidad" runat="server" CssClass="form-control" ClientIDMode="Static" DataSourceID="sql_universidades" DataTextField="universidad" DataValueField="ID"></asp:dropdownlist>
                    </div>

                    <div class="form-group">
                        <label for="ddl_nivel_estudio">Nivel de estudio:</label>
                        <asp:dropdownlist ID="ddl_nivel_estudio" runat="server" CssClass="form-control" ClientIDMode="Static" DataSourceID="sql_niveles" DataTextField="nivel_educativo" DataValueField="ID"></asp:dropdownlist>
                    </div>

                    <div class="form-group">
                        <label for="ddl_carrera">Carrera de estudio:</label>
                        <asp:dropdownlist ID="ddl_carrera" runat="server" CssClass="form-control" ClientIDMode="Static" DataSourceID="sql_carrera" DataTextField="carrera" DataValueField="ID"></asp:dropdownlist>
                    </div>

                    <div class="form-group">
                        <label for="txtFechaIngreso">Fecha de ingreso:</label>
                        <asp:TextBox ID="txtFechaIngreso" ValidationGroup="datosAcademico" TextMode="Date" runat="server" CssClass="form-control" placeholder="Fecha" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtFechaIngreso" ValidationGroup="datosAcademico" Display="Dynamic" runat="server" ErrorMessage="La fecha es obligatoria" CssClass="blockquote-footer text-danger"/>
                        <asp:CompareValidator ControlToValidate="txtFechaIngreso" ValidationGroup="datosAcademico" Display="Dynamic" runat="server" ErrorMessage="La fecha debe de ser inferior" ControlToCompare="txtFechaActual" Type="Date" Operator="LessThanEqual" CssClass="blockquote-footer text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtFechaFinalizacion">Fecha de salida:</label>
                        <asp:TextBox ID="txtFechaFinalizacion" ValidationGroup="datosAcademico" TextMode="Date" runat="server" CssClass="form-control" placeholder="Fecha" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtFechaFinalizacion" ValidationGroup="datosAcademico" Display="Dynamic" runat="server" ErrorMessage="La fecha es obligatoria" CssClass="blockquote-footer text-danger"/>
                        <asp:CompareValidator ControlToValidate="txtFechaFinalizacion" ValidationGroup="datosAcademico" Display="Dynamic" runat="server" ErrorMessage="La fecha debe de ser inferior" ControlToCompare="txtFechaActual" Type="Date" Operator="LessThanEqual" CssClass="blockquote-footer text-danger" />
                        <asp:CompareValidator ControlToValidate="txtFechaFinalizacion" ValidationGroup="datosAcademico" Display="Dynamic" runat="server" ErrorMessage="La fecha debe de ser mayor que el dato de inicio" ControlToCompare="txtFechaIngreso" Type="Date" Operator="GreaterThan" CssClass="blockquote-footer text-danger" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btn_ActualizarDatosAcademido" ValidationGroup="datosAcademico" runat="server" CssClass="btn btn-primary" Text="Actualizar datos" ClientIDMode="Static" OnClick="btn_ActualizarDatosAcademido_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- ////////////////////////////////////////////////////////////////////////////////////// -->

    <!-- ///////////////////////////////////////////////////////////////////////////////////// -->

    <div class="modal fade" id="manejo_presupuesto" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning text-white">
                    <h5 class="modal-title">Presupuesto</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="txtMontoLibro">Monto del libro:</label>
                        <asp:TextBox ID="txtMontoLibro" Text="0" ValidationGroup="presupuesto" type="number" runat="server" CssClass="form-control" placeholder="Monto del libro" min="0" step="0.01" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtMontoLibro" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto del libro es obligatoria" CssClass="blockquote-footer text-danger"/>
                        <asp:CompareValidator ControlToValidate="txtMontoLibro" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto del libro debe de ser mayor que 0" ValueToCompare="0" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtMontoManutencion">Monto de manutencion:</label>
                        <asp:TextBox ID="txtMontoManutencion" Text="0" ValidationGroup="presupuesto" type="number" runat="server" CssClass="form-control" placeholder="Monto de la manuntencion" min="0" step="0.01" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtMontoManutencion" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto de la manuntencion es obligatoria" CssClass="blockquote-footer text-danger"/>
                        <asp:CompareValidator ControlToValidate="txtMontoManutencion" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto de la manuntencion debe de ser mayor que 0" ValueToCompare="0" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtMontoMatricula">Monto de la matricula:</label>
                        <asp:TextBox ID="txtMontoMatricula" Text="0" ValidationGroup="presupuesto" type="number" runat="server" CssClass="form-control" placeholder="Monto de la matricula" min="0" step="0.01" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtMontoMatricula" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto de la matricula es obligatoria" CssClass="blockquote-footer text-danger"/>
                        <asp:CompareValidator ControlToValidate="txtMontoMatricula" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto de la matricula debe de ser mayor que 0" ValueToCompare="0" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtMontoAracele">Monto de los araceles:</label>
                        <asp:TextBox ID="txtMontoAracele" Text="0" ValidationGroup="presupuesto" type="number" runat="server" CssClass="form-control" placeholder="Monto de los araceles" min="0" step="0.01" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtMontoAracele" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto de los araceles es obligatoria" CssClass="blockquote-footer text-danger"/>
                        <asp:CompareValidator ControlToValidate="txtMontoAracele" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto de los araceles debe de ser mayor que 0" ValueToCompare="0" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtMontoSeguro">Monto del seguro:</label>
                        <asp:TextBox ID="txtMontoSeguro" Text="0" ValidationGroup="presupuesto" type="number" runat="server" CssClass="form-control" placeholder="Monto del seguro" min="0" step="0.01" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtMontoSeguro" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto del seguro es obligatoria" CssClass="blockquote-footer text-danger"/>
                        <asp:CompareValidator ControlToValidate="txtMontoSeguro" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto del seguro debe de ser mayor que 0" ValueToCompare="0" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtMontoGraduacion">Monto de graduacion:</label>
                        <asp:TextBox ID="txtMontoGraduacion" Text="0" ValidationGroup="presupuesto" type="number" runat="server" CssClass="form-control" placeholder="Monto de graduacion" min="0" step="0.01" ClientIDMode="Static" />
                        <asp:RequiredFieldValidator ControlToValidate="txtMontoGraduacion" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto de graduacion es obligatoria" CssClass="blockquote-footer text-danger"/>
                        <asp:CompareValidator ControlToValidate="txtMontoGraduacion" ValidationGroup="presupuesto" Display="Dynamic" runat="server" ErrorMessage="El monto de graduacion debe de ser mayor que 0" ValueToCompare="0" Operator="GreaterThanEqual" CssClass="blockquote-footer text-danger" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btn_ActualizarPresupuesto" ValidationGroup="presupuesto" runat="server" CssClass="btn btn-primary" Text="Actualizar datos" ClientIDMode="Static" OnClick="btn_ActualizarPresupuesto_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- ///////////////////////////////////////////////////////////////////////////////////// -->
</asp:Content>

<asp:Content ID="cont_script" ContentPlaceHolderID="cont_script" runat="server">
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

                $("#modal_nuevo_becario").on('shown.bs.modal', function (e) {
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

</asp:Content>
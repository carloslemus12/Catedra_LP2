<%@ Page Title="" Language="C#" MasterPageFile="~/Contador/Contador.master" AutoEventWireup="true" CodeFile="Becario_ciclo.aspx.cs" Inherits="Contador_Becario_ciclo" %>

<asp:Content ID="cont_titulo" ContentPlaceHolderID="content_titulo" Runat="Server">
Ciclo del becario
</asp:Content>
<asp:Content ID="cont_menu" ContentPlaceHolderID="content_menu" Runat="Server">
    <li class="nav-item">
        <a class="nav-link" href="/Contador/becario/<%= becario.ID %>"><i class="material-icons">arrow_back</i>Ciclos</a>
    </li>

    <asp:TextBox ID="txt_datos" runat="server" type="hidden" />

    <asp:SqlDataSource ID="sql_ciclos" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT CONCAT( 'Ciclo #', ROW_NUMBER() OVER(ORDER BY Ciclos.ID ASC)) as [Ciclo], Ciclos.ID FROM Ciclos INNER JOIN DatosAcademicos ON Ciclos.Datos_becario = DatosAcademicos.ID WHERE DatosAcademicos.ID = @datos" >
        <SelectParameters>
            <asp:ControlParameter ControlID="txt_datos" Name="datos" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <li class="nav-item">
        <asp:DropDownList AppendDataBoundItems="true" AutoPostBack="true" style="min-width: 200px;" CssClass="form-control" ID="ddl_ciclos" runat="server" DataSourceID="sql_ciclos" DataTextField="Ciclo" DataValueField="ID" OnSelectedIndexChanged="ddl_ciclos_SelectedIndexChanged">
            <asp:ListItem Text="Ciclos" Value="-1" />
        </asp:DropDownList>
    </li>
</asp:Content>
<asp:Content ID="cont_body" ContentPlaceHolderID="content_body" Runat="Server">
    
    <asp:TextBox ID="txt_presupuesto" runat="server" type="hidden" />
    <div class="container">
        <div class="row mt-2">
            <div class="col">
                <div class="card">
                    <div class="card-header"> Informacion del becario </div>
                    <div class="card-body">
                        <div class="row"> 
                            <div class="col-12 col-md">
                                Codigo: <%= becario.codigo_becario %>
                            </div>
                            <div class="col-12 col-md">
                                Nombre completo: <span></span>
                            </div>
                            <div class="col-12 col-md">
                                DUI: <%= becario.Usuarios.dui %>
                            </div>
                        </div>

                        <div class="row"> 
                            <div class="col-12 col-md">
                                Univarsidad: <%= becario.DatosAcademicos.Last().Universidades.universidad %>
                            </div>
                            <div class="col-12 col-md">
                                Carrera: <%= becario.DatosAcademicos.Last().Carreras.carrera %>
                            </div>
                            <div class="col-12 col-md">
                                Programa de beca: <%=  becario.Programas.nombre %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <asp:SqlDataSource ID="sql_materias" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT Notas.ID, Notas.nombre_materia, Notas.uv_materia, Notas.nota, ( CASE WHEN Notas.tercio_superior = 1 THEN 'Tercio superior' ELSE 'Desaprobado' END) FROM Notas INNER JOIN Ciclos ON Notas.Ciclo = Ciclos.ID WHERE (Ciclos.ID = @datos)" DeleteCommand="DELETE FROM [Becarios] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Becarios] ([codigo_programa], [fecha_ingreso], [codigo_becario], [Usuario]) VALUES (@codigo_programa, @fecha_ingreso, @codigo_becario, @Usuario)" UpdateCommand="UPDATE [Becarios] SET [codigo_programa] = @codigo_programa, [fecha_ingreso] = @fecha_ingreso, [codigo_becario] = @codigo_becario, [Usuario] = @Usuario WHERE [ID] = @ID" >
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
                <asp:RouteParameter Name="datos" RouteKey="ciclo" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="codigo_programa" Type="String" />
                <asp:Parameter Name="fecha_ingreso" Type="String" />
                <asp:Parameter Name="codigo_becario" Type="String" />
                <asp:Parameter Name="Usuario" Type="Int32" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="sql_desembolso" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT Desembolsos.ID, Desembolsos.TipoDesembolso, CONCAT(Desembolsos.monto_desembolso, '$') AS [monto_desembolso], Desembolsos.fecha_desembolso 
        FROM Ciclos 
        INNER JOIN Desembolsos 
        ON Ciclos.ID = Desembolsos.Ciclo
        WHERE Ciclos.ID =  @ciclo 
        AND Desembolsos .Presupuesto = @presupuesto" >
            <SelectParameters>
                <asp:RouteParameter Name="ciclo" RouteKey="ciclo" />
                <asp:ControlParameter ControlID="txt_presupuesto" Name="presupuesto" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <div class="row mt-2">
            <div class="col-md-4">
                <div class="card bg-dark text-white">
                    <div class="card-body">
                        <h5 class="card-title">Notas:</h5>
                        <hr class="bg-white text-white border-white my-0" />
                        <div class="card-body p-0">
                            <asp:GridView ID="tbl_notas" CssClass="table table-hover text-center" border="0" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sql_materias">
                                <Columns>
                                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
                                    <asp:BoundField DataField="nombre_materia" HeaderText="Materia" SortExpression="nombre_materia" />
                                    <asp:BoundField DataField="uv_materia" HeaderText="Uv" SortExpression="uv_materia" />
                                    <asp:BoundField DataField="nota" HeaderText="nota" SortExpression="nota" />
                                    <asp:BoundField DataField="Column1" HeaderText="Estado" ReadOnly="True" SortExpression="Column1" />
                                </Columns>

                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

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

            <div class="col-md-8 pl-md-5">
                <div class="row">
                    <div class="card bg-success text-white col-md-8 offset-md-4">
                        <div class="card-body">
                            <h5 class="card-title">Informacion del ciclo:</h5>
                            <hr class="bg-white text-white border-white my-0" />
                            <p class="card-text my-0"><span class="font-weight-bold">Estado:</span>  <%= BecariosModelo.esElUltimoCiclo(becario.DatosAcademicos.Last(),ciclo.ID)? "En curso" : "Cursado" %> </p>
                            <p class="card-text my-0"><span class="font-weight-bold">Fecha de inicio del ciclo:</span></p>
                            <p class="card-text my-0"><span class="font-weight-bold">Fecha de fin del ciclo:</span></p>
                        </div>
                    </div>
                </div>
                <asp:ScriptManager ID="scr_manager" runat="server"></asp:ScriptManager>
                <div class="row mt-md-2 mb-5">
                    <div class="card bg-primary text-white col">
                        <div class="card-body">
                            <h5 class="card-title">Reguistro de desembolso:</h5>
                            <hr class="bg-white text-white border-white my-0" />
                            <div class="card-body p-0">
                                <asp:UpdatePanel ID="up_desembolso" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView BorderColor="White" CssClass="table table-hover w-100 my-0 text-center" border="0" ID="tbl_desembolsos" runat="server" AutoGenerateColumns="False" DataSourceID="sql_desembolso" DataKeyNames="ID" OnRowCreated="tbl_desembolsos_RowCreated" OnSelectedIndexChanged="tbl_desembolsos_SelectedIndexChanged">
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
                            <div class="card-footer pb-0">
                                <button type="button" class="btn btn-warning text-white w-100 mb-0" data-toggle="modal" data-target="#modal_desembolsar">Añadir incidencia</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="modal_indice" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-dark text-white">
                    <h5 class="modal-title" id="exampleModalLabel">Buscar por ciclo</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <input type="number" class="form-control" id="txt_indice" value="1" min="1" runat="server" />
                        <asp:RequiredFieldValidator ControlToValidate="txt_indice" ErrorMessage="Debe de especificar un indice" ValidationGroup="gru_indice" runat="server" Display="Dynamic" />
                        <asp:RegularExpressionValidator ControlToValidate="txt_indice" ErrorMessage="El indice debe de ser numerico" ValidationGroup="gru_indice" runat="server" Display="Dynamic" ValidationExpression="[0-9]+" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Buscar" ValidationGroup="gru_indice" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>


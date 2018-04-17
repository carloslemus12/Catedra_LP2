<%@ Page Title="" Language="C#" MasterPageFile="~/Becario/Becario.master" AutoEventWireup="true" CodeFile="Ciclos.aspx.cs" Inherits="Becario_Ciclo" %>

<asp:Content ID="cont_titulo" ContentPlaceHolderID="content_titulo" Runat="Server">
    Becario - Carlos Lemus
</asp:Content>

<asp:Content ID="cont_menu" ContentPlaceHolderID="content_menu" Runat="Server">
    <li class="nav-item">
        <a class="nav-link" href="/Becario/index.aspx">Volver</a>
    </li>

     <li class="nav-item">
        <a class="nav-link" href="/Becario/Presupuesto.aspx">Presupuesto</a>
    </li>
</asp:Content>

<asp:Content ID="cont_body" ContentPlaceHolderID="content_body" Runat="Server">
    <asp:TextBox ID="txt_datos" runat="server" type="hidden" />
    <asp:TextBox ID="txt_presupuesto" runat="server" type="hidden" />

    <asp:SqlDataSource ID="sql_ciclos" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT CONCAT( 'Ciclo #', ROW_NUMBER() OVER(ORDER BY Ciclos.ID ASC)) as [Ciclo], Ciclos.ID FROM Ciclos INNER JOIN DatosAcademicos ON Ciclos.Datos_becario = DatosAcademicos.ID WHERE DatosAcademicos.ID = @datos AND Ciclos.ID != (SELECT top 1 Ciclos.ID FROM Ciclos INNER JOIN DatosAcademicos ON Ciclos.Datos_becario = DatosAcademicos.ID WHERE DatosAcademicos.ID = @datos ORDER BY Ciclos.ID DESC)" >
        <SelectParameters>
            <asp:ControlParameter ControlID="txt_datos" Name="datos" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="w-100 d-flex justify-content-center align-content-center px-5">
        <asp:DropDownList AppendDataBoundItems="true" AutoPostBack="true" CssClass="form-control" ID="ddl_ciclos" runat="server" DataSourceID="sql_ciclos" DataTextField="Ciclo" DataValueField="ID">
            <asp:ListItem Text="Ciclos cursados" Value="-1" />
        </asp:DropDownList>
    </div>

    <asp:SqlDataSource ID="sql_desembolso" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT Desembolsos.ID, Desembolsos.TipoDesembolso, CONCAT(Desembolsos.monto_desembolso, '$') AS [monto_desembolso], Desembolsos.fecha_desembolso 
FROM Ciclos 
INNER JOIN Desembolsos 
ON Ciclos.ID = Desembolsos.Ciclo
WHERE Ciclos.ID =  @ciclo 
AND Desembolsos .Presupuesto = @presupuesto" >
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_ciclos" Name="ciclo" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txt_presupuesto" Name="presupuesto" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sql_incidencia" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT ID, detalle FROM Incidentes WHERE Ciclo  = @Ciclo" >
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_ciclos" Name="Ciclo" PropertyName="SelectedValue" />
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
            <asp:ControlParameter ControlID="ddl_ciclos" Name="ciclo" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="codigo_programa" Type="String" />
            <asp:Parameter Name="fecha_ingreso" Type="String" />
            <asp:Parameter Name="codigo_becario" Type="String" />
            <asp:Parameter Name="Usuario" Type="Int32" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:ScriptManager ID="scr_manager" runat="server"></asp:ScriptManager>

    <asp:UpdatePanel ID="up_datos" runat="server">
        <ContentTemplate>
            <% if(!ddl_ciclos.SelectedValue.Equals("-1")) { %>
                <div class="container my-5">
                    <div class="row">

                         <div class="col-sm-12 col-md-4">
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
                                                <asp:BoundField DataField="nota" HeaderText="Nota" SortExpression="nota" />
                                            </Columns>
                                        </asp:GridView>
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
                                    <asp:GridView BorderColor="White" CssClass="table table-hover table-bordered w-100 my-0" ID="tbl_desembolsos" runat="server" AutoGenerateColumns="False" DataSourceID="sql_desembolso" DataKeyNames="ID">
                                        <Columns>
                                            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                            <asp:BoundField DataField="TipoDesembolso" HeaderText="Tipo" SortExpression="TipoDesembolso" />
                                            <asp:BoundField DataField="monto_desembolso" HeaderText="Cantidad" ReadOnly="True" SortExpression="monto_desembolso" />
                                            <asp:BoundField DataField="fecha_desembolso" HeaderText="Fecha" SortExpression="fecha_desembolso" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="row mt-sm-2 mt-md-1">
                        <div class="col-sm-12">
                            <div class="card text-center">
                                <div class="card-header bg-white text-dark">
                                    Historial de incidencias
                                </div>
                                <div class="card-body p-0">
                                    <asp:GridView HeaderStyle-CssClass="bg-white text-dark" ShowHeader="false" BorderColor="White" CssClass="table table-dark table-hover table-bordered w-100 my-0" ID="tbl_incidencias" runat="server" AutoGenerateColumns="False" DataSourceID="sql_incidencia" DataKeyNames="ID">
                                        <Columns>
                                            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                            <asp:BoundField DataField="detalle" HeaderText="detalle" SortExpression="detalle" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <% }
            else { %>
                <% if (ddl_ciclos.Items.Count > 0) { %>
                    <div class="alert alert-warning mx-5 mt-5"><strong>Informacion: </strong> Debe de seleccionar algun ciclo</div>
                <% } else { %>
                    <div class="alert alert mx-5 mt-5"><strong>Error: </strong> No posee ningun ciclo</div>
                <%} %>
            <% } %>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddl_ciclos" EventName="SelectedIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>

</asp:Content>

<asp:Content ID="cont_script" ContentPlaceHolderID="content_script" Runat="Server">
</asp:Content>


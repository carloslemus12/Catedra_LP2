<%@ Page Title="" Language="C#" MasterPageFile="~/Contador/Contador.master" AutoEventWireup="true" CodeFile="Becarios.aspx.cs" Inherits="Contador_Becarios" %>

<asp:Content ID="cont_body" ContentPlaceHolderID="content_body" Runat="Server">
    
    <!--SQL-->
    <asp:SqlDataSource ID="sql_programas_becas" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [codigo], [nombre] FROM [Programas]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_universidades" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [ID], [universidad] FROM [Universidades]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_carreras" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [ID], [carrera] FROM [Carreras]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sql_becarios" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" DeleteCommand="DELETE FROM [Becarios] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Becarios] ([ID], [codigo_programa], [codigo_becario], [DatosAcademico], [Usuario]) VALUES (@ID, @codigo_programa, @codigo_becario, @DatosAcademico, @Usuario)" SelectCommand="SELECT  concat(Usuarios.Nombres, Usuarios.Apellidos) as [Nombre completo], Universidades.universidad, Carreras.carrera, Niveles.nivel_educativo, Programas.nombre,Estados.nombre_estado FROM Becarios INNER JOIN DatosAcademicos ON Becarios.DatosAcademico = DatosAcademicos.ID INNER JOIN Estados ON DatosAcademicos.ID = Estados.ID INNER JOIN Programas ON Becarios.codigo_programa = Programas.codigo INNER JOIN Universidades ON DatosAcademicos.Universidad = Universidades.ID INNER JOIN Usuarios ON Becarios.Usuario = Usuarios.ID INNER JOIN Carreras ON DatosAcademicos.Carrera = Carreras.ID INNER JOIN Niveles ON DatosAcademicos.Nivel = Niveles.ID WHERE (Carreras.ID = @carrera_id or  @carrera_id = 0 ) and (Programas.codigo = @programa_beca or @programa_beca = '-1') and (Universidades.ID = @universidad_id or @universidad_id = -1) and (Estados.ID = @estado_id or @estado_id = -1)" UpdateCommand="UPDATE [Becarios] SET [codigo_programa] = @codigo_programa, [codigo_becario] = @codigo_becario, [DatosAcademico] = @DatosAcademico, [Usuario] = @Usuario WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ID" Type="String" />
            <asp:Parameter Name="codigo_programa" Type="String" />
            <asp:Parameter Name="codigo_becario" Type="String" />
            <asp:Parameter Name="DatosAcademico" Type="Int32" />
            <asp:Parameter Name="Usuario" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_carreras" DbType="Int32" Name="carrera_id" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddl_programas_becas" DbType="String" Name="programa_beca" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddl_universidades" DbType="Int32" Name="universidad_id" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddl_estados" DbType="Int32" Name="estado_id" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="codigo_programa" Type="String" />
            <asp:Parameter Name="codigo_becario" Type="String" />
            <asp:Parameter Name="DatosAcademico" Type="Int32" />
            <asp:Parameter Name="Usuario" Type="Int32" />
            <asp:Parameter Name="ID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <!-- Sistema de filtrado -->
    <div class="w-100 bg-warning py-3 d-flex justify-content-center form-inline">
        <div class="form-group m-0 p-0">
            <asp:DropDownList AppendDataBoundItems="true" ID="ddl_programas_becas" runat="server" CssClass="form-control" style="min-width: 200px;" AutoPostBack="True" DataSourceID="sql_programas_becas" DataTextField="nombre" DataValueField="codigo" >
                <asp:ListItem Value="0" Text="Programas de becas" />
            </asp:DropDownList>
        </div>
        
        <div class="form-group m-0 p-0 ml-sm-2 mt-2 m-sm-0">
            <asp:DropDownList AppendDataBoundItems="true" ID="ddl_universidades" runat="server" CssClass="form-control" style="min-width: 200px;" DataSourceID="sql_universidades" DataTextField="universidad" DataValueField="ID" >
                <asp:ListItem Value="0" Text="Universidades" />
            </asp:DropDownList>
        </div>

        <div class="form-group m-0 p-0 ml-sm-2 mt-2 m-sm-0">
            <asp:DropDownList AppendDataBoundItems="true" ID="ddl_carreras" runat="server" CssClass="form-control" style="min-width: 200px;" AutoPostBack="True" DataSourceID="sql_carreras" DataTextField="carrera" DataValueField="ID" >
                <asp:ListItem Value="0" Text="Carreras" />
            </asp:DropDownList>
        </div>

        <div class="form-group m-0 p-0 ml-sm-2 mt-2 m-sm-0">
            <asp:DropDownList AppendDataBoundItems="true" ID="ddl_estados" runat="server" CssClass="form-control" style="min-width: 200px;" AutoPostBack="True" >
                <asp:ListItem Value="-1" Text="Estados" />
            </asp:DropDownList>
        </div>
    </div>

    <asp:ScriptManager ID="scr_control" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upnl_becarios" runat="server">
        <ContentTemplate>
            <div class='d-flex justify-content-center w-100'>
                <div class="w-75">
                    <!--Tabla de becarios-->
                    <asp:GridView PageSize="5" ID="table_becarios" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="sql_becarios" CssClass="table-dark table-hover table-bordered">
                        <Columns>
                            <asp:BoundField DataField="Nombre completo" HeaderText="Nombre completo" ReadOnly="True" SortExpression="Nombre completo" />
                            <asp:BoundField DataField="universidad" HeaderText="Universidad" SortExpression="universidad" />
                            <asp:BoundField DataField="carrera" HeaderText="Carrera" SortExpression="carrera" />
                            <asp:BoundField DataField="nivel_educativo" HeaderText="Nivel educativo" SortExpression="nivel_educativo" />
                            <asp:BoundField DataField="nombre" HeaderText="Programa" SortExpression="nombre" />
                            <asp:BoundField DataField="nombre_estado" HeaderText="Estado" SortExpression="nombre_estado" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/Contador/Contador.master" AutoEventWireup="true" CodeFile="Becarios.aspx.cs" Inherits="Contador_Becarios" %>

<asp:Content ID="cont_body" ContentPlaceHolderID="content_body" Runat="Server">
    
    <!--SQL-->
    <asp:SqlDataSource ID="sql_niveles" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [ID], [nivel_educativo] FROM [Niveles]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_programas_becas" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [codigo], [nombre] FROM [Programas]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_universidades" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [ID], [universidad] FROM [Universidades]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_carreras" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT [ID], [carrera] FROM [Carreras]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sql_becarios" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" DeleteCommand="DELETE FROM [Becarios] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Becarios] ([ID], [codigo_programa], [codigo_becario], [DatosAcademico], [Usuario]) VALUES (@ID, @codigo_programa, @codigo_becario, @DatosAcademico, @Usuario)" SelectCommand="SELECT Becarios.ID, Usuarios.Nombres, Usuarios.Apellidos, Programas.nombre, Carreras.carrera, Niveles.nivel_educativo, Universidades.universidad FROM Becarios INNER JOIN Usuarios ON Becarios.Usuario = Usuarios.ID INNER JOIN DatosAcademicos ON Becarios.ID = DatosAcademicos.Becario INNER JOIN Programas ON Becarios.codigo_programa = Programas.codigo INNER JOIN Carreras ON DatosAcademicos.Carrera = Carreras.ID INNER JOIN Universidades ON DatosAcademicos.Universidad = Universidades.ID INNER JOIN Niveles ON DatosAcademicos.Nivel = Niveles.ID WHERE (DatosAcademicos.Carrera = @carrera OR @carrera = 0) AND (DatosAcademicos.Universidad = @universidad OR @universidad = 0) AND (Becarios.codigo_programa = @programa OR @programa = '0') AND (DatosAcademicos.Nivel = @Nivel OR @Nivel = 0)" UpdateCommand="UPDATE [Becarios] SET [codigo_programa] = @codigo_programa, [codigo_becario] = @codigo_becario, [DatosAcademico] = @DatosAcademico, [Usuario] = @Usuario WHERE [ID] = @ID">
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
            <asp:ControlParameter ControlID="ddl_carreras" Name="carrera" PropertyName="SelectedValue" DefaultValue="0" />
            <asp:ControlParameter ControlID="ddl_universidades" DefaultValue="" Name="universidad" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddl_programas_becas" Name="programa" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddl_niveles" DefaultValue="" Name="Nivel" PropertyName="SelectedValue" />
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
            <asp:DropDownList AppendDataBoundItems="True" ID="ddl_niveles" runat="server" CssClass="form-control" style="min-width: 200px;" AutoPostBack="True" DataSourceID="sql_niveles" DataTextField="nivel_educativo" DataValueField="ID" >
                <asp:ListItem Value="0" Text="Nivel" />
            </asp:DropDownList>
        </div>
    </div>

    <asp:ScriptManager ID="scr_control" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upnl_becarios" runat="server">
        <ContentTemplate>
            <div class='w-100 d-flex justify-content-center'>
                <div class="w-75">
                    <!--Tabla de becarios-->
                    <asp:GridView PageSize="5" ID="table_becarios" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="sql_becarios" CssClass="table-dark table-hover table-bordered w-100 text-center mt-3" DataKeyNames="ID" OnSelectedIndexChanged="table_becarios_SelectedIndexChanged">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" InsertVisible="False" Visible="False" />
                            <asp:BoundField DataField="Nombres" HeaderText="Nombre" SortExpression="Nombres" />
                            <asp:BoundField DataField="Apellidos" HeaderText="Apellido" SortExpression="Apellidos" />
                            <asp:BoundField DataField="nombre" HeaderText="Programa" SortExpression="nombre" />
                            <asp:BoundField DataField="carrera" HeaderText="Carrera" SortExpression="carrera" />
                            <asp:BoundField DataField="nivel_educativo" HeaderText="Nivel" SortExpression="nivel_educativo" />
                            <asp:BoundField DataField="universidad" HeaderText="Universidad" SortExpression="universidad" />
                            <asp:CommandField ButtonType="Image" SelectImageUrl="~/img/eye.png" ShowSelectButton="True" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddl_programas_becas" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="ddl_universidades" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="ddl_carreras" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="ddl_niveles" EventName="SelectedIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
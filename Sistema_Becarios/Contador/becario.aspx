<%@ Page Title="" Language="C#" MasterPageFile="~/Contador/Contador.master" AutoEventWireup="true" CodeFile="becario.aspx.cs" Inherits="Contador_becario" %>

<asp:Content ID="cont_titulo" ContentPlaceHolderID="content_titulo" Runat="Server">
    Becario
</asp:Content>
<asp:Content ID="cont_menu" ContentPlaceHolderID="content_menu" Runat="Server">

    <asp:TextBox ID="txt_datos" runat="server" type="hidden" />
    <asp:SqlDataSource ID="sql_ciclos" runat="server" ConnectionString="<%$ ConnectionStrings:BecasFedisalConnectionString %>" SelectCommand="SELECT CONCAT( 'Ciclo #', ROW_NUMBER() OVER(ORDER BY Ciclos.ID ASC)) as [Ciclo], Ciclos.ID FROM Ciclos INNER JOIN DatosAcademicos ON Ciclos.Datos_becario = DatosAcademicos.ID WHERE DatosAcademicos.ID = @datos" >
        <SelectParameters>
            <asp:ControlParameter ControlID="txt_datos" Name="datos" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <li class="nav-item">
        <a class="nav-link" href="/Contador/becarios">Volver</a>
    </li>

    <li class="nav-item">
        <asp:DropDownList AppendDataBoundItems="true" AutoPostBack="true" style="min-width: 200px;" CssClass="form-control" ID="ddl_ciclos" runat="server" DataSourceID="sql_ciclos" DataTextField="Ciclo" DataValueField="ID" OnSelectedIndexChanged="ddl_ciclos_SelectedIndexChanged">
            <asp:ListItem Text="Ciclos" Value="-1" />
        </asp:DropDownList>
    </li>

</asp:Content>
<asp:Content ID="cont_body" ContentPlaceHolderID="content_body" Runat="Server">
     <div class="container p-0 m-0 w-100 h-100">
        <div class="row h-100">
            <div class="col-12 col-sm-3 bg-info text-white">
                <div class="row d-flex justify-content-center">
                    <img src="/img/driving-license.png" class="w-75" style="height: 25%;" />
                </div>
                <div class="row pl-4"> Codigo: <%= becario.codigo_becario %> </div>
                <div class="row pl-4"> Nombre completo: <%= (becario.Usuarios.Nombres + " " + becario.Usuarios.Apellidos).Trim() %> </div>
                <div class="row pl-4"> DUI: <%= becario.Usuarios.dui %> </div>
                <div class="row pl-4"> Direccion: <%= becario.Usuarios.direccion_be %> </div>
                <div class="row pl-4"> Telefono: <%= becario.Usuarios.telefono %> </div>
                <div class="row pl-4"> Fecha de nacimiento: <%= becario.Usuarios.fecha_nacimiento.ToString("yyyy-MM-dd") %> </div>
                <div class="row pl-4"> Univarsidad: <%= becario.DatosAcademicos.Last().Universidades.universidad %> </div>
                <div class="row pl-4"> Carrera: <%= becario.DatosAcademicos.Last().Carreras.carrera %> </div>
                <div class="row pl-4"> Estado: <%= (becario.Usuarios.Estado == 1)? "Activo" : "Inactivo" %> </div>
            </div>
            <div class="col-12 col-sm-9">
                <div class="row">
                    <div class="col">
                        <div class="row">
                            <div class="card col-12 col-md-7 offset-md-1">
                                <div class="card-body">
                                    <h5 class="card-title">Informacion del programa de becas</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">Programa de beca.</h6>
                                    <p class="card-text my-0"><span class="font-weight-bold">Fecha de inicio de la beca:</span></p>
                                    <p class="card-text my-0"><span class="font-weight-bold">Fecha de fin de la beca:</span></p>
                                    <p class="card-text my-0"><span class="font-weight-bold">Fecha de inicio del curso:</span></p>
                                    <p class="card-text my-0"><span class="font-weight-bold">Fecha de fin del curso:</span></p>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-md-3">
                            <div class="col-12 col-md-12 offset-md-1 p-0">
                                <div class="jumbotron m-0 pt-2">
                                    <h1 class="display-6">Presupuesto</h1>
                                    <hr class="my-2" />
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="txt_colegiatura">Libros:</label>
                                            <asp:TextBox type="number" ClientIDMode="Static" CssClass="form-control" ID="txt_colegiatura" placeholder="0.00$" runat="server" step="0.01" />
                                            <asp:RequiredFieldValidator ControlToValidate="txt_colegiatura" ErrorMessage="La colegiatura es obligatorio" ValidationGroup="gru_dinero" runat="server" Display="None" />
                                            <asp:RegularExpressionValidator ControlToValidate="txt_colegiatura" ErrorMessage="La colegiatura debe ser numero" ValidationGroup="gru_dinero" runat="server" Display="None" ValidationExpression="[0-9]+(\.[0-9][0-9]?)?" />
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="txt_manuntencion">Manuntencion:</label>
                                            <input type="number" class="form-control" id="txt_manuntencion" placeholder="0.00$" runat="server" step="0.01" />
                                            <asp:RequiredFieldValidator ControlToValidate="txt_manuntencion" ErrorMessage="La manuntencion es obligatorio" ValidationGroup="gru_dinero" runat="server" Display="None" />
                                            <asp:RegularExpressionValidator ControlToValidate="txt_manuntencion" ErrorMessage="La manuntencion debe ser numero" ValidationGroup="gru_dinero" runat="server" Display="None" ValidationExpression="[0-9]+(\.[0-9][0-9]?)?" />
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="txt_matricula">Matricula:</label>
                                            <input type="number" class="form-control" id="txt_matricula" placeholder="0.00$" runat="server" step="0.01" />
                                            <asp:RequiredFieldValidator ControlToValidate="txt_matricula" ErrorMessage="La matricula es obligatorio" ValidationGroup="gru_dinero" runat="server" Display="None" />
                                            <asp:RegularExpressionValidator ControlToValidate="txt_matricula" ErrorMessage="La matricula debe ser numero" ValidationGroup="gru_dinero" runat="server" Display="None" ValidationExpression="[0-9]+(\.[0-9][0-9]?)?" />
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="txt_otros">Otros:</label>
                                            <input type="number" class="form-control" id="txt_otros" placeholder="0.00$" runat="server" step="0.01" />
                                            <asp:RequiredFieldValidator ControlToValidate="txt_otros" ErrorMessage="Los otros gastos son obligatorios" ValidationGroup="gru_dinero" runat="server" Display="None" />
                                            <asp:RegularExpressionValidator ControlToValidate="txt_otros" ErrorMessage="Los otros gastos deben de ser numerico" ValidationGroup="gru_dinero" runat="server" Display="None" ValidationExpression="[0-9]+(\.[0-9][0-9]?)?" />
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="txt_seguro">Seguro:</label>
                                            <input type="number" class="form-control" id="txt_seguro" placeholder="0.00$" runat="server" step="0.01" />
                                            <asp:RequiredFieldValidator ControlToValidate="txt_seguro" ErrorMessage="El seguro es obligatorio" ValidationGroup="gru_dinero" runat="server" Display="None" />
                                            <asp:RegularExpressionValidator ControlToValidate="txt_seguro" ErrorMessage="El seguro debe ser numero" ValidationGroup="gru_dinero" runat="server" Display="None" ValidationExpression="[0-9]+(\.[0-9][0-9]?)?" />
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="txt_graduacion">Trabajo de graduacion:</label>
                                            <input type="number" class="form-control" id="txt_graduacion" placeholder="0.00$" runat="server" step="0.01" />
                                            <asp:RequiredFieldValidator ControlToValidate="txt_graduacion" ErrorMessage="La graduacion es obligatorio" ValidationGroup="gru_dinero" runat="server" Display="None" />
                                            <asp:RegularExpressionValidator ControlToValidate="txt_graduacion" ErrorMessage="La graduacion debe ser numero" ValidationGroup="gru_dinero" runat="server" Display="None" ValidationExpression="[0-9]+(\.[0-9][0-9]?)?" />
                                        </div>
                                    </div>

                                    <asp:ValidationSummary ID="validacion_sumary" ValidationGroup="gru_dinero" DisplayMode="BulletList" runat="server" CssClass="alert alert-danger" />

                                    <div class="btn-group" role="group" aria-label="Basic example">
                                        <asp:Button ValidationGroup="gru_dinero" runat="server" ID="btnModificar" type="button" CssClass="btn btn-primary" Text="Modificar" OnClick="btnModificar_Click" />
                                        <button id="btnResetear" runat="server" type="reset" class="btn btn-danger"> Resetear </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


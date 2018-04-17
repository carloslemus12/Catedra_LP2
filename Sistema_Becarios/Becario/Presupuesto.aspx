<%@ Page Title="" Language="C#" MasterPageFile="~/Becario/Becario.master" AutoEventWireup="true" CodeFile="Presupuesto.aspx.cs" Inherits="Becario_Presupuesto" %>

<asp:Content ID="cont_titulo" ContentPlaceHolderID="content_titulo" Runat="Server">
    Presupuesto - Carlos Lemus
</asp:Content>
<asp:Content ID="cont_menu" ContentPlaceHolderID="content_menu" Runat="Server">
    
    <li class="nav-item">
        <a class="nav-link" href="/Becario/index.aspx">Volver</a>
    </li>

    <li class="nav-item">
        <a class="nav-link" href="/Becario/Ciclos.aspx">Historial de ciclos</a>
    </li>

</asp:Content>

<asp:Content ID="cont_body" ContentPlaceHolderID="content_body" Runat="Server">
    <div class="container">
        <div class="row">
            <div class="col-12 col-md-6">
                <div class="card w-100 mb-5 bg-transparent">
                    <center><img class="card-img-top py-5" style="width: 7rem;" src="/img/coins.svg" alt="Card image cap" /></center>
                    
                    <div class="card-header text-center bg-dark text-white">
                        <h5 class="card-title">Presupuesto original</h5>
                    </div>

                    <div class="card-body bg-white">
                        <div class="form-row">
                            <div class="form-group col-12 col-md-6">
                                <label for="txtMatricula">Matricula</label>
                                <input id="txtMatricula" class="form-control" readonly="true" value="<%= "" + matricula + "$" %>" />
                            </div>

                            <div class="form-group col-12 col-md-6">
                                <label for="txtLibros">Libros</label>
                                <input id="txtLibros" class="form-control" readonly="true" value="<%= "" + manuntencion + "$" %>" />
                            </div>

                            <div class="form-group col-12 col-md-6">
                                <label for="txtAraceles">Araceles</label>
                                <input id="txtAraceles" class="form-control" readonly="true" value="<%= "" + libros + "$" %>" />
                            </div>

                            <div class="form-group col-12 col-md-6">
                                <label for="txtSeguro">Seguro</label>
                                <input id="txtSeguro" class="form-control" readonly="true" value="<%= "" + aranceles + "$" %>" />
                            </div>

                            <div class="form-group col-12 col-md-6">
                                <label for="txtOtros">Manuntencion</label>
                                <input id="txtOtros" class="form-control" readonly="true" value="<%= "" + graduacion + "$" %>" />
                            </div>

                            <div class="form-group col-12 col-md-6">
                                <label for="txtGraduacion">Trabajo de graduacion</label>
                                <input id="txtGraduacion" class="form-control" readonly="true" value="<%= "" + seguro + "$" %>" />
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="card w-100 mb-5 bg-transparent">
                    <center><img class="card-img-top py-5" style="width: 7rem;" src="/img/money-bag.svg" alt="Card image cap" /></center>
                    
                    <div class="card-header text-center bg-dark text-white">
                        <h5 class="card-title">Presupuesto actual</h5>
                    </div>

                    <div class="card-body bg-white">
                        <div class="form-row">
                            <div class="form-group col-12 col-md-6">
                                <label for="txtMatricula_1">Matricula</label>
                                <input id="txtMatricula_1" class="form-control" readonly="true" value="<%= "" + presupuesto.matricula + "$" %>" />
                            </div>

                            <div class="form-group col-12 col-md-6">
                                <label for="txtLibros_1">Libros</label>
                                <input id="txtLibros_1" class="form-control" readonly="true" value="<%= "" + presupuesto.colegiatura + "$" %>" />
                            </div>

                            <div class="form-group col-12 col-md-6">
                                <label for="txtAraceles_1">Araceles</label>
                                <input id="txtAraceles_1" class="form-control" readonly="true" value="<%= "" + presupuesto.aranceles + "$" %>" />
                            </div>

                            <div class="form-group col-12 col-md-6">
                                <label for="txtSeguro_1">Seguro</label>
                                <input id="txtSeguro_1" class="form-control" readonly="true" value="<%= "" + presupuesto.seguro + "$" %>" />
                            </div>

                            <div class="form-group col-12 col-md-6">
                                <label for="txtOtros_1">Manuntencion</label>
                                <input id="txtOtros_1" class="form-control" readonly="true" value="<%= "" + presupuesto.manutencion + "$" %>" />
                            </div>

                            <div class="form-group col-12 col-md-6">
                                <label for="txtGraduacion_1">Trabajo de graduacion</label>
                                <input id="txtGraduacion_1" class="form-control" readonly="true" value="<%= "" + presupuesto.trabajo_graduacion + "$" %>" />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
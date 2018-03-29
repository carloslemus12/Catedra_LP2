<%@ Page Title="" Language="C#" MasterPageFile="~/Contador/Contador.master" AutoEventWireup="true" CodeFile="Becario_ciclo.aspx.cs" Inherits="Contador_Becario_ciclo" %>

<asp:Content ID="cont_titulo" ContentPlaceHolderID="content_titulo" Runat="Server">
Ciclo del becario
</asp:Content>
<asp:Content ID="cont_menu" ContentPlaceHolderID="content_menu" Runat="Server">
    <li class="nav-item">
        <a class="nav-link" href="/Contador/becario/1"><i class="material-icons">arrow_back</i></a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="/Contador/becario/1/ciclo/1">Ciclos</a>
    </li>
</asp:Content>
<asp:Content ID="cont_body" ContentPlaceHolderID="content_body" Runat="Server">
    <div class="container">
        <div class="row mt-2">
            <div class="col">
                <div class="card">
                    <div class="card-header"> Informacion del becario </div>
                    <div class="card-body">
                        <div class="row"> 
                            <div class="col-12 col-md">
                                Codigo: <span></span>
                            </div>
                            <div class="col-12 col-md">
                                Nombre completo: <span></span>
                            </div>
                            <div class="col-12 col-md">
                                DUI: <span></span>
                            </div>
                        </div>

                        <div class="row"> 
                            <div class="col-12 col-md">
                                Univarsidad: <span></span>
                            </div>
                            <div class="col-12 col-md">
                                Carrera: <span></span>
                            </div>
                            <div class="col-12 col-md">
                                Programa de beca: <span></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col d-flex justify-content-center">
                <div class="btn-group" role="group" aria-label="Basic example">
                    <button type="button" class="btn btn-secondary"><i class="material-icons">arrow_back</i></button>
                    <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#modal_indice">...</button>
                    <button type="button" class="btn btn-secondary"><i class="material-icons">arrow_forward</i></button>
                </div>
            </div>
        </div>
        <div class="row mt-2">
            <div class="card bg-dark text-white col-md-4">
                <div class="card-body">
                    <h5 class="card-title">Notas:</h5>
                    <hr class="bg-white text-white border-white my-0" />
                </div>
            </div>

            <div class="col-md-8 pl-md-5">
                <div class="row">
                    <div class="card bg-success text-white col-md-8 offset-md-4">
                        <div class="card-body">
                            <h5 class="card-title">Informacion del ciclo:</h5>
                            <hr class="bg-white text-white border-white my-0" />
                            <p class="card-text my-0"><span class="font-weight-bold">Estado:</span></p>
                            <p class="card-text my-0"><span class="font-weight-bold">Fecha de inicio del ciclo:</span></p>
                            <p class="card-text my-0"><span class="font-weight-bold">Fecha de fin del ciclo:</span></p>
                        </div>
                    </div>
                </div>

                <div class="row mt-md-2">
                    <div class="card bg-primary text-white col">
                        <div class="card-body">
                            <h5 class="card-title">Reguistro de desembolso:</h5>
                            <hr class="bg-white text-white border-white my-0" />
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


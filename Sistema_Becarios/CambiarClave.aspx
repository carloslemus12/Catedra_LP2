<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CambiarClave.aspx.cs" Inherits="CambiarClave" %>

<!DOCTYPE html>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/estilo_login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="h-100">
        <div id="_clientScript" runat="server"></div>
        <section class="container-fluid w-100 h-100 d-flex align-items-center justify-content-center">

            <div class="card card-login">
                <div class="card-header text-center">
                    <h1 class="display-4" id="divUsuario" runat="server">Usuario: </h1>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label for="txtPasswordActual">Contraseña del usuario:</label>
                        <asp:TextBox CssClass="form-control" ID="txtPasswordActual" runat="server" TextMode="Password" />
                        <asp:RequiredFieldValidator ControlToValidate="txtPasswordActual" ErrorMessage="La clave del usuario es obligatorio" runat="server" Display="Dynamic" CssClass="text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtPassword">Contraseña nueva:</label>
                        <asp:TextBox CssClass="form-control" ID="txtPassword" runat="server" TextMode="Password" />
                        <asp:RequiredFieldValidator ControlToValidate="txtPassword" ErrorMessage="La clave del usuario es obligatorio" runat="server" Display="Dynamic" CssClass="text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtPassword1">Confirmar contraseña:</label>
                        <asp:TextBox CssClass="form-control" ID="txtPassword1" runat="server" TextMode="Password" />
                        <asp:RequiredFieldValidator ControlToValidate="txtPassword1" ErrorMessage="La clave del usuario es obligatorio" runat="server" Display="Dynamic" CssClass="text-danger" />
                        <asp:CompareValidator runat="server" ErrorMessage="Las dos claves deben de coincidir" ControlToValidate="txtPassword1" Display="Dynamic" ControlToCompare="txtPassword" CssClass="text-danger" Operator="Equal" />
                    </div>

                    <div id="divMsg" runat="server" class="alert alert-danger alert-dismissible fade show mb-0 d-none" role="alert">
                        <strong>ERROR:</strong> <span id="spnMsg" runat="server"></span>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                </div>
                <div class="card-footer text-muted">
                    <asp:Button ID="btnCambiarClave" runat="server" CssClass="btn btn-danger text-white w-100" Text="Cambiar clave" OnClick="btnCambiarClave_Click"/>
                </div>
            </div>

        </section>

    </form>

    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>


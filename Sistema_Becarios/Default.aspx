<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/estilo_login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="h-100">
    
        <section class="container-fluid w-100 h-100 d-flex align-items-center justify-content-center">

            <div class="card card-login">
                <div class="card-body">
                
                    <div class="d-flex w-100 justify-content-center">
                        <img src="img/login.svg" class="img_login mt-3 mb-5"/>
                    </div>

                    <div class="form-group">
                        <label for="txtUsername">Nombre de usuario:</label>
                        <asp:TextBox CssClass="form-control" ID="txtUsername" runat="server" />
                        <asp:RequiredFieldValidator ControlToValidate="txtUsername" ErrorMessage="El nombre del usuario es obligatorio" runat="server" Display="Dynamic" CssClass="text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="txtPassword">Contraseña del usuario:</label>
                        <asp:TextBox CssClass="form-control" ID="txtPassword" runat="server" TextMode="Password" />
                        <asp:RequiredFieldValidator ControlToValidate="txtPassword" ErrorMessage="La clave del usuario es obligatorio" runat="server" Display="Dynamic" CssClass="text-danger" />
                    </div>

                    <div id="divMsg" runat="server" class="alert alert-danger alert-dismissible fade show mb-0 d-none" role="alert">
                        <strong>ERROR:</strong> <span id="spnMsg" runat="server"></span>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                </div>
                <div class="card-footer text-muted">
                    <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-danger text-white w-100" Text="Iniciar secion" OnClick="btnLogin_Click" />
                </div>
            </div>

        </section>

    </form>

    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>

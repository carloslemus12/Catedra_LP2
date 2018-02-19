<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Becas.aspx.cs" Inherits="Administrador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestion Becarios</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    
        <!-- Menu de navegacion -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
            <span class="navbar-brand">
                <img src="../img/jesus.svg" alt="" width="40" height="40" />
            </span>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu_principal" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="menu_principal">
                <ul class="navbar-nav mr-auto">
                    
                    <li class="nav-item">
                        <a class="nav-link" href="#">Usuarios</a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="/Administrador/Becas.aspx">Programas de becas</a>
                    </li>
              
                    <li class="nav-item">
                        <a class="nav-link" href="#">Universidades</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#">Carreras</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#">Niveles de estudio</a>
                    </li>
                </ul>

                <div class="d-flex flex-row justify-content-center">
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <img src="../img/settings.svg" alt="" id="menuAjustes" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" width="30" height="30" />
                        

                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="menuAjustes">
                                <a class="dropdown-item" href="#">Cambiar clave</a>
                                <a class="dropdown-item" href="#">Cerrar secion</a>
                            </div>                           
                        </li>
                    </ul>

                </div>
            
            </div>
        </nav>
        <!-- // ///////////////////////////////////////////// -->

    </form>

    <!-- Pie de la pagina web -->
    <footer class="bg-danger text-white text-center py-2 fixed-bottom">
        <span class="font-weight-bold">Universidad Don Bosco<small class="font-weight-normal ml-1"> PILET 2018 </small></span>
    </footer>

    <script src="../js/jquery-3.2.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</body>
</html>

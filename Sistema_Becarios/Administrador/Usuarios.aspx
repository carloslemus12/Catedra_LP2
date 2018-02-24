﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Usuarios.aspx.cs" Inherits="Administrador_Usuarios" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestion Usuarios</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/estilos-app.css" rel="stylesheet" />
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
                    
                    <li class="nav-item active">
                        <a class="nav-link" href="/Administrador/Usuarios.aspx">Usuarios</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Becas.aspx">Programas de becas</a>
                    </li>
              
                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Universidades.aspx">Universidades</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Carreras.aspx">Carreras</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/Administrador/Niveles.aspx">Niveles de estudio</a>
                    </li>

                    <li class="nav-item d-block d-lg-none">
                        <a class="nav-link" href="#">Cambiar clave</a>
                    </li>

                    <li class="nav-item d-block d-lg-none">
                        <a class="nav-link" href="#">Cerrar secion</a>
                    </li>
                </ul>

                <div class="d-none flex-row justify-content-center d-lg-flex">
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

    </form>

    <!-- Pie de la pagina web -->
    <div class="container-fluid m-0 p-0 fixed-bottom">
        <button type="button" class="btn btn-info ml-2 mb-2" data-toggle="modal" data-target="#modalNuevoUsuario">Nuevo usuario</button>
        
        <footer class="bg-danger text-white text-center py-2">
            <span class="font-weight-bold">Universidad Don Bosco<small class="font-weight-normal ml-1"> PILET 2018 </small></span>
        </footer>
    </div>

    <script src="../js/jquery-3.2.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</body>
</html>

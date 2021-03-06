﻿<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        RegisterRoutes(RouteTable.Routes);
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

    public static void RegisterRoutes(RouteCollection routes)
    {
        routes.MapPageRoute("login", "login", "~/Default.aspx");
        routes.MapPageRoute("becas", "Administracion/Becas", "~/Administrador/Becas.aspx");
        routes.MapPageRoute("carreras", "Administracion/Carreras", "~/Administrador/Carreras.aspx");
        routes.MapPageRoute("niveles", "Administracion/Niveles_Educativos", "~/Administrador/Niveles.aspx");
        routes.MapPageRoute("universidades", "Administracion/Universidades", "~/Administrador/Universidades.aspx");
        routes.MapPageRoute("usuarios", "Administracion/Usuarios", "~/Administrador/Usuarios.aspx");
        routes.MapPageRoute("clave", "Clave", "~/CambiarClave.aspx");
        routes.MapPageRoute("contador", "Contador/Becarios", "~/Contador/Becarios.aspx");
        routes.MapPageRoute("contador_becario", "Contador/Becario/{becario}", "~/Contador/becario.aspx");
        routes.MapPageRoute("contador_becario_ciclos", "Contador/Becario/{becario}/Ciclo/{ciclo}", "~/Contador/Becario_ciclo.aspx");

        routes.MapPageRoute("GestorEducativo_Becarios", "GestorEducativo/Becarios", "~/GestorEducativo/Becarios.aspx");
        routes.MapPageRoute("GestorEducativo_Ciclos", "GestorEducativo/Ciclos", "~/GestorEducativo/Ciclos.aspx");
    }

</script>

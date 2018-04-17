using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BecariosModelo
/// </summary>
public class BecariosModelo
{
    BecasFedisalEntities becas = new BecasFedisalEntities();

    public static Becarios Encontrar(int id) {
        BecasFedisalEntities becas = new BecasFedisalEntities();
        return becas.Becarios.Find(id);
    }

    public static Ciclos encontrarCiclo(int id)
    {
        BecasFedisalEntities becas = new BecasFedisalEntities();
        return becas.Ciclos.Find(id);
    }

    public static Presupuestos encontrarPresupuesto(int id)
    {
        BecasFedisalEntities becas = new BecasFedisalEntities();
        return becas.Presupuestos.Find(id);
    }

    public static DatosAcademicos encontrarDatosAcademicos(int id)
    {
        BecasFedisalEntities becas = new BecasFedisalEntities();
        return becas.DatosAcademicos.Find(id);
    }

    public static Notas encontrarNota(int id)
    {
        BecasFedisalEntities becas = new BecasFedisalEntities();
        return becas.Notas.Find(id);
    }

    public static void crearCiclo(DatosAcademicos datos)
    {
        BecasFedisalEntities becas = new BecasFedisalEntities();
        Ciclos ciclo = new Ciclos();
        ciclo.Datos_becario = datos.ID;
        becas.Ciclos.Add(ciclo);
        becas.SaveChanges();
    }

    public static void guardarMateria(int id_ciclo, string nombre, double nota, int uv)
    {
        Notas materia = new Notas();
        materia.Ciclo = id_ciclo;
        materia.nombre_materia = nombre;
        materia.nota = (decimal)nota;
        materia.uv_materia = uv;

        BecasFedisalEntities becas = new BecasFedisalEntities();
        becas.Notas.Add(materia);
        becas.SaveChanges();
    }

    public static void modificarMateria(Notas notas, string nombre, double nota, int uv)
    {
        BecasFedisalEntities becas = new BecasFedisalEntities();

        Notas materia = becas.Notas.Find(notas.ID);
        materia.nombre_materia = nombre;
        materia.nota = (decimal)nota;
        materia.uv_materia = uv;

        becas.SaveChanges();
    }

    public class Desembolso{
        public decimal Graduacion = 0;
        public decimal Araceles = 0;
        public decimal Libro = 0;
        public decimal Manuntencion = 0;
        public decimal Matricula = 0;
        public decimal Seguro = 0;
    }

    public static void agregarIncidente(int ciclo, string incidente)
    {
        Incidentes observacion = new Incidentes();
        observacion.Ciclo = ciclo;
        observacion.detalle = incidente;

        BecasFedisalEntities becas = new BecasFedisalEntities();
        becas.Incidentes.Add(observacion);
        becas.SaveChanges();
    }

    public static void eliminarIncidente(int incidente)
    {
        BecasFedisalEntities becas = new BecasFedisalEntities();

        Incidentes observacion = becas.Incidentes.Find(incidente);

        becas.Incidentes.Remove(observacion);
        becas.SaveChanges();
    }

    public static Desembolso obtenerTotalDesembolsado(int id_presupuesto) {
        
        decimal graduacion = 0, araceles = 0, libro = 0, manuntencion = 0, matricula = 0, seguro = 0;
        

        string consulta = "select TipoDesembolso, sum(monto_desembolso) from Desembolsos WHERE Desembolsos.Presupuesto = @presupuesto group by TipoDesembolso";

        SqlConnection conexion = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BecasFedisalConnectionString"].ConnectionString);
        conexion.Open();

        SqlCommand comando = new SqlCommand(consulta, conexion);

        comando.Parameters.Add("@presupuesto", System.Data.SqlDbType.Int);

        comando.Parameters["@presupuesto"].Value = id_presupuesto;

        SqlDataReader lector =  comando.ExecuteReader();

        while (lector.Read())
        {
            switch (lector.GetString(0))
            {
                case "Trabajo de graduacion":
                    graduacion = lector.GetDecimal(1);
                    break;
                case "Araceles":
                    araceles = lector.GetDecimal(1);
                    break;
                case "Libros":
                    libro = lector.GetDecimal(1);
                    break;
                case "Manuntencion":
                    manuntencion = lector.GetDecimal(1);
                    break;
                case "Matricula":
                    matricula = lector.GetDecimal(1);
                    break;
                case "Seguro":
                    seguro = lector.GetDecimal(1);
                    break;
            }
        }

        conexion.Close();

        return new Desembolso(){ Graduacion = graduacion, Araceles = araceles, Libro = libro, Manuntencion = manuntencion, Matricula = matricula, Seguro = seguro };
    }

    public static void eliminarrMateria(Notas notas)
    {
        BecasFedisalEntities becas = new BecasFedisalEntities();

        Notas materia = becas.Notas.Find(notas.ID);

        becas.Notas.Remove(materia);
        becas.SaveChanges();
    }

    public static Ciclos obtenerUltimoCiclo(DatosAcademicos datos)
    {
        return datos.Ciclos.LastOrDefault();
    }

    public static void añandirCiclo(DatosAcademicos datos)
    {
        Ciclos ciclo = new Ciclos();
        ciclo.Datos_becario = datos.ID;

        BecasFedisalEntities becas = new BecasFedisalEntities();
        becas.Ciclos.Add(ciclo);
        becas.SaveChanges();
    }

    public static Boolean poseeCiclos(DatosAcademicos datos)
    {
        return datos.Ciclos.Count > 0;
    }

    public static bool devolverDinero(Presupuestos presupuesto_actual, int id_desembolso)
    {
        BecasFedisalEntities becas = new BecasFedisalEntities();
        
        Presupuestos presupuesto = becas.Presupuestos.Find(presupuesto_actual.ID);
        Desembolsos desembolso = becas.Desembolsos.Find(id_desembolso);

        string tipo = desembolso.TipoDesembolso;

        if (tipo.Equals("Trabajo de graduacion"))
            presupuesto.trabajo_graduacion += desembolso.monto_desembolso;
        else if (tipo.Equals("Araceles"))
            presupuesto.aranceles += desembolso.monto_desembolso;
        else if (tipo.Equals("Libros"))
            presupuesto.libros += desembolso.monto_desembolso;
        else if (tipo.Equals("Manuntencion"))
            presupuesto.manutencion += desembolso.monto_desembolso;
        else if (tipo.Equals("Matricula"))
            presupuesto.matricula += desembolso.monto_desembolso;
        else if (tipo.Equals("Seguro"))
            presupuesto.seguro += desembolso.monto_desembolso;

        becas.Desembolsos.Remove(desembolso);
        becas.SaveChanges();
        
        return true;
    }

    public static bool agregarDesembolso(Presupuestos presupuesto_actual, int id_cilo, string tipo, double monto)
    {
        BecasFedisalEntities becas = new BecasFedisalEntities();

        decimal desembolso = (decimal)monto;
        Presupuestos presupuesto = becas.Presupuestos.Find(presupuesto_actual.ID);

        if (tipo.Equals("Trabajo de graduacion"))
            if (presupuesto.trabajo_graduacion < desembolso)
                return false;
            else
                presupuesto.trabajo_graduacion -= desembolso;
        else if (tipo.Equals("Araceles"))
            if (presupuesto.aranceles < desembolso)
                return false;
            else
                presupuesto.aranceles -= desembolso;
        else if (tipo.Equals("Libros"))
            if (presupuesto.libros < desembolso)
                return false;
            else
                presupuesto.libros -= desembolso;
        else if (tipo.Equals("Manuntencion"))
            if (presupuesto.manutencion < desembolso)
                return false;
            else
                presupuesto.manutencion -= desembolso;
        else if (tipo.Equals("Matricula"))
            if (presupuesto.matricula < desembolso)
                return false;
            else
                presupuesto.matricula -= desembolso;
        else if (tipo.Equals("Seguro"))
            if (presupuesto.seguro < desembolso)
                return false;
            else
                presupuesto.seguro -= desembolso;

        Desembolsos desembolsar = new Desembolsos();
        desembolsar.Ciclo = id_cilo;
        desembolsar.Presupuesto = presupuesto.ID;
        desembolsar.monto_desembolso = desembolso;
        desembolsar.TipoDesembolso = tipo;
        desembolsar.fecha_desembolso = DateTime.Now;

        becas.Desembolsos.Add(desembolsar);
        becas.SaveChanges();

        return true;
    }

    public static bool esElUltimoCiclo(DatosAcademicos datos, int id_ciclo)
    {
        Ciclos utilmoCiclo = datos.Ciclos.LastOrDefault();
        return (utilmoCiclo == null && utilmoCiclo.ID == id_ciclo);
    }

    public void GuardarBecario(string nombre, string apellido, string telefono, string direccion, string correo, string fecha, string clave, string cod_beca, string dui = null) {
        Usuarios usuario = new Usuarios();

        usuario.Nombres = nombre;
        usuario.Apellidos = apellido;
        usuario.dui = dui;
        usuario.telefono = telefono;
        usuario.direccion_be = direccion;
        usuario.correo = correo;
        usuario.fecha_nacimiento = DateTime.Parse(fecha);
        usuario.contraseña = clave;
        usuario.TipoUsuarios = 4;
        usuario.Estado = 1;

        becas.Usuarios.Add(usuario);
        becas.SaveChanges();

        int id_usuario = (from usuarios in becas.Usuarios orderby usuarios.ID descending select usuarios.ID).FirstOrDefault();
        string consulta = "insert into Becarios (codigo_programa, Usuario) values (@programa, @usuario)";

        SqlConnection conexion = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BecasFedisalConnectionString"].ConnectionString);
        conexion.Open();

        SqlCommand comando = new SqlCommand(consulta, conexion);

        comando.Parameters.Add("@programa", System.Data.SqlDbType.VarChar);
        comando.Parameters.Add("@usuario", System.Data.SqlDbType.VarChar);

        comando.Parameters["@programa"].Value = cod_beca;
        comando.Parameters["@usuario"].Value = id_usuario;

        comando.ExecuteNonQuery();

        conexion.Close();
    }

    public void ModificarBecario(Usuarios user, Becarios becario, string nombre, string apellido, string telefono, string direccion, string correo, string fecha, string cod_beca, int estado, string dui = null)
    {
        Usuarios usuario = becas.Usuarios.Find(user.ID);

        usuario.Nombres = nombre;
        usuario.Apellidos = apellido;
        usuario.dui = dui;
        usuario.telefono = telefono;
        usuario.direccion_be = direccion;
        usuario.correo = correo;
        usuario.fecha_nacimiento = DateTime.Parse(fecha);
        usuario.Estado = estado;

        becas.SaveChanges();

        string consulta = "UPDATE Becarios SET codigo_programa = @programa WHERE ID = @ID";

        SqlConnection conexion = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BecasFedisalConnectionString"].ConnectionString);
        conexion.Open();

        SqlCommand comando = new SqlCommand(consulta, conexion);

        comando.Parameters.Add("@programa", System.Data.SqlDbType.VarChar);
        comando.Parameters.Add("@ID", System.Data.SqlDbType.VarChar);

        comando.Parameters["@programa"].Value = cod_beca;
        comando.Parameters["@ID"].Value = becario.ID;

        comando.ExecuteNonQuery();

        conexion.Close();
    }

    public void guardarDatos(Becarios becario, int universidad, int carrera, int nivel, string fecha_inicio, string fecha_final) {
        DatosAcademicos datos = new DatosAcademicos();
        datos.Becario = becario.ID;
        datos.Universidad = universidad;
        datos.Carrera = carrera;
        datos.Nivel = nivel;
        datos.fecha_inicio = DateTime.Parse(fecha_inicio);
        datos.fecha_finalizacion = DateTime.Parse(fecha_final);

        becas.DatosAcademicos.Add(datos);
        becas.SaveChanges();
    }

    public void actualizarDatos(DatosAcademicos dato, int universidad, int carrera, int nivel, string fecha_inicio, string fecha_final)
    {
        DatosAcademicos datos = becas.DatosAcademicos.Find(dato.ID);
        datos.Universidad = universidad;
        datos.Carrera = carrera;
        datos.Nivel = nivel;
        datos.fecha_inicio = DateTime.Parse(fecha_inicio);
        datos.fecha_finalizacion = DateTime.Parse(fecha_final);
        
        becas.SaveChanges();
    }
     
    public void guardarPresupuesto(DatosAcademicos datos, double graduacion, double aracele, double libro, double manuntencio, double matricula, double seguro) {
        Presupuestos presupuesto = new Presupuestos();
        presupuesto.Datos_becario = datos.ID;
        presupuesto.trabajo_graduacion = (decimal)graduacion;
        presupuesto.aranceles = (decimal)aracele;
        presupuesto.libros = (decimal)libro;
        presupuesto.manutencion = (decimal)manuntencio;
        presupuesto.matricula = (decimal)matricula;
        presupuesto.seguro = (decimal)seguro;

        becas.Presupuestos.Add(presupuesto);
        becas.SaveChanges();
    }

    public void actualizarPresupuesto(Presupuestos datos, double graduacion, double aracele, double libro, double manuntencio, double matricula, double seguro)
    {
        Presupuestos presupuesto = becas.Presupuestos.Find(datos.ID);
        presupuesto.trabajo_graduacion = (decimal)graduacion;
        presupuesto.aranceles = (decimal)aracele;
        presupuesto.libros = (decimal)libro;
        presupuesto.manutencion = (decimal)manuntencio;
        presupuesto.matricula = (decimal)matricula;
        presupuesto.seguro = (decimal)seguro;

        becas.SaveChanges();
    }


    public void actualizarPresupuesto(Presupuestos datos, decimal graduacion, decimal aracele, decimal libro, decimal manuntencio, decimal matricula, decimal seguro)
    {
        Presupuestos presupuesto = becas.Presupuestos.Find(datos.ID);

        presupuesto.trabajo_graduacion = graduacion;
        presupuesto.aranceles = aracele;
        presupuesto.libros = libro;
        presupuesto.manutencion = manuntencio;
        presupuesto.matricula = matricula;
        presupuesto.seguro = seguro;

        becas.SaveChanges();
    }
}
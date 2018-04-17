using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Becario_Presupuesto : System.Web.UI.Page
{
    public Becarios becario;
    public Ciclos ciclo;
    public Presupuestos presupuesto;

    public decimal matricula = 0;
    public decimal manuntencion = 0;
    public decimal libros = 0;
    public decimal aranceles = 0;
    public decimal graduacion = 0;
    public decimal seguro = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        Usuarios usuario = (Usuarios)Session["usuario"];

        becario = usuario.Becarios.LastOrDefault();

        DatosAcademicos datos = becario.DatosAcademicos.LastOrDefault();

        presupuesto = datos.Presupuestos.Last();

        // Obtenemos los datos del presupuesto global
        var desembolos = BecariosModelo.obtenerTotalDesembolsado(presupuesto.ID);

        // Total del dinero
        matricula = presupuesto.matricula + desembolos.Matricula;
        manuntencion = presupuesto.manutencion + desembolos.Manuntencion;
        libros = presupuesto.libros + desembolos.Libro;
        aranceles = presupuesto.aranceles + desembolos.Araceles;
        graduacion = presupuesto.trabajo_graduacion + desembolos.Graduacion;
        seguro = presupuesto.seguro + desembolos.Seguro;
    }
}
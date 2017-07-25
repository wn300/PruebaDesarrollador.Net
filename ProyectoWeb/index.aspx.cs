using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index : System.Web.UI.Page
{
    #region PageLoad
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }


    #endregion

    #region Web Methods
    [WebMethod]
    public static object IngresarAlcancia(modelo objeto)
    {
        return objeto;
    }

    [WebMethod]
    public static string ValidarPalindromo(string txt_texto_ingresado)
    {
        string texto_ingresado = txt_texto_ingresado.Replace(" ", "").ToLower();
        char[] charArray = texto_ingresado.ToCharArray();
        Array.Reverse(charArray);
        string texto_invertido = new string(charArray);

        if (texto_ingresado.Equals(texto_invertido))
        {
            return "Si es palindromo";
        }
        else
        {
            return "No es palindromo";
        }
    }
    #endregion

    #region Methods and Events
    #endregion
}
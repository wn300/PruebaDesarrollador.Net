<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SPA</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="bootstrap-4.0.0-dist/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="css/general.styles.css" type="text/css" />
    <link rel="stylesheet" href="bootstrap-4.0.0-dist/font-awesome/css/font-awesome.min.css" type="text/css" />

    <script src="bootstrap-4.0.0-dist/jquery/jquery.min.js"></script>
    <script src="bootstrap-4.0.0-dist/js/bootstrap.min.js"></script>

    <%--<link rel="icon" type="image/x-icon" href="logo1.png" />--%>

    <script type="text/javascript">
        var arregloResultado = {};

        var arreglo = {};
        arreglo.cincuenta = 0;
        arreglo.cien = 0;
        arreglo.docientos = 0;
        arreglo.quinientos = 0;
        arreglo.mil = 0;
        arreglo.total = 0;

        $(document).ready(function () {
            arregloInicial = JSON.parse(localStorage.getItem("objetoStorage")) == null ? arreglo : JSON.parse(localStorage.getItem("objetoStorage"));

            $.cargarHistorial(arregloInicial);

            arreglo.cincuenta = arregloInicial.cincuenta;
            arreglo.cien = arregloInicial.cien;
            arreglo.docientos = arregloInicial.docientos;
            arreglo.quinientos = arregloInicial.quinientos;
            arreglo.mil = arregloInicial.mil;
            arreglo.total = arregloInicial.total;

            $("#btnCincuenta").click(function () {
                arreglo.cincuenta = arreglo.cincuenta + 1;
                $.sumaMonedas($(this).val());
            });
            $("#btnCien").click(function () {
                arreglo.cien = arreglo.cien + 1;
                $.sumaMonedas($(this).val());
            });
            $("#btnDocientos").click(function () {
                arreglo.docientos = arreglo.docientos + 1;
                $.sumaMonedas($(this).val());
            });
            $("#btnQuinientos").click(function () {
                arreglo.quinientos = arreglo.quinientos + 1;
                $.sumaMonedas($(this).val());
            });
            $("#btnMil").click(function () {
                arreglo.mil = arreglo.mil + 1;
                $.sumaMonedas($(this).val());
            });
            $("#btnIngresar").click(function () {
                if (arreglo.total == 0) {
                    alert("Tiene que ingresar almenos una moneda.")
                } else {
                    $.ingresarAlcancia(arreglo);
                }
            });

            $("#btn_validar").click(function () {
                $.validarPalindromo($("#txt_texto_ingresado").val());
            });

            $("#btnLimpiar").click(function () {
                localStorage.clear("objetoStorage");
                arreglo.cincuenta = 0;
                arreglo.cien = 0;
                arreglo.docientos = 0;
                arreglo.quinientos = 0;
                arreglo.mil = 0;
                arreglo.total = 0;
                $.cargarHistorial(arreglo);
            });


        });


        var total = {};
        total.temporal = 0;
        $.sumaMonedas = function (cantidad) {
            arreglo.total = arreglo.total + parseFloat(cantidad.toString());
            total.temporal = total.temporal + parseFloat(cantidad.toString());
            $("#lblTotal").text(total.temporal)
        };

        $.ingresarAlcancia = function (objeto) {
            var objeto_modelo = {};
            objeto_modelo.objeto = objeto;
            objeto_modelo = JSON.stringify(objeto_modelo);
            $.ajax({
                type: "POST",
                url: "index.aspx/IngresarAlcancia",
                dataType: "json",
                data: objeto_modelo,
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    localStorage.setItem("objetoStorage", JSON.stringify(response.d));
                    $.cargarHistorial(response.d);
                },
                error: function (response) {
                    alert(response.responseText);
                }
            })
        };

        $.validarPalindromo = function (txt_texto_ingresado) {
            var objeto = {};
            objeto.txt_texto_ingresado = txt_texto_ingresado;
            objeto = JSON.stringify(objeto);
            $.ajax({
                type: "POST",
                url: "index.aspx/ValidarPalindromo",
                dataType: "json",
                data: objeto,
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    alert("(" + $("#txt_texto_ingresado").val() + ") " + response.d);
                    $("#txt_texto_ingresado").val("");
                },
                error: function (response) {
                    alert(response.responseText);
                }
            })
        };

        $.cargarHistorial = function (response) {
            $("#lbl_cincuenta").text(response.cincuenta.toString());
            $("#lbl_total_cincuenta").text(response.cincuenta * 50);
            $("#lbl_cien").text(response.cien.toString());
            $("#lbl_total_cien").text(response.cien * 100);
            $("#lbl_docientos").text(response.docientos.toString());
            $("#lbl_total_docientos").text(response.docientos * 200);
            $("#lbl_quinientos").text(response.quinientos.toString());
            $("#lbl_total_quinientos").text(response.quinientos * 500);
            $("#lbl_mil").text(response.mil.toString());
            $("#lbl_total_mil").text(response.mil * 1000);
            $("#_lblTotal").text(response.total.toString());
            $("#lblTotal").text("0");
            total.temporal = 0;
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <header class="nav-header-sombra">
            <nav id="mainNav" class="navbar navbar-toggleable-md nav-tabs">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-9 col-md-9 col-12" id="navBar">
                            <ul class="navbar-nav text-uppercase nav" role="tablist">
                                <li class="nav-item">
                                    <a href="#alcancia" role="tab" class="nav-link" data-toggle="tab">Alcancía</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#palindromo" role="tab" class="nav-link" data-toggle="tab">Palíndromo</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </header>
        <section id="body" class="section-body">
            <div class="container">
                <div class="row row-general-top tab-content">
                    <div class="col-12 tab-pane fade active in" id="alcancia">
                        <div class="row">
                            <div class="col-12 col-md-12 col-sm-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index.aspx">Prueba</a></li>
                                    <li class="breadcrumb-item active">Alcancía</li>
                                </ol>
                            </div>
                            <div class="col-12 col-lg-5 col-md-5 col-sm-12">
                                <div class="row row-general-top">
                                    <div class="col-lg-12 col-md-12  col-sm-12 col-12">
                                        <b>Valor de la moneda que va a ingresar:</b>
                                        <p>
                                            <button id="btnCincuenta" type="button" class="btn btn-danger col-12 col-lg-2" value="50">$ 50</button>
                                            <button id="btnCien" type="button" class="btn btn-primary col-12 col-lg-2" value="100">$ 100</button>
                                            <button id="btnDocientos" type="button" class="btn btn-success col-12 col-lg-2" value="200">$ 200</button>
                                            <button id="btnQuinientos" type="button" class="btn btn-info col-12 col-lg-2" value="500">$ 500</button>
                                            <button id="btnMil" type="button" class="btn btn-warning col-12 col-lg-3" value="1000">$ 1000</button>
                                        </p>
                                    </div>
                                    <div class="col-lg-12 col-md-12  col-sm-12 col-12">
                                        <div class="alert alert-warning">
                                            El valor a ingresar es de: <b>$</b><b><label id="lblTotal">0</label></b>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12  col-sm-12 col-12">
                                        <button id="btnIngresar" type="button" class="btn btn-block btn-secondary"><b>Ingresar</b></button>
                                    </div>
                                    <div class="col-lg-12 col-md-12  col-sm-12 col-12 row-general-top">
                                        <button id="btnLimpiar" type="button" class="btn btn-block btn-secondary"><b>Limpiar</b></button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-md-7 col-sm-12 col-lg-7">
                                <div class="row row-general-top">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header  card-info card-inverse">
                                                <h3>Historial Alcancia
                                                </h3>
                                            </div>
                                            <div class="card-block">
                                                <div class="table-responsive">
                                                    <table class="table table-sm table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th class="text-center">Moneda</th>
                                                                <th class="text-center">Cantidad Moneda</th>
                                                                <th class="text-center">Total Moneda</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <button type="button" class="btn btn-sm btn-block btn-danger" value="50">$ 50</button>
                                                                </td>
                                                                <td class="text-center">
                                                                    <label id="lbl_cincuenta"></label>
                                                                </td>
                                                                <td class="text-center">
                                                                    <label id="lbl_total_cincuenta"></label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <button type="button" class="btn btn-sm btn-block btn-primary" value="100">$ 100</button>
                                                                </td>
                                                                <td class="text-center">
                                                                    <label id="lbl_cien"></label>
                                                                </td>
                                                                <td class="text-center">
                                                                    <label id="lbl_total_cien"></label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <button type="button" class="btn btn-sm btn-block btn-success" value="200">$ 200</button>
                                                                </td>
                                                                <td class="text-center">
                                                                    <label id="lbl_docientos"></label>
                                                                </td>
                                                                <td class="text-center">
                                                                    <label id="lbl_total_docientos"></label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <button type="button" class="btn btn-sm btn-block btn-info" value="500">$ 500</button>
                                                                </td>
                                                                <td class="text-center">
                                                                    <label id="lbl_quinientos"></label>
                                                                </td>
                                                                <td class="text-center">
                                                                    <label id="lbl_total_quinientos"></label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <button type="button" class="btn btn-sm btn-block btn-warning" value="1000">$ 1000</button>
                                                                </td>
                                                                <td class="text-center">
                                                                    <label id="lbl_mil"></label>
                                                                </td>
                                                                <td class="text-center">
                                                                    <label id="lbl_total_mil"></label>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="card-footer card-info card-inverse">
                                                <h3>Total: $<label id="_lblTotal" runat="server">0</label></h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 tab-pane fade" id="palindromo">
                        <div class="row row-general-top">
                            <div class="col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index.aspx">Prueba</a></li>
                                    <li class="breadcrumb-item active">Palíndromo</li>
                                </ol>
                            </div>
                            <div class="col-12 col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group input-group">
                                    <input id="txt_texto_ingresado" class="form-control" runat="server" placeholder="Ingrese texto..." />
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-info" id="btn_validar" runat="server">Validar</button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <footer id="footer">
            <div class="footer-below">
                <div class="container">
                    <div class="row">
                        <div id="footer-text" class="col-lg-12 col-sm-12 col-md-12 col-xs-12 text-left">
                            Wilmer David Mancera
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </form>
</body>
</html>

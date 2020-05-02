DROP PROCEDURE VID_SP_FEI_Boleta_E;
CREATE PROCEDURE VID_SP_FEI_Boleta_E
(
	 IN DocEntry	Integer
	,IN TipoDoc		VarChar(10)
	,IN ObjType		VarChar(10)
)
LANGUAGE SqlScript
AS
BEGIN
	SELECT --IdDoc
		T0."DocDate"														"FchEmis"
		,T0."DocDueDate"													"FchVenc"
		,:TipoDoc															"TipoDTE"
		,T0."FolioNum"														"Folio"
		,TO_VARCHAR(T0."IndServicio")										"IndServicio"
		--Campos comentados al no estar dentro den JSON
		--,0.0																"MntBruto"
		--,0.0																"MntCancel"
		--,0.0																"SaldoInsol"
		--,T0."FmaPago"														"FmaPago"
		--Activo Fijo
		--,T0."TpoTranCompra"													"TpoTranCompra"
		--,T0."TpoTranVenta"													"TpoTranVenta"
		--Emisor
		,T0."SlpName"														"CdgVendedor"
		,UPPER(T0."TaxIdNum")												"RUTEmisor"
		,T0."RazonSocial"													"RznSocial"
		,T0."GiroEmis"														"GiroEmis"
		,T0."Sucursal"														"Sucursal"
		,T0."TelefenoRecep"													"Telefono"
		,T0."CdgSIISucur"													"CdgSIISucur"
		--Comentado por no existir dentro del JSON
		--,T0."SucursalAF"													"SucursalAF"
		--Receptor
		,T0."CityB"															"CiudadPostal"
		,T0."CityS"															"CiudadRecep"
		,T0."CountyB"														"CmnaPostal"
		,T0."CountyS"														"CmnaRecep"
		,T0."Contacto"														"Contacto"
		--Correo electrónico se debe informar dentro del nodo Extra bajo el alias Email
		--en vez de CorreoRecep
		--,T0."E_Mail"														"CorreoRecep"
		,T0."E_Mail"														"Email"
		,T0."StreetB"														"DirPostal"
		,T0."StreetS"														"DirRecep"
		--Comentado por no existir dentro del JSON
		--******Conversar con Daniel (enviar campo giro)**********************
		--***No se debe enviar
		--,T0."Giro"															"GiroRecep"
		,UPPER(T0."LicTradNum")												"RUTRecep"
		,T0."CardName"														"RznSocRecep"
		--Totales
		--Comentado por no existir dentro del JSON
		--,0																	"CredEC"
		,T0."Total_Impuesto"												"IVA"
		--Comentados por no existir dentro del JSON
		--,0.0																"IVANoRet"
		--,0.0																"IVAProp"
		--,0.0																"IVATerc"
		--,0.0																"MntBase"
		,T0."Total_Exento"													"MntExe"
		--Comentado por no existir dentro del JSON
		--,0.0																"MntMargenCom"
		,T0."Total_Afecto"													"MntNeto"
		,T0."DocTotal"														"MntTotal"
		,0.0																"MontoNF"
		--Comentado por no existir dentro del JSON
		--,0.0																"MontoPeriodo"
		,0.0																"SaldoAnterior"
		--Comentado por no existir dentro del JSON
		--,T0."VatPercent"													"TasaIVA"
		,0.0																"VlrPagar"
		--FolioInterno
		,T0."COMP"															"COMP"
		/*No existe MntDescuento dentro del JSON, se debe informar dentro del
		siguiente nodo:
		"DscRcgGlobal": [
		  {
			"NroLinDR": 0,
			"TpoMov": "string",
			"GlosaDR": "string",
			"TpoValor": "string",
			"ValorDR": 0,
			"ValorDROtrMnda": 0,
			"IndExeDR": 0
		  }
		],
		*/
		--,T0."DiscSum"														"MntDescuento"
		--Comentados por no existir dentro del JSON
		--,IFNULL(T0."OtraMoneda",0.0)										"OtraMoneda"
		--,IFNULL((SELECT SUM("MontoImptoAdic") 
		--           FROM VID_VW_FE_OINV_D
		--		  WHERE "DocEntry" = T0."DocEntry"
		--            AND "ObjType" = T0."ObjType"),0.0)						"MntImpAdic"
		--,T0."MntGlobal"														"MntGlobal"
	FROM VID_VW_FEI_OINV_E		T0
	WHERE 1 = 1
		AND T0."DocEntry" = :DocEntry
		AND T0."ObjType" = :ObjType;
END;
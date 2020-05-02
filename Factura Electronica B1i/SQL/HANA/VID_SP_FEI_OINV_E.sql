--DROP PROCEDURE VID_SP_FEI_OINV_E;
CREATE PROCEDURE VID_SP_FEI_OINV_E
(
     IN DocEntry	Integer
    ,IN TipoDoc		VarChar(10)
    ,IN ObjType		VarChar(10)
)
LANGUAGE SqlScript
AS
BEGIN
	SELECT 
		--IdDoc
		 T0."DocDate"														"FchEmis"
		,T0."DocDueDate"													"FchVenc"
		,:TipoDoc															"TipoDTE"
		,T0."FolioNum"														"Folio"
		,'0'																"IndServicio"
		,0.0																"MntBruto"
		,0.0																"MntCancel"
		,0.0																"SaldoInsol"
		,T0."FmaPago"														"FmaPago"
		--Emisor
		,T0."SlpName"														"CdgVendedor"
		,T0."TaxIdNum"														"RUTEmisor"
		--Se cambia el alias a RznSoc en base a lo especificado en JSON:
		,T0."RazonSocial"													"RznSoc"
		--,T0."RazonSocial"													"RznSocial"
		,T0."GiroEmis"														"GiroEmis"
		,T0."Sucursal"														"Sucursal"
		,T0."TelefenoRecep"													"Telefono"
		--Receptor
		,T0."CityB"															"CiudadPostal"
		,T0."CityS"															"CiudadRecep"
		,T0."CountyB"														"CmnaPostal"
		,T0."CountyS"														"CmnaRecep"
		,T0."Contacto"														"Contacto"
		,T0."E_Mail"														"CorreoRecep"
		,T0."StreetB"														"DirPostal"
		,T0."StreetS"														"DirRecep"
		,T0."Giro"															"GiroRecep"
		,T0."LicTradNum"													"RUTRecep"
		,T0."CardName"														"RznSocRecep"
		--Totales
		,0																	"CredEC"
		,T0."Total_Impuesto"												"IVA"
		,0.0																"IVANoRet"
		--Se comentan estos campos por que no aparecen dentro del JSON
		--,0.0																"IVAProp"
		--,0.0																"IVATerc"
		,0.0																"MntBase"
		,T0."Total_Exento"													"MntExe"
		,0.0																"MntMargenCom"
		,T0."Total_Afecto"													"MntNeto"
		,T0."DocTotal"														"MntTotal"
		,0.0																"MontoNF"
		--Se comenta este campo por que no aparece dentro del JSON
		--,0.0																"MontoPeriodo"
		,0.0																"SaldoAnterior"
		,T0."VatPercent"													"TasaIVA"
		,0.0																"VlrPagar"
		,T0."COMP"															"COMP"
		--**************Conversar con Daniel**********************
		--generar nuevo SP para DscRcgGlobal
		--Dentro del JSON no existe el valor MntDescuento, en su defecto para enviar
		--descuentos aparece el siguiente nodo:
		--,T0."DiscSum"														"MntDescuento"
		/*
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
		],*/
		--Dentro del JSON no existe el valor MntImpAdic, en su defecto para enviar los impuestos
		--adicionales se detalla el nodo ImptoReten
		--,IFNULL((SELECT SUM("MontoImptoAdic") 
		--           FROM VID_VW_FE_OINV_D
		--		  WHERE "DocEntry" = T0."DocEntry"
		--            AND "ObjType" = T0."ObjType"),0.0)						"MntImpAdic"
		/*
		--generar nuevo SP para ImptoReten <<<<<<-------
		"ImptoReten": [
          {
            "TipoImp": "codigo SII",
            "TasaImp": 0,
            "MontoImp": 0
          }
        ],*/
		--Si bien estos campos forman parte de exportaciones, dentro del JSON aparece que son 
		--incluidos dentro del nodo Aduana el cual se encuentra dentro del nodo Transporte
		--Exportacion
		,T0."MntFlete"														"MntFlete"
		,T0."MntSeguro"														"MntSeguro"
		
		--******Conversar con Daniel**********************
		--Se comenta este campo por que no aparece dentro del JSON
		--no enviar <<<-----
		--,T0."MntGlobal"														"MntGlobal"
		--Patente se encuentra dentro del nodo Transporte
		,T0."Patente"														"Patente"
		,T0."CodClauVenta"													"CodClauVenta"
		,T0."CodModVenta"													"CodModVenta"
		--******Conversar con Daniel**********************
		--Se comentan estos campos por que no aparecen dentro del JSON
		--,T0."DocCur"														"TipoMoneda"
		,T0."FmaPagExp"													"FmaPagExp"
		,T0."CodViaTransp"													"CodViaTransp"
		,T0."CodPtoEmbarque"												"CodPtoEmbarque"
		,T0."CodPtoDesemb"													"CodPtoDesemb"
		,T0."CodUnidMedTara"												"CodUnidMedTara"
		,T0."CodUnidPesoBruto"												"CodUnidPesoBruto"
		,T0."CodUnidPesoNeto"												"CodUnidPesoNeto"
		--******Conversar con Daniel**********************
		--Dentro del JSON se genera el siguiente nodo para informar los bultos:
		--"TipoBultos": [
        --    {
        --      "CodTpoBultos": 0,
        --      "CantBultos": 0,
        --      "Marcas": "string",
        --      "IdContainer": "string",
        --      "Sello": "string",
        --      "EmisorSello": "string"
        --    }
        --  ],
		--,T0."TotBultos"														"TotBultos"
		,T0."CodPaisRecep"													"CodPaisRecep"
        ,T0."CodPaisDestin"													"CodPaisDestin"
		--Otra Moneda Exportacion, nodo OtraMoneda
		,'CLP'																"TpoMoneda"
		,CAST(IFNULL(T0."DocRate", 0.0) AS FLOAT)							"TpoCambio"
		,IFNULL(T0."OtraMoneda",0.0)										"MntExeOtrMnda"
		,IFNULL(T0."OtraMoneda",0.0)										"MntTotOtrMnda"
		--Activo Fijo, estos valores se encuentran dentro del nodo IdDoc
		,T0."TpoTranCompra"													"TpoTranCompra"
		,T0."TpoTranVenta"													"TpoTranVenta"
		--Estos valores se encuentran dentro del nodo IdDoc
		,T0."CdgSIISucur"													"CdgSIISucur"
		,T0."SucursalAF"													"Sucursal"
		/* Los 3 acmpos a continuación deben ser generados dentro del nodo MntPAgos:
		"MntPagos": [
          {
            "FchPago": "2019-08-23T13:34:47.054Z",
            "MntPago": 0,
            "GlosaPagos": "string"
          }
        ],
		*/
		,T0."FchPago"														"FchPago"
		,T0."MntPago"														"MntPago"
		,T0."GlosaPagos"													"GlosaPagos"
		--Campos Extras, deben ir dentro del nodo Extra y el JSON soporta hasta el Extra20
		,T1."CAB_EXTRA1"													"Extra1"
		,T1."CAB_EXTRA2"													"Extra2"
		
		
	FROM VID_VW_FEI_OINV_E		T0
	JOIN VID_VW_FEI_OINV_E_EXTRA T1 ON T0."DocEntry" = T1."DocEntry"
								  AND T0."ObjType"  = T1."ObjType"
	WHERE 1 = 1
		AND T0."DocEntry" = :DocEntry
		AND T0."ObjType" = :ObjType;
END;
DROP PROCEDURE VID_SP_FEI_OINV_D;
CREATE PROCEDURE VID_SP_FEI_OINV_D
(
     IN DocEntry		Integer
    ,IN TipoDoc			VarChar(10)
    ,IN ObjType			VarChar(10)
)
LANGUAGE SqlScript
AS
BEGIN
	SELECT
		ROW_NUMBER() OVER(ORDER BY T0."LineaOrden", T0."LineaOrden2")							"NroLinDet" 
		,T0."DiscSum"																			"DescuentoMonto"
		,T0."DiscPrcnt"																			"DescuentoPct"
		,T0."Indicador_Exento"																	"IndExe"
		,T0."LineTotal"																			"MontoItem"
		,T0."Dscription"																		"NmbItem"
		,T0."Price"																				"PrcItem"
		,0.0																					"PrcRef"
		,T0."Quantity"																			"QtyItem"
		,0.0																					"QtyRef"
		,0.0																					"RecargoMonto"
		,0.0																					"RecargoPct"
		,T0."DET_UNIDAD_MEDIDA"																	"UnmdItem"
		--******Conversar con Daniel (se espera uno por linea?) **********************
		--El código del articulo debe ir dentro del nodo CdgItem de esta manera:
		--Se deben agregar el valor TpoCodigo
		/*
		"CdgItem": [
          {
            "TpoCodigo": "string",
            "VlrCodigo": "string"
          }
        ],
		*/
		,T0."ItemCode"																			"VlrCodigo"
		,T0."Dscription_Larga"																	"DscItem"
		
		,T0."CodImpAdic"																		"CodImpAdic"
		--Campo MntImpAdic comentado por que no existe dentro del JSON
		--,T0."MontoImptoAdic"																	"MntImpAdic"
		--Campos extra deben ir dentro del noto Extra, soporta hasta el Extra20
		,IFNULL(T1."DET_EXTRA1", '')															"Extra1"
		,IFNULL(T1."DET_EXTRA2", '')															"Extra2"
		,IfNULL(T1."DET_EXTRA3", '')															"Extra3"
		,IFNULL(T1."DET_EXTRA4", '')															"Extra4"
		,IFNULL(T1."DET_EXTRA5", '')															"Extra5"
	FROM	  VID_VW_FEI_OINV_D		 T0
	LEFT JOIN VID_VW_FEI_OINV_D_EXTRA T1 ON T0."DocEntry"    = T1."DocEntry"
									   AND T0."ObjType"     = T1."ObjType"
									   AND T0."LineaOrden"  = T1."LineaOrden"
									   AND T0."LineaOrden2" = T1."LineaOrden2"
	WHERE 1 = 1
		AND T0."DocEntry" = :DocEntry
		AND T0."ObjType" = :ObjType;
END;
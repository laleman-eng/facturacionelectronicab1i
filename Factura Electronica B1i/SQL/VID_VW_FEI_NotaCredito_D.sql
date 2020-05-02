DROP VIEW VID_VW_FEI_NOTACREDITO_D; 
CREATE VIEW VID_VW_FEI_NOTACREDITO_D 
AS 
SELECT
	 T0."FolioNum" "FolioNum" ,
	 CASE WHEN T1."VatSum" = 0 	THEN 1 
		ELSE 2 
		END "Indicador_Exento" ,
	 CASE T0."DocType" WHEN 'S' THEN 'Servicio' 
	ELSE 
	LEFT(T1."ItemCode",50) 
	END "ItemCode" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(T1."Dscription",80)) "Dscription" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(T1."Dscription",250)) "Dscription_Larga" ,
	LEFT(IFNULL(T1."unitMsr",''),4) "DET_UNIDAD_MEDIDA" ,
	 CASE WHEN T0."DocType" = 'S' THEN 1 
	 ELSE T1."Quantity" 
	 END "Quantity" ,
	 CASE WHEN 	RIGHT(N0."BeginStr",3) = '112' 	THEN TO_VARCHAR(ROUND(T1."PriceBefDi",4)) 
	ELSE CASE IFNULL(T1."Currency",	'CLP') 
	WHEN 'CLP' THEN T1."PriceBefDi" 
	WHEN '$' THEN T1."PriceBefDi" 
	ELSE ROUND(T1."PriceBefDi" * T1."Rate",	4) 
	END 
	END "Price" ,
	 CASE WHEN T1."DiscPrcnt" >= 0.0 THEN T1."DiscPrcnt" 
	ELSE 0.0 
	END "DiscPrcnt" ,
	 CASE WHEN IFNULL(T1."DiscPrcnt",0.0) <= 0.0 
	THEN 0.0 
	ELSE CASE WHEN RIGHT(N0."BeginStr",	3) = '112' 
	THEN TO_VARCHAR(ROUND(T1."PriceBefDi" * CASE WHEN T0."DocType" = 'S'THEN 1 
							ELSE T1."Quantity" 
							END - CASE T0."CurSource" WHEN 'L'	THEN ROUND(T1."LineTotal",	0) 
								  WHEN 'S' THEN T1."TotalSumSy" 
								  WHEN 'C'	THEN T1."TotalFrgn" 
								  END,4)) 
					ELSE ROUND((CASE WHEN IFNULL(T1."Currency",	'CLP') IN ('CLP','$')THEN T1."PriceBefDi" 
				ELSE ROUND(T1."PriceBefDi" * T1."Rate",2)
				END) * CASE WHEN T0."DocType" = 'S'	THEN 1 
					   ELSE T1."Quantity" 
						END,0.0) - T1."LineTotal" 
					END 
					END "DiscSum" ,
	 CASE WHEN IFNULL(T1."DiscPrcnt",0.0) >= 0.0 THEN 0.0 
	 ELSE CASE WHEN RIGHT(N0."BeginStr",3) = '112'THEN TO_VARCHAR(ROUND(T1."PriceBefDi" * CASE WHEN T0."DocType" = 'S'	THEN 1 
																						  ELSE T1."Quantity" 
																						  END - CASE T0."CurSource" WHEN 'L'THEN ROUND(T1."LineTotal",0) WHEN 'S'
																								THEN T1."TotalSumSy" WHEN 'C' THEN T1."TotalFrgn"
																								END,4)) 
		ELSE T1."LineTotal" - ROUND((CASE WHEN IFNULL(T1."Currency",'CLP') IN ('CLP','$') THEN T1."PriceBefDi" 
		ELSE ROUND(T1."PriceBefDi" * T1."Rate",	2) 	END) * CASE WHEN T0."DocType" = 'S' THEN 1 
															ELSE T1."Quantity" 
															END,0.0) 
															END 
	 END "RecargoMonto" ,
	 CASE WHEN 	RIGHT(N0."BeginStr",3) = '112' 
	 THEN CASE T0."CurSource" 
	 WHEN 'L' 	THEN ROUND(T1."LineTotal",0.0)
	 WHEN 'S' 	THEN T1."TotalSumSy" 
	 WHEN 'C' 	THEN T1."TotalFrgn" 
	 END 
	 ELSE ROUND(T1."LineTotal",	0) 
	 END "LineTotal" ,
	 IFNULL(F0."U_CodImpto",'') "CodImpAdic" ,
	 IFNULL(F0."U_CodImpto",'') "CodImptoAdic" ,
	 LEFT(IFNULL(U0."U_NAME",''),30) "Usuario" ,
	 IFNULL(T4."TaxSum",0.0) "MontoImptoAdic" ,
	 IFNULL(F0."U_Porc",0.0) "PorcImptoAdic" ,
	 T1."Rate" "Rate" ,
	 T1."Currency" "Currency" ,
	 T1."VisOrder" "LineaOrden" ,
	 1 "LineaOrden2" ,
	 T0."ObjType" "ObjType" ,
	 T0."DocEntry" "DocEntry" ,
	 T1."U_TipoDTELF" "TpoDocLiq" ,
	 CAST(T1."U_FolioLiqF" AS VARCHAR(20)) "FolioRefLF" 
FROM "ORIN" T0 
JOIN "RIN1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "OUSR" U0 ON U0."INTERNAL_K"= T0."UserSign" 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
 AND N0."ObjectCode"= T0."ObjType" 
LEFT JOIN "RIN4" T4 ON T4."DocEntry" = T0."DocEntry" 
	AND T4."LineNum" = T1."LineNum" 
	AND T4."StaCode" NOT IN ('IVA',	'IVA_EXE') 
LEFT JOIN "@VID_FEIMPADIC" F0 ON F0."Code" = T4."StaCode" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND IFNULL(T0."U_TipoFac",'') <> 'GL' 
AND UPPER(LEFT(N0."BeginStr",1)) = 'E' 		

UNION ALL

SELECT
	 T0."FolioNum" "FolioNum" ,
	 CASE WHEN T0."VatSum" = 0 
					THEN 1 
					ELSE 2 
					END "Indicador_Exento" ,
	 'Glosa' "ItemCode" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(T0."U_GLOSA",80)) "Dscription" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(T0."U_GLOSA",250)) "Dscription_Larga" ,
	 '' "DET_UNIDAD_MEDIDA" ,
	 1 "Quantity" ,
	 ROUND(T0."DocTotal" - T0."VatSum",	0) "Price" ,
	 0.0 "DiscPrcnt" ,
	 0.0 "DiscSum" ,
	 0.0 "RecargoMonto" ,
	 ROUND(T0."DocTotal" - T0."VatSum",	0) "LineTotal" ,
	 '' "CodImpAdic" ,
	 '' "CodImptoAdic" ,
	 LEFT(IFNULL(U0."U_NAME",''),30) "Usuario" ,
	 0.0 "MontoImptoAdic" ,
	 0.0 "PorcImptoAdic" ,
	 0.0 "Rate" ,
	 '' "Currency" ,
	 1 "LineaOrden" ,
	 1 "LineaOrden2" ,
	 T0."ObjType" "ObjType" ,
	 T0."DocEntry" "DocEntry" ,
	 '' "TpoDocLiq" ,
	 '' "FolioRefLF" 
FROM "ORIN" T0 
JOIN "OUSR" U0 ON U0."INTERNAL_K"= T0."UserSign" 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND IFNULL(T0."U_TipoFac",'') = 'GL' 
AND UPPER(LEFT(N0."BeginStr",1)) = 'E'
 
UNION ALL

SELECT
	 T0."FolioNum" "FolioNum" ,
	 2 "Indicador_Exento" ,
	 'Texto' "ItemCode" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(CAST(T10."LineText" AS VARCHAR(254)),80)) "Dscription" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(CAST(T10."LineText" AS VARCHAR(254)),250)) "Dscription_Larga" ,
	 '' "DET_UNIDAD_MEDIDA" ,
	 1.0 "Quantity" ,
	 0.0 "Price" ,
	 0.0 "DiscPrcnt" ,
	 0.0 "DiscSum" ,
	 0.0 "RecargoMonto" ,
	 0.0 "LineTotal" ,
	 '' "CodImpAdic" ,
	 '' "CodImptoAdic" ,
	 LEFT(IFNULL(U0."U_NAME",''),30) "Usuario" ,
	 0.0 "MontoImptoAdic" ,
	 0.0 "PorcImptoAdic" ,
	 0.0 "Rate" ,
	 '' "Currency" ,
	 T10."AftLineNum" "LineaOrden" ,
	 2 "LineaOrden2" ,
	 T0."ObjType" "ObjType" ,
	 T0."DocEntry" "DocEntry" ,
	 '' "TpoDocLiq" ,
	 '' "FolioRefLF" 
FROM "ORIN" T0 
JOIN "RIN10" T10 ON T10."DocEntry" = T0."DocEntry" 
JOIN "OUSR" U0 ON U0."INTERNAL_K" = T0."UserSign" 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
AND N0."ObjectCode" = T0."ObjType" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND UPPER(LEFT(N0."BeginStr",1)) = 'E' 

UNION ALL

SELECT
	 T0."FolioNum" "FolioNum" ,
	 CASE WHEN T1."VatSum" = 0.0 
			THEN 1 
			ELSE 2 
			END "Indicador_Exento" ,
	 CASE T0."DocType" WHEN 'S' 
			THEN 'Servicio' 
			ELSE 
			LEFT(T1."ItemCode",50) 
			END "ItemCode" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(T1."Dscription",80)) "Dscription" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(T1."Dscription",250)) "Dscription_Larga" ,
	 LEFT(IFNULL(T1."unitMsr",''),4) "DET_UNIDAD_MEDIDA" ,
	 CASE WHEN T0."DocType" = 'S' 
			THEN 1 
			ELSE T1."Quantity" 
			END "Quantity" ,
	 CASE IFNULL(T1."Currency",'CLP') 
	 WHEN 'CLP' THEN T1."PriceBefDi" 
	 WHEN '$' 	THEN T1."PriceBefDi" 
	 ELSE ROUND(T1."PriceBefDi" * T1."Rate",4) 
	 END "Price" ,
	 CASE WHEN T1."DiscPrcnt" >= 0.0 
			THEN T1."DiscPrcnt" 
			ELSE 0.0 
			END "DiscPrcnt" ,
	 CASE WHEN IFNULL(T1."DiscPrcnt",0.0) <= 0.0 
	 THEN 0.0 
	 ELSE ROUND((CASE WHEN IFNULL(T1."Currency",'CLP') IN ('CLP','$') 
				 THEN T1."PriceBefDi" 
				ELSE ROUND(T1."PriceBefDi" * T1."Rate",2) 
				END) * CASE WHEN T0."DocType" = 'S' THEN 1 
				ELSE T1."Quantity" 
				END,0) - T1."LineTotal" 
			END "DiscSum" ,
	 CASE WHEN IFNULL(T1."DiscPrcnt",0.0) >= 0.0 
			THEN 0.0 
			ELSE T1."LineTotal" - ROUND((CASE WHEN IFNULL(T1."Currency",'CLP') IN ('CLP','$') 
										THEN T1."PriceBefDi" 
										ELSE ROUND(T1."PriceBefDi" * T1."Rate",	2) 	END) * CASE WHEN T0."DocType" = 'S' THEN 1 	
																							ELSE T1."Quantity" 			
																							END,0.0) 
		END "RecargoMonto" ,
	 ROUND(T1."LineTotal",0) "LineTotal" ,
	 IFNULL(F0."U_CodImpto",'') "CodImpAdic" ,
	 IFNULL(F0."U_CodImpto",'') "CodImptoAdic" ,
	 LEFT(IFNULL(U0."U_NAME",''),30) "Usuario" ,
	 IFNULL(T5."WTAmnt",0.0) "MontoImptoAdic" ,
	 IFNULL(F0."U_Porc",0.0) "PorcImptoAdic" ,
	 T1."Rate" "Rate" ,
	 T1."Currency" "Currency" ,
	 T1."VisOrder" "LineaOrden" ,
	 1 "LineaOrden2" ,
	 T0."ObjType" "ObjType" ,
	 T0."DocEntry" "DocEntry" ,
	 '' "TpoDocLiq" ,
	 '' "FolioRefLF" 
FROM "ORPC" T0 
JOIN "RPC1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "OUSR" U0 ON U0."INTERNAL_K"= T0."UserSign" 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
	AND N0."ObjectCode"= T0."ObjType" 
LEFT JOIN "RPC5" T5 ON T5."AbsEntry" = T0."DocEntry" 
LEFT JOIN "@VID_FEIMPADIC" F0 ON F0."Code" = T5."WTCode" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND UPPER(LEFT(N0."BeginStr",1)) = 'E' 

UNION ALL 

SELECT
	 T0."FolioNum" "FolioNum" ,
	 2 "Indicador_Exento" ,
	 'Texto' "ItemCode" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(CAST(T10."LineText" AS VARCHAR(254)),80)) "Dscription" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(CAST(T10."LineText" AS VARCHAR(254)),250)) "Dscription_Larga" ,
	 '' "DET_UNIDAD_MEDIDA" ,
	 1.0 "Quantity" ,
	 0.0 "Price" ,
	 0.0 "DiscPrcnt" ,
	 0.0 "DiscSum" ,
	 0.0 "RecargoMonto" ,
	 0.0 "LineTotal" ,
	 '' "CodImpAdic" ,
	 '' "CodImptoAdic" ,
	 LEFT(IFNULL(U0."U_NAME",''),30) "Usuario" ,
	 0.0 "MontoImptoAdic" ,
	 0.0 "PorcImptoAdic" ,
	 0.0 "Rate" ,
	 '' "Currency" ,
	 T10."AftLineNum" "LineaOrden" ,
	 2 "LineaOrden2" ,
	 T0."ObjType" "ObjType" ,
	 T0."DocEntry" "DocEntry" ,
	 '' "TpoDocLiq" ,
	 '' "FolioRefLF" 
FROM "ORPC" T0 
JOIN "RPC10" T10 ON T10."DocEntry" = T0."DocEntry" 
JOIN "OUSR" U0 ON U0."INTERNAL_K" = T0."UserSign" 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
AND N0."ObjectCode" = T0."ObjType" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND UPPER(LEFT(N0."BeginStr",1)) = 'E'
DROP VIEW "VID_VW_FEI_52_E"; 
CREATE VIEW "VID_VW_FEI_52_E" 
AS 
SELECT
	 T0."FolioNum" "FolioNum" ,
	 REPLACE(C0."LicTradNum",'.','') "LicTradNum" ,
	 TO_VARCHAR(T0."TaxDate",'yyyy-MM-dd') "DocDate" ,
	 TO_VARCHAR(T0."DocDueDate",'yyyy-MM-dd') "DocDueDate" ,
	 IFNULL(T0."U_TipDespacho", '0') "TipoDespacho" ,
	 IFNULL(T0."U_Traslado", '0') "IndTraslado" ,
	 CASE WHEN "U_Traslado" = 5 
THEN 0 
ELSE ROUND(T0."DocTotal", 0.0) 
END "DocTotal" ,
	 CASE WHEN "U_Traslado" = 5 
THEN 0 
ELSE ROUND(IFNULL((SELECT SUM("TaxSum") FROM "WTR4" WHERE 1 = 1 AND "DocEntry" = T0."DocEntry"	AND "StaCode" = 'IVA'),	 0.0),	 0) 
END "Total_Impuesto" ,
	 CASE WHEN "U_Traslado" = 5 
THEN 0 
ELSE ROUND(T0."DocTotal" - T0."VatSum",	 0) 
END "Total_Afecto" ,
	 CASE WHEN "U_Traslado" = 5 
	 THEN 0 
ELSE ROUND(IFNULL((SELECT SUM("BaseSum") FROM "WTR4" WHERE 1 = 1 AND "DocEntry" = T0."DocEntry" AND "StaCode" IN ('IVA_Exe')), 0), 0) 
END "Total_Exento" ,
	 '' "Codigo_Retencion" ,
	 0 "Tasa_Retencion" ,
	 0 "Total_Retencion" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(T0."CardName",	 100)) "CardName" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(B0."Street", '') || ' ' || IFNULL(B0."StreetNo", ''), 60)) "StreetB" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(B0."City", ''),	 15)) "CityB" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(B0."County", ''), 20)) "CountyB" ,LEFT(IFNULL(C0."E_Mail", ''),	 80) "E_Mail" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(CAST(C0."Notes" AS varchar(40)), 'Sin Giro Definido'), 40)) "Giro" ,
	 CASE WHEN T0."VatSum" > 0 THEN CASE WHEN T0."VatPercent" <> 0 THEN T0."VatPercent" 
									ELSE (SELECT "Rate" FROM "OSTC" WHERE "Code" = 'IVA') 
									END 
	ELSE 0.0 
	END "VatPercent" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(S0."Street",'') || ' ' || IFNULL(B0."StreetNo", ''), 60)) "StreetS" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(S0."County", ''), 20)) "CountyS" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(S0."City", ''),	 15)) "CityS" ,
	 LEFT(IFNULL(V0."SlpName", ''), 100) "SlpName" ,
	 LEFT(IFNULL(C0."Phone1", ''), 30) "Phone1" ,
	 T0."DocCur" "DocCur" ,
	 ROUND(T0."DocRate", 4) "DocRate" ,
	 LEFT(IFNULL(U0."U_NAME",''), 30) "Usuario" ,
	 IFNULL(T0."Comments", '') "Comments" ,
	 ROUND(T0."DiscSum" + T0."DpmAmnt",	 0) "DiscSum" ,
	 '' "Condicion_Pago" ,
	 IFNULL(T0."U_FETimbre", '') "XMLTED" ,
	 T0."ObjType" "ObjType" ,
	 T0."DocEntry" "DocEntry" ,
	 CAST(T0."ObjType" || CAST(T0."DocEntry" AS varchar) AS INT) "COMP" ,
	 IFNULL(A0."Phone1", '') "TelefenoRecep" ,
	 REPLACE(IFNULL(A0."TaxIdNum",''),'.','') "TaxIdNum" ,
	 IFNULL(A0."CompnyName", '') "RazonSocial" ,
	 IFNULL(A1."GlblLocNum",'') "GiroEmis" ,
	 'Central' "Sucursal" ,
	 CAST('' AS VARCHAR(100)) "Contacto" ,
	 0.0 "MntGlobal" ,
	 IFNULL(T0."U_TpoTranCpra", '') "TpoTranCompra" ,
	 IFNULL(T0."U_TpoTranVta", '') "TpoTranVenta" ,
	 IFNULL(CAST(T0."U_CdgSiiSuc" AS VARCHAR(9)), '0') "CdgSIISucur" ,
	 IFNULL(T0."U_FESucursal", '') "SucursalAF" ,
	 '' "FchPago" ,
	 0 "MntPago" ,
	 '' "GlosaPagos" 
FROM "OWTR" T0 
JOIN "OCRD" C0 ON C0."CardCode" = T0."CardCode" 
JOIN "OUSR" U0 ON U0."INTERNAL_K" = T0."UserSign" 
JOIN "OWHS" D0 ON D0."WhsCode" = T0."Filler" 
JOIN "OWHS" H0 ON H0."WhsCode" = T0."ToWhsCode" 
JOIN "NNM1" N1 ON N1."Series" = T0."Series" 
	AND N1."ObjectCode" = T0."ObjType" 
LEFT JOIN "OSLP" V0 ON V0."SlpCode" = T0."SlpCode" 
LEFT JOIN "CRD1" B0 ON B0."CardCode" = C0."CardCode" 
	AND B0."Address" = C0."BillToDef" 
	AND B0."AdresType" = 'B' 
LEFT JOIN "CRD1" S0 ON S0."CardCode" = C0."CardCode" 
	AND S0."Address" = C0."ShipToDef" 
	AND S0."AdresType" = 'S' ,
	 "OADM" A0,
	 "ADM1" A1 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
 
AND UPPER( LEFT(N1."BeginStr",1)) = 'E' 

UNION ALL 

SELECT
	 T0."FolioNum" "FolioNum" ,
	 REPLACE(T0."LicTradNum", '.', '') "LicTradNum" ,
	 TO_VARCHAR(T0."TaxDate", 'yyyy-MM-dd') "DocDate" ,
	 TO_VARCHAR(T0."DocDueDate",'yyyy-MM-dd') "DocDueDate" ,
	 IFNULL(T0."U_TipDespacho", '0') "TipoDespacho" ,
	 IFNULL(T0."U_Traslado", '0') "IndTraslado" ,
	 ROUND(T0."DocTotal", 0.0) "DocTotal" ,
	 ROUND(IFNULL((SELECT SUM("TaxSum") 
			FROM "RPD4" 
			WHERE 1 = 1 
			AND "DocEntry" = T0."DocEntry" 
			AND "StaCode" = 'IVA'), 0.0), 0) "Total_Impuesto" ,
	 ROUND(T0."DocTotal" - T0."VatSum", 0) "Total_Afecto" ,
	 ROUND(IFNULL((SELECT SUM("BaseSum") 
			FROM "RPD4" 
			WHERE 1 = 1 
			AND "DocEntry" = T0."DocEntry" 
			AND "StaCode" IN ('IVA_Exe')), 0.0), 0) "Total_Exento" ,
	 '' "Codigo_Retencion" ,
	 0 "Tasa_Retencion" ,
	 0 "Total_Retencion" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(T0."CardName", 100)) "CardName" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(T12."StreetB", '') || ' ' || IFNULL(T12."StreetNoB", ''), 60)) "StreetB" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(T12."CityB", ''), 15)) "CityB" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(T12."CountyB", ''), 20)) "CountyB" ,
	 LEFT(IFNULL(C0."E_Mail", ''), 80) "E_Mail" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(CAST(C0."Notes" AS VARCHAR(40)),'Sin Giro Definido'), 40)) "Giro" ,
	 CASE WHEN T0."VatSum" > 0
	 THEN CASE WHEN T0."VatPercent" <> 0 
	 THEN T0."VatPercent" 
	 ELSE (SELECT	 "Rate" FROM "OSTC" WHERE "Code" = 'IVA') 
	 END 
	 ELSE 0.0 
	 END "VatPercent" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(T12."StreetS", '') || ' ' || IFNULL(T12."StreetNoS", ''), 60)) "StreetS" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(T12."CountyS", ''), 20)) "CountyS" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(T12."CityS", ''), 15)) "CityS" ,
	 LEFT(IFNULL(V0."SlpName", ''), 100) "SlpName" ,
	 LEFT(IFNULL(C0."Phone1", ''), 30) "Phone1" ,
	 T0."DocCur" "DocCur" ,
	 ROUND(T0."DocRate", 4) "DocRate" , 
LEFT(IFNULL(U0."U_NAME", ''), 30) "Usuario" ,
	 IFNULL(T0."Comments", '') "Comments" ,
	 ROUND(T0."DiscSum" + T0."DpmAmnt", 0) "DiscSum" ,
	 IFNULL(T5."PymntGroup",'') "Condicion_Pago" ,
	 IFNULL(T0."U_FETimbre", '') "XMLTED" ,
	 T0."ObjType" "ObjType" ,
	 T0."DocEntry" "DocEntry" ,
	 CAST(T0."ObjType" || CAST(T0."DocEntry" AS varchar) AS INT) "COMP" ,
	 IFNULL(A0."Phone1", '') "TelefenoRecep" ,
	 REPLACE(IFNULL(A0."TaxIdNum",''), '.','') "TaxIdNum" ,
	 IFNULL(A0."CompnyName",'') "RazonSocial" ,
	 IFNULL(A1."GlblLocNum",'') "GiroEmis" ,
	 'Central' "Sucursal" 
	 , IFNULL(C1."Name", '') "Contacto" ,
	 0.0 "MntGlobal",
	 IFNULL(T0."U_TpoTranCpra", '') "TpoTranCompra" ,
	 IFNULL(T0."U_TpoTranVta", '') "TpoTranVenta" ,
	 IFNULL(CAST(T0."U_CdgSiiSuc" AS VARCHAR(9)), '0') "CdgSIISucur" ,
	 IFNULL(T0."U_FESucursal",'') "SucursalAF" ,
	 '' "FchPago" ,
	 0 "MntPago" ,
	 '' "GlosaPagos" 
FROM "ORPD" T0 
JOIN "RPD12" T12 ON T12."DocEntry" = T0."DocEntry" 
JOIN "OCRD" C0 ON C0."CardCode" = T0."CardCode" 
JOIN "OUSR" U0 ON U0."INTERNAL_K" = T0."UserSign" 
JOIN "NNM1" N1 ON N1."Series" = T0."Series" 
 AND N1."ObjectCode" = T0."ObjType" 
LEFT JOIN "OSLP" V0 ON V0."SlpCode" = T0."SlpCode" 
LEFT JOIN "OCTG" T5 ON T5."GroupNum" = T0."GroupNum" 
LEFT JOIN "OCPR" C1 ON C1."CntctCode" = T0."CntctCode" , "OADM" A0, "ADM1" A1 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND UPPER( LEFT(N1."BeginStr", 1)) = 'E' 

UNION ALL 

SELECT
	 T0."FolioNum" "FolioNum" ,
	 REPLACE(T0."LicTradNum", '.', '') "LicTradNum" ,
	 TO_VARCHAR(T0."TaxDate", 'yyyy-MM-dd') "DocDate" ,
	 TO_VARCHAR(T0."DocDueDate",'yyyy-MM-dd') "DocDueDate" ,
	 IFNULL(T0."U_TipDespacho", '0') "TipoDespacho" ,
	 IFNULL(T0."U_Traslado", '0') "IndTraslado" ,
	 ROUND(T0."DocTotal", 0.0) "DocTotal" ,
	 ROUND(IFNULL((SELECT SUM("TaxSum") 
			FROM "DLN4" 
			WHERE 1 = 1 
			AND "DocEntry" = T0."DocEntry" 
			AND "StaCode" = 'IVA'), 0.0), 0) "Total_Impuesto" ,
	 ROUND(IFNULL((SELECT SUM("BaseSum") 
			FROM "DLN4" 
			WHERE 1 = 1 
			AND "DocEntry" = T0."DocEntry" 
			AND "StaCode" IN ('IVA')), 0.0), 0) "Total_Afecto" ,
	 ROUND(IFNULL((SELECT SUM("BaseSum") 
			FROM "DLN4" 
			WHERE 1 = 1 
			AND "DocEntry" = T0."DocEntry" 
			AND "StaCode" IN ('IVA_Exe')), 0.0), 0) "Total_Exento" ,
	 '' "Codigo_Retencion" ,
	 0 "Tasa_Retencion" ,
	 0 "Total_Retencion" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(T0."CardName", 100)) "CardName" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(T12."StreetB", '') || ' ' || IFNULL(T12."StreetNoB", ''), 60)) "StreetB" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(T12."CityB", ''), 15)) "CityB" ,
	 VID_FN_FEI_LimpiaCaracteres(LEFT(IFNULL(T12."CountyB", ''), 20)) "CountyB" ,
	 LEFT(IFNULL(C0."E_Mail", ''), 80) "E_Mail" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(CAST(C0."Notes" AS VARCHAR(40)), 'Sin Giro Definido'),	 40)) "Giro" ,
	 CASE WHEN T0."VatSum" > 0 
THEN CASE WHEN T0."VatPercent" <> 0 
THEN T0."VatPercent" 
ELSE (SELECT "Rate" FROM "OSTC" WHERE "Code" = 'IVA') 
END 
ELSE 0.0 
END "VatPercent" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(T12."StreetS", '') || ' ' || IFNULL(T12."StreetNoS", ''), 60)) "StreetS" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(T12."CountyS", ''), 20)) "CountyS" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(T12."CityS", ''), 15)) "CityS" ,
	 LEFT(IFNULL(V0."SlpName", ''), 100) "SlpName" ,
	 LEFT(IFNULL(C0."Phone1", ''), 30) "Phone1" ,
	 T0."DocCur" "DocCur" ,
	 ROUND(T0."DocRate", 4) "DocRate" ,
	 LEFT(IFNULL(U0."U_NAME", ''), 30) "Usuario" ,
	 IFNULL(T0."Comments", '') "Comments" ,
	 ROUND(T0."DiscSum" + T0."DpmAmnt", 0) "DiscSum" ,
	 IFNULL(T5."PymntGroup", '') "Condicion_Pago" ,
	 IFNULL(T0."U_FETimbre", '') "XMLTED" ,
	 T0."ObjType" "ObjType" ,
	 T0."DocEntry" "DocEntry" ,
	 CAST(T0."ObjType" || CAST(T0."DocEntry" AS varchar) AS INT) "COMP" ,
	 IFNULL(A0."Phone1", '') "TelefenoRecep" ,
	 REPLACE(IFNULL(A0."TaxIdNum",''),'.','') "TaxIdNum" ,
	 IFNULL(A0."CompnyName", '') "RazonSocial" ,
	 IFNULL(A1."GlblLocNum", '') "GiroEmis" ,
	 'Central' "Sucursal" ,
	 IFNULL(C1."Name", '') "Contacto" ,
	 0.0 "MntGlobal" ,
	 IFNULL(T0."U_TpoTranCpra", '') "TpoTranCompra" ,
	 IFNULL(T0."U_TpoTranVta", '') "TpoTranVenta" ,
	 IFNULL(CAST(T0."U_CdgSiiSuc" AS VARCHAR(9)), '0') "CdgSIISucur" ,
	 IFNULL(T0."U_FESucursal", '') "SucursalAF" ,
	 TO_VARCHAR(T0."DocDueDate", 'yyyy-MM-dd') "FchPago" ,
	 T0."DocTotal" "MntPago" ,
	 T5."PymntGroup" "GlosaPagos" 
FROM "ODLN" T0 
JOIN "DLN12" T12 ON T12."DocEntry" = T0."DocEntry" 
JOIN "OCRD" C0 ON C0."CardCode" = T0."CardCode" 
JOIN "OUSR" U0 ON U0."INTERNAL_K" = T0."UserSign" 
JOIN "NNM1" N1 ON N1."Series" = T0."Series" 
AND N1."ObjectCode" = T0."ObjType" 
LEFT JOIN "OSLP" V0 ON V0."SlpCode" = T0."SlpCode" 
LEFT JOIN "OCTG" T5 ON T5."GroupNum" = T0."GroupNum" 
LEFT JOIN "OCPR" C1 ON C1."CntctCode" = T0."CntctCode" ,
	 "OADM" A0,
	 "ADM1" A1 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND UPPER(LEFT(N1."BeginStr", 1)) = 'E' 

UNION ALL 

SELECT
	 T0."FolioNum" "FolioNum" ,
	 REPLACE(C0."LicTradNum", '.', '') "LicTradNum" ,
	 TO_VARCHAR(T0."TaxDate",'yyyy-MM-dd') "DocDate" ,
	 TO_VARCHAR(T0."DocDueDate",'yyyy-MM-dd') "DocDueDate" ,
	 IFNULL(T0."U_TipDespacho", '0') "TipoDespacho" ,
	 IFNULL(T0."U_Traslado", '0') "IndTraslado" ,
	 CASE WHEN "U_Traslado" = 5 
	 THEN 0 
	 ELSE ROUND(T0."DocTotal", 0.0) 
	 END "DocTotal" ,
	 CASE WHEN "U_Traslado" = 5 
	 THEN 0 
ELSE ROUND(IFNULL((SELECT
	 SUM("TaxSum") 
			FROM "WTQ4" 
			WHERE 1 = 1 
			AND "DocEntry" = T0."DocEntry" 
			AND "StaCode" = 'IVA'),	 0.0),	 0) 
			END"Total_Impuesto" ,
	 CASE WHEN "U_Traslado" = 5 
	 THEN 0 
ELSE ROUND(T0."DocTotal" - T0."VatSum",	 0) 
END"Total_Afecto" ,
	 CASE WHEN "U_Traslado" = 5 
	 THEN 0 
	 ELSE ROUND(IFNULL((SELECT	 SUM("BaseSum") 
			FROM "WTQ4" 
			WHERE 1 = 1 
			AND "DocEntry" = T0."DocEntry" 
			AND "StaCode" IN ('IVA_Exe')), 0), 0) 
			END "Total_Exento" ,
	 '' "Codigo_Retencion" ,
	 0 "Tasa_Retencion" ,
	 0 "Total_Retencion" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(T0."CardName", 100)) "CardName" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(B0."Street", '') || ' ' || IFNULL(B0."StreetNo", ''), 60)) "StreetB" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(B0."City", ''), 15)) "CityB" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(B0."County", ''), 20)) "CountyB" ,
	 LEFT(IFNULL(C0."E_Mail", ''), 80) "E_Mail" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(CAST(C0."Notes" AS varchar(40)), 'Sin Giro Definido'),	 40)) "Giro" ,
	 CASE WHEN T0."VatSum" > 0 
	 THEN CASE WHEN T0."VatPercent" <> 0 
	 THEN T0."VatPercent" 
	 ELSE (SELECT	 "Rate" FROM "OSTC" WHERE "Code" = 'IVA') 
	 END 
	 ELSE 0.0 
	 END "VatPercent" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(S0."Street",'') || ' ' || IFNULL(B0."StreetNo", ''), 60)) "StreetS" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(S0."County", ''), 20)) "CountyS" ,
	 VID_FN_FEI_LimpiaCaracteres( LEFT(IFNULL(S0."City", ''), 15)) "CityS" ,
	 LEFT(IFNULL(V0."SlpName", ''), 100) "SlpName" ,
	 LEFT(IFNULL(C0."Phone1", ''), 30) "Phone1" ,
	 T0."DocCur" "DocCur" ,
	 ROUND(T0."DocRate", 4) "DocRate" ,
	 LEFT(IFNULL(U0."U_NAME", ''), 30) "Usuario" ,
	 IFNULL(T0."Comments", '') "Comments" ,
	 ROUND(T0."DiscSum" + T0."DpmAmnt",	 0) "DiscSum" , '' "Condicion_Pago" ,
	 IFNULL(T0."U_FETimbre", '') "XMLTED" ,
	 T0."ObjType" "ObjType" ,
	 T0."DocEntry" "DocEntry" ,
	 CAST( 	LEFT(T0."ObjType", 3) || CAST(T0."DocEntry" AS varchar) AS INT) "COMP" ,
	 IFNULL(A0."Phone1", '') "TelefenoRecep" ,
	 REPLACE(IFNULL(A0."TaxIdNum",''),'.','') "TaxIdNum" ,
	 IFNULL(A0."CompnyName", '') "RazonSocial" ,
	 IFNULL(A1."GlblLocNum", '') "GiroEmis" ,
	 'Central' "Sucursal" ,
	 CAST('' AS VARCHAR(100)) "Contacto" ,
	 0.0 "MntGlobal" ,
	 IFNULL(T0."U_TpoTranCpra", '') "TpoTranCompra" ,
	 IFNULL(T0."U_TpoTranVta", '') "TpoTranVenta" ,
	 IFNULL(CAST(T0."U_CdgSiiSuc" AS VARCHAR(9)), '0') "CdgSIISucur" ,
	 IFNULL(T0."U_FESucursal", '') "SucursalAF" ,
	 '' "FchPago" ,
	 0 "MntPago" ,
	 '' "GlosaPagos" 
FROM "OWTQ" T0 
JOIN "OCRD" C0 ON C0."CardCode" = T0."CardCode" 
JOIN "OUSR" U0 ON U0."INTERNAL_K" = T0."UserSign" 
JOIN "OWHS" D0 ON D0."WhsCode" = T0."Filler" 
JOIN "OWHS" H0 ON H0."WhsCode" = T0."ToWhsCode" 
JOIN "NNM1" N1 ON N1."Series" = T0."Series" 
AND N1."ObjectCode" = T0."ObjType" 
LEFT JOIN "OSLP" V0 ON V0."SlpCode" = T0."SlpCode" 
LEFT JOIN "CRD1" B0 ON B0."CardCode" = C0."CardCode" 
AND B0."Address" = C0."BillToDef" 
AND B0."AdresType" = 'B' 
LEFT JOIN "CRD1" S0 ON S0."CardCode" = C0."CardCode" 
AND S0."Address" = C0."ShipToDef" 
AND S0."AdresType" = 'S' ,
	 "OADM" A0,
	 "ADM1" A1 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND UPPER( LEFT(N1."BeginStr", 1)) = 'E'
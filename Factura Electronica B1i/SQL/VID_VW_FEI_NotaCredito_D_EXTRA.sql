DROP VIEW VID_VW_FEI_NOTACREDITO_D_EXTRA;
CREATE VIEW VID_VW_FEI_NOTACREDITO_D_EXTRA
AS 
SELECT
	T0."DocEntry" "DocEntry" ,
	T0."ObjType" "ObjType" ,
	T1."VisOrder" "LineaOrden" ,
	1 "LineaOrden2" ,
	'' "DET_EXTRA1" ,
	'' "DET_EXTRA2" ,
	'' "DET_EXTRA3" ,
	'' "DET_EXTRA4" ,
	'' "DET_EXTRA5" 
FROM "ORIN" T0 
JOIN "RIN1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND IFNULL(T0."U_TipoFac",'') = 'GL' 	
AND UPPER(LEFT(N0."BeginStr",1)) = 'E' 

UNION ALL 

SELECT
	T0."DocEntry" "DocEntry" ,
	T0."ObjType" "ObjType" ,
	T1."VisOrder" "LineaOrden" ,
	1 "LineaOrden2" ,
	T1."Currency" "DET_EXTRA1" ,
	REPLACE(CAST(ROUND(T1."Price", 2) AS VARCHAR), '.',',') "DET_EXTRA2" ,
	'' "DET_EXTRA3" ,
	'' "DET_EXTRA4" ,
	'' "DET_EXTRA5" 
FROM "ORIN" T0 
JOIN "RIN1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND IFNULL(T0."U_TipoFac",'') <> 'GL' 
AND UPPER(LEFT(N0."BeginStr",1)) = 'E'
DROP VIEW "VID_VW_FEI_52_D_EXTRA"; 
CREATE VIEW "VID_VW_FEI_52_D_EXTRA" 
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
FROM "OWTR" T0 
JOIN "WTR1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 
AND IFNULL(T0."FolioNum", 0) <> 0 AND UPPER(LEFT(N0."BeginStr", 1)) = 'E'
 
UNION ALL 

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
FROM "ORPD" T0 
JOIN "RPD1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 
AND IFNULL(T0."FolioNum",0) <> 0 AND UPPER(LEFT(N0."BeginStr", 1)) = 'E'
 
UNION ALL 

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
FROM "ODLN" T0 
JOIN "DLN1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1
DROP VIEW VID_VW_FEI_NOTACREDITO_E_EXTRA;
CREATE VIEW VID_VW_FEI_NOTACREDITO_E_EXTRA
AS 
SELECT
	 T0."DocEntry" ,
	T0."ObjType" ,
	'' "CAB_EXTRA1" ,
	'' "CAB_EXTRA2" ,
	'' "CAB_EXTRA3" ,
	'' "CAB_EXTRA4" ,
	'' "CAB_EXTRA5" ,
	'' "CAB_EXTRA6" ,
	'' "CAB_EXTRA7" ,
	'' "CAB_EXTRA8" ,
	'' "CAB_EXTRA9" ,
	'' "CAB_EXTRA10" ,
	'' "CAB_EXTRA11" ,
	'' "CAB_EXTRA12" ,
	'' "CAB_EXTRA13" ,
	'' "CAB_EXTRA14" ,
	'' "CAB_EXTRA15" ,
	'' "CAB_EXTRA16" ,
	'' "CAB_EXTRA17" ,
	'' "CAB_EXTRA18" ,
	'' "CAB_EXTRA19" ,
	'' "CAB_EXTRA20" ,
	'' "CAB_EXTRA21" ,
	'' "CAB_EXTRA22" ,
	'' "CAB_EXTRA23" ,
	'' "CAB_EXTRA24" ,
	'' "CAB_EXTRA25" 
FROM "ORIN" T0 JOIN "NNM1" N1 ON N1."Series" = T0."Series" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND UPPER(LEFT(N1."BeginStr",1)) = 'E' 

UNION ALL 

SELECT
	 T0."DocEntry" ,
	T0."ObjType" ,
	'' "CAB_EXTRA1" ,
	'' "CAB_EXTRA2" ,
	'' "CAB_EXTRA3" ,
	'' "CAB_EXTRA4" ,
	'' "CAB_EXTRA5" ,
	'' "CAB_EXTRA6" ,
	'' "CAB_EXTRA7" ,
	'' "CAB_EXTRA8" ,
	'' "CAB_EXTRA9" ,
	'' "CAB_EXTRA10" ,
	'' "CAB_EXTRA11" ,
	'' "CAB_EXTRA12" ,
	'' "CAB_EXTRA13" ,
	'' "CAB_EXTRA14" ,
	'' "CAB_EXTRA15" ,
	'' "CAB_EXTRA16" ,
	'' "CAB_EXTRA17" ,
	'' "CAB_EXTRA18" ,
	'' "CAB_EXTRA19" ,
	'' "CAB_EXTRA20" ,
	'' "CAB_EXTRA21" ,
	'' "CAB_EXTRA22" ,
	'' "CAB_EXTRA23" ,
	'' "CAB_EXTRA24" ,
	'' "CAB_EXTRA25" 
FROM "ORPC" T0 JOIN "NNM1" N1 ON N1."Series" = T0."Series" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND UPPER(LEFT(N1."BeginStr",1)) = 'E'
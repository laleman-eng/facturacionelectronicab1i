DROP VIEW VID_VW_FEI_52_R; 
CREATE VIEW VID_VW_FEI_52_R 
AS 
SELECT
	 T0."FolioNum" "Folio_Sii" ,
	'801' "TpoDocRef" ,
	LEFT(T0."NumAtCard",18) "FolioRef" ,
	TO_CHAR(T0."TaxDate",'yyyy-MM-dd') "FchRef" ,
	'0' "CodRef" ,
	'' "RazonRef" ,
	T0."DocEntry" "DocEntry" ,
	T0."ObjType" "ObjType" 
FROM "ODLN" T0 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND IFNULL(T0."NumAtCard", '') <> '' 
AND T0."DocSubType" = '--' 
AND UPPER(LEFT(N0."BeginStr", 1)) = 'E' 
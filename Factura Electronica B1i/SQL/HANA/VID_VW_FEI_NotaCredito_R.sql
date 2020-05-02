DROP VIEW VID_VW_FEI_NOTACREDITO_R; 
CREATE VIEW VID_VW_FEI_NOTACREDITO_R 
AS 

SELECT
	 T0."FolioNum" "Folio_Sii" ,
	 CASE WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' AND RIGHT(IFNULL(N1."BeginStr",''),3) = '110'AND O0."isIns" = 'Y'	THEN '110' 
		  WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '33' 
		  WHEN O0."DocSubType" = 'IB' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '39' 
		  WHEN O0."DocSubType" = 'BE' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '41' 
		  WHEN O0."DocSubType" = 'IX' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '110' 
		  WHEN O0."DocSubType" = 'IE' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '34' 
		  WHEN O0."DocSubType" = 'DN' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '56' 
		  WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) <> 'E' THEN '30' 
		  WHEN O0."DocSubType" = 'IX' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) <> 'E' THEN '101' 
		  WHEN O0."DocSubType" = 'IE' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) <> 'E' THEN '32' 
		  WHEN O0."DocSubType" = 'DN' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) <> 'E' THEN '55' 
		  ELSE '-1' 
		  END "TpoDocRef" ,
	 TO_VARCHAR(O0."FolioNum") "FolioRef" ,
	 TO_CHAR(O0."TaxDate",'yyyy-MM-dd') "FchRef" ,
	 R0."U_CodRef" "CodRef" ,
	 IFNULL(R0."U_RazRef", '') "RazonRef" ,
	 IFNULL(R0."U_IndGlobal", '0') "IndGlobal",
	 T0."ObjType" ,
	 T0."DocEntry" 
FROM "ORIN" T0 
JOIN "RIN1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "OINV" O0 ON T1."BaseEntry" = O0."DocEntry" 
JOIN "NNM1" N0 ON T0."Series" = N0."Series" 
JOIN "NNM1" N1 ON N1."Series" = O0."Series" 
LEFT JOIN "@VID_FEREF" R0 ON R0."U_DocEntry" = T0."DocEntry" 
	AND R0."U_DocSBO" = T0."ObjType" 
WHERE 1 = 1 
AND T1."BaseType" = '13' 
AND CASE WHEN O0."DocSubType" = '--' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '33' WHEN O0."DocSubType" = 'IB' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '39' WHEN O0."DocSubType" = 'BE' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '41' WHEN O0."DocSubType" = 'IX' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '110' WHEN O0."DocSubType" = 'IE' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E' THEN '34' WHEN O0."DocSubType" = 'DN' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) = 'E'THEN '56' WHEN O0."DocSubType" = '--' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) <> 'E' THEN '30' WHEN O0."DocSubType" = 'IX' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) <> 'E' THEN '101' WHEN O0."DocSubType" = 'IE' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) <> 'E' THEN '32' WHEN O0."DocSubType" = 'DN' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) <> 'E' THEN '55' 
ELSE '-1' 
END <> '-1' 
AND UPPER(LEFT(N0."BeginStr",1)) = 'E' 
GROUP BY T0."FolioNum" ,
	 O0."FolioNum" ,
	 O0."TaxDate" ,
	 R0."U_CodRef" ,
	 R0."U_RazRef" ,
	 O0."DocSubType" ,
	 N0."BeginStr" ,
	 T0."ObjType" ,
	 T0."DocEntry" ,
	 IFNULL(R0."U_IndGlobal",'0'),O0."isIns", N1."BeginStr" 

UNION 

SELECT
	 T0."FolioNum" "Folio_Sii" ,
	 CASE WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')), 1, 1) = 'E' THEN '33' 
	ELSE '-1' 
	END "TpoDocRef" ,
	 TO_VARCHAR(O0."FolioNum") "FolioRef" ,
	 TO_CHAR(O0."TaxDate",'yyyy-MM-dd') "FchRef" ,
	 R0."U_CodRef" "CodRef" ,
	 IFNULL(R0."U_RazRef", '') "RazonRef" ,
	 IFNULL(R0."U_IndGlobal",'0') "IndGlobal",
	 T0."ObjType" ,
	 T0."DocEntry" 
FROM "ORIN" T0 
JOIN "RIN1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "ODPI" O0 ON T1."BaseEntry" = O0."DocEntry" 
JOIN "NNM1" N0 ON T0."Series" = N0."Series" 
LEFT JOIN "@VID_FEREF" R0 ON R0."U_DocEntry" = T0."DocEntry" 
 AND R0."U_DocSBO" = T0."ObjType" 
WHERE 1 = 1 
AND T1."BaseType" = '203' 
AND CASE WHEN O0."DocSubType" = '--' 
AND SUBSTRING(UPPER(IFNULL(N0."BeginStr",'')),1, 1) = 'E' THEN '33' 
ELSE '-1' 
END <> '-1' 
AND UPPER( LEFT(N0."BeginStr", 1)) = 'E' 
GROUP BY T0."FolioNum" ,
	 O0."FolioNum" ,
	 O0."TaxDate" ,
	 R0."U_CodRef" ,
	 R0."U_RazRef" ,
	 O0."DocSubType" ,
	 N0."BeginStr" ,
	 T0."ObjType" ,
	 IFNULL(R0."U_IndGlobal",'0'), T0."DocEntry" 

UNION 

SELECT
	 T0."FolioNum" "Folio_Sii" ,
	 REPLACE(REPLACE(T2."U_TipoDTE",'b', ''),'a','') "TpoDocRef" ,
	 TO_VARCHAR(T2."U_DocFolio") "FolioRef" ,
	 TO_CHAR(T2."U_DocDate", 'yyyy-MM-dd') "FchRef" ,
	 T1."U_CodRef" "CodRef",
	 IFNULL(T1."U_RazRef",'') "RazonRef" ,
	 IFNULL(T1."U_IndGlobal", '0') "IndGlobal",
	 T0."ObjType" ,
	 T0."DocEntry" 
FROM "ORIN" T0 
JOIN "@VID_FEREF" T1 ON T1."U_DocEntry" = T0."DocEntry" 
	AND T1."U_DocSBO" = T0."ObjType" 
JOIN "@VID_FEREFD" T2 ON T2."DocEntry" = T1."DocEntry" 
JOIN "NNM1" N0 ON T0."Series" = N0."Series" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", -1) <> 0
AND IFNULL(T2."U_DocFolio", 0) <> 0 

UNION 

SELECT
	 T0."FolioNum" "Folio_Sii" ,
	 CASE WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr",'')),1,1) = 'E' THEN '46' 
	 WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')),1, 1) <> 'E' THEN '45' 
	ELSE '-1' 
	END "TpoDocRef" ,
	 TO_VARCHAR(O0."FolioNum") "FolioRef" ,
	 TO_CHAR(O0."TaxDate", 'yyyy-MM-dd') "FchRef" ,
	 R0."U_CodRef" "CodRef" ,
	 IFNULL(R0."U_RazRef", '') "RazonRef" ,
	 IFNULL(R0."U_IndGlobal", '0') "IndGlobal",
	 T0."ObjType" ,
	 T0."DocEntry" 
FROM "ORPC" T0 
JOIN "RPC1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "OPCH" O0 ON T1."BaseEntry" = O0."DocEntry" 
JOIN "NNM1" N0 ON T0."Series" = N0."Series" 
LEFT JOIN "@VID_FEREF" R0 ON R0."U_DocEntry" = T0."DocEntry" 
	AND R0."U_DocSBO" = T0."ObjType" 
WHERE 1 = 1 
AND T1."BaseType" = '18' 
AND CASE WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr",'')), 1, 1) = 'E' THEN '46' 
WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr",'')), 1, 1) <> 'E' THEN '45' 
ELSE '-1' 
END <> '-1' 
AND UPPER(LEFT(N0."BeginStr", 1)) = 'E' 
GROUP BY T0."FolioNum" ,
	 O0."FolioNum" ,
	 O0."TaxDate" ,
	 R0."U_CodRef" ,
	 R0."U_RazRef" ,
	 O0."DocSubType" ,
	 N0."BeginStr" ,
	 IFNULL(R0."U_IndGlobal", '0'), T0."ObjType" , T0."DocEntry" 
		
UNION 

SELECT
	 T0."FolioNum" "Folio_Sii" ,
	 CASE WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')), 1, 1) = 'E' THEN '46' 
		  WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr", '')), 1, 1) <> 'E' THEN '45' 
		  ELSE '-1' 
		  END "TpoDocRef" ,
	 TO_VARCHAR(O0."FolioNum") "FolioRef" ,
	 TO_CHAR(O0."TaxDate", 'yyyy-MM-dd') "FchRef" ,
	 R0."U_CodRef" "CodRef" ,
	 IFNULL(R0."U_RazRef", '') "RazonRef" ,
	 IFNULL(R0."U_IndGlobal", '0') "IndGlobal",
	 T0."ObjType" ,
	 T0."DocEntry" 
FROM "ORPC" T0 
JOIN "RPC1" T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN "ODPO" O0 ON T1."BaseEntry" = O0."DocEntry" 
JOIN "NNM1" N0 ON T0."Series" = N0."Series" 
LEFT JOIN "@VID_FEREF" R0 ON R0."U_DocEntry" = T0."DocEntry" 
	AND R0."U_DocSBO" = T0."ObjType" 
WHERE 1 = 1 
AND T1."BaseType" = '204' 
AND CASE WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr",'')), 1, 1) = 'E' THEN '46' 
 	     WHEN O0."DocSubType" = '--' AND SUBSTRING(UPPER(IFNULL(N0."BeginStr",'')), 1, 1) <> 'E' THEN '45' 
		 ELSE '-1' 
		 END <> '-1' 
		 AND UPPER(LEFT(N0."BeginStr", 1)) = 'E' 			
GROUP BY T0."FolioNum" ,
	 O0."FolioNum" ,
	 O0."TaxDate" ,
	 R0."U_CodRef" ,
	 R0."U_RazRef" ,
	 O0."DocSubType" ,
	 N0."BeginStr" ,
	 IFNULL(R0."U_IndGlobal",'0'), T0."ObjType" ,
	 T0."DocEntry"
	 
UNION 

SELECT
	 T0."FolioNum" "Folio_Sii" ,
	 REPLACE(REPLACE(T2."U_TipoDTE",'b',''),'a','') "TpoDocRef" ,
	 TO_VARCHAR(T2."U_DocFolio") "FolioRef" ,
	 TO_CHAR(T2."U_DocDate", 'yyyy-MM-dd') "FchRef" ,
	 T1."U_CodRef" "CodRef" ,
	 IFNULL(T1."U_RazRef", '') "RazonRef" ,
	 IFNULL(T1."U_IndGlobal", '0') "IndGlobal",
	 T0."ObjType" ,
	 T0."DocEntry" 
FROM "ORPC" T0 
JOIN "@VID_FEREF" T1 ON T1."U_DocEntry" = T0."DocEntry" 
		AND T1."U_DocSBO" = T0."ObjType" 
JOIN "@VID_FEREFD" T2 ON T2."DocEntry" = T1."DocEntry" 
JOIN "NNM1" N0 ON T0."Series" = N0."Series" 
WHERE 1 = 1 --AND IFNULL(T0."FolioNum", 0) <> 0
AND IFNULL(T2."U_DocFolio", 0) <> 0 
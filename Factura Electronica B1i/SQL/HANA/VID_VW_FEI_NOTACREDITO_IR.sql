DROP VIEW VID_VW_FEI_NOTACREDITO_IR; 
CREATE VIEW VID_VW_FEI_NOTACREDITO_IR 
AS 
SELECT
	 IFNULL(I0."U_CodImpto",'') "TipoImp" ,
	S0."Rate" "TasaImp" ,
	SUM(T4."TaxSum") "MontoImp" ,
	T0."ObjType" "ObjType" ,
	T0."DocEntry" "DocEntry" 
FROM ORIN T0 
JOIN NNM1 N0 ON N0."Series" = T0."Series" 
JOIN RIN1 T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN RIN4 T4 ON T4."DocEntry" = T0."DocEntry" 
AND T4."LineNum" = T1."LineNum" 
AND UPPER(T4."StaCode") NOT IN ('IVA','IVA_EXE') 
JOIN OSTA S0 ON T4."StaCode" = s0."Code" 
JOIN "@VID_FEIMPADIC" I0 ON I0."Code" = T4."StaCode" 
WHERE 1 = 1 
AND UPPER(LEFT(N0."BeginStr", 1)) = 'E' 
GROUP BY T0."DocEntry" ,
	T0."ObjType" ,
	I0."U_CodImpto" ,
	S0."Rate"
	
UNION 
SELECT
	 IFNULL(I0."U_CodImpto",'') "TipoImp" ,
	S0."Rate" "TasaImp" ,
	SUM(T4."TaxSum") "MontoImp" ,
	T0."ObjType" "ObjType" ,
	T0."DocEntry" "DocEntry" 
FROM ORPC T0 
JOIN NNM1 N0 ON N0."Series" = T0."Series" 
JOIN RPC1 T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN RPC4 T4 ON T4."DocEntry" = T0."DocEntry" 
AND T4."LineNum" = T1."LineNum" 
AND UPPER(T4."StaCode") NOT IN ('IVA','IVA_EXE') 
JOIN OSTA S0 ON T4."StaCode" = s0."Code" 
JOIN "@VID_FEIMPADIC" I0 ON I0."Code" = T4."StaCode" 
WHERE 1 = 1 
AND UPPER(LEFT(N0."BeginStr", 1)) = 'E' 
GROUP BY T0."DocEntry" ,
	T0."ObjType" ,
	I0."U_CodImpto" ,
	S0."Rate"
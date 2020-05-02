--DROP VIEW VID_VW_FEI_FACTURA_IR_EXTRA;
CREATE VIEW VID_VW_FEI_FACTURA_IR_EXTRA
AS 
SELECT
	 '' 					"TipoImp" ,
	0 						"TasaImp" ,
	0 						"MontoImp" ,
	T0."ObjType" 			"ObjType" ,
	T0."DocEntry" 			"DocEntry" 

FROM OINV T0 
JOIN NNM1 N0 ON N0."Series" = T0."Series" 
JOIN INV1 T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN INV4 T4 ON T4."DocEntry" = T0."DocEntry" 
	AND T4."LineNum" = T1."LineNum" 
	AND UPPER(T4."StaCode")	NOT IN ('IVA','IVA_EXE') 
JOIN OSTA S0 ON T4."StaCode" = s0."Code" JOIN "@VID_FEIMPADIC" I0 ON I0."Code" = T4."StaCode" 
WHERE 1 = 1 
	AND UPPER(LEFT(N0."BeginStr",1)) = 'E' 
	AND T0."DocSubType" IN ('--',	 'DN') 
GROUP BY T0."DocEntry" ,
				T0."ObjType" ,
				I0."U_CodImpto" ,
				S0."Rate" 
UNION 

SELECT
	 '' 					"TipoImp" ,
	0 						"TasaImp" ,
	0 						"MontoImp" ,
	T0."ObjType" 			"ObjType" ,
	T0."DocEntry" 			"DocEntry" 
FROM ODPI T0 
JOIN NNM1 N0 ON N0."Series" = T0."Series" 
JOIN DPI1 T1 ON T1."DocEntry" = T0."DocEntry" 
JOIN DPI4 T4 ON T4."DocEntry" = T0."DocEntry" 
		AND T4."LineNum" = T1."LineNum" 
		AND UPPER(T4."StaCode") NOT IN ('IVA','IVA_EXE') 
JOIN OSTA S0 ON T4."StaCode" = s0."Code" 
JOIN "@VID_FEIMPADIC" I0 ON I0."Code" = T4."StaCode" 
WHERE 1 = 1 
		AND UPPER(LEFT(N0."BeginStr",1)) = 'E' 
GROUP BY T0."DocEntry" ,
	T0."ObjType" ,
	I0."U_CodImpto" ,
	S0."Rate"
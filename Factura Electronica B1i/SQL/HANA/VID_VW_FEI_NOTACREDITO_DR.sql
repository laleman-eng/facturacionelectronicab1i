DROP VIEW VID_VW_FEI_NOTACREDITO_DR;
CREATE VIEW VID_VW_FEI_NOTACREDITO_DR
AS 
SELECT
	 'D' "TpoMov" ,
	'Descuento' "GlosaDR" ,
	'$' "TpoValor" ,
	CASE WHEN RIGHT(N0."BeginStr", 3) = '112' 
		THEN IFNULL(ROUND(CASE WHEN T0."CurSource" = 'L' THEN T0."DiscSum" 
							   WHEN T0."CurSource" = 'S' THEN T0."DiscSumSy" 
							   WHEN T0."CurSource" = 'C' THEN T0."DiscSumFC" 
						END, 0),0.0) + IFNULL(ROUND(CASE WHEN T0."CurSource" = 'L' 	THEN T0."DpmAmnt" 
													WHEN T0."CurSource" = 'S' 	THEN T0."DpmAmntSC" 
													WHEN T0."CurSource" = 'C' 	THEN T0."DpmAmntFC" 
													END, 0), 0.0) 
						ELSE ROUND(T0."DiscSum" + T0."DpmAmnt", 0)
						END "ValorDR" ,
	0 "ValorDROtrMnda" ,
	CASE WHEN T0."VatSum" = 0 THEN 1 
		ELSE 2 
		END "IndExeDR" ,
	1 "LineaOrden" ,
	T0."ObjType" "ObjType" ,
	T0."DocEntry" "DocEntry" 
FROM "ORIN" T0 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 
AND UPPER(LEFT(N0."BeginStr", 1)) = 'E' 

UNION ALL 

SELECT
	 'D' "TpoMov" ,
	'Descuento' "GlosaDR" ,
	'$' "TpoValor" ,
	ROUND(T0."DiscSum" + T0."DpmAmnt", 0) "ValorDR" ,
	0 "ValorDROtrMnda" ,
	CASE WHEN T0."VatSum" = 0 THEN 1 
		ELSE 2 
		END "IndExeDR" ,
	1 "LineaOrden" ,
	T0."ObjType" "ObjType" ,
	T0."DocEntry" "DocEntry" 
FROM "ORPC" T0 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 
AND UPPER(LEFT(N0."BeginStr", 1)) = 'E'
DROP VIEW VID_VW_FEI_GUIA_DR;  
CREATE VIEW VID_VW_FEI_GUIA_DR  
AS 
SELECT
	 'D' "TpoMov" ,
	'Descuento' "GlosaDR" ,
	'$' "TpoValor" ,
	ROUND(T0."DiscSum" + T0."DpmAmnt", 0) "ValorDR" ,
	0 "ValorDROtrMnda" ,
	CASE WHEN T0."VatSum" = 0 
			THEN 1 
			ELSE 2 
			END "IndExeDR" ,
	1 "LineaOrden" ,
	T0."ObjType" "ObjType" ,
	T0."DocEntry" "DocEntry" 
FROM "ODLN" T0 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 
AND UPPER(LEFT(N0."BeginStr", 1)) = 'E' 

UNION 
SELECT
	 'D' "TpoMov" ,
	'Descuento' "GlosaDR" ,
	'$' "TpoValor" ,
	ROUND(T0."DiscSum" + T0."DpmAmnt", 0) "ValorDR" ,
	0 "ValorDROtrMnda" ,
	CASE WHEN T0."VatSum" = 0 
			THEN 1 
			ELSE 2 
			END "IndExeDR" ,
	1 "LineaOrden" ,
	T0."ObjType" "ObjType" ,
	T0."DocEntry" "DocEntry" 
FROM "OWTR" T0 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 
AND UPPER(LEFT(N0."BeginStr", 1)) = 'E' 

UNION 

SELECT
	 'D' "TpoMov" ,
	'Descuento' "GlosaDR" ,
	'$' "TpoValor" ,
	ROUND(T0."DiscSum" + T0."DpmAmnt", 0) "ValorDR" ,
	0 "ValorDROtrMnda" ,
	CASE WHEN T0."VatSum" = 0 
		THEN 1 
		ELSE 2 
		END "IndExeDR" ,
	1 "LineaOrden" ,
	T0."ObjType" "ObjType" ,
	T0."DocEntry" "DocEntry" 
FROM "ORPD" T0 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 
AND UPPER(LEFT(N0."BeginStr", 1)) = 'E'
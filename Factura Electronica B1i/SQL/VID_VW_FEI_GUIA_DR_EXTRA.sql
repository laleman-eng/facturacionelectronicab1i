DROP VIEW VID_VW_FEI_GUIA_DR_EXTRA;  
CREATE VIEW VID_VW_FEI_GUIA_DR_EXTRA  
AS 
SELECT
	 'D' "TpoMov" --D(descuento) o R(recargo)
 ,
	'Descuento' "GlosaDR" --Descuento o Recargo
 ,
	'$' "TpoValor" --$ o %
 ,
	0 "ValorDR" --Valor descuento/recargo (16,2)
 ,
	0 "ValorDROtrMnda" --0
 ,
	0 "IndExeDR" --1 Exento, 2 No facturable
 ,
	2 "LineaOrden" ,
	T0."ObjType" "ObjType" ,
	T0."DocEntry" "DocEntry" 
FROM "ODLN" T0 
JOIN "NNM1" N0 ON N0."Series" = T0."Series" 
WHERE 1 = 1 
AND UPPER(LEFT(N0."BeginStr", 1)) = 'E' 
--DROP PROCEDURE VID_SP_FEI_FACTURA_DR;
CREATE PROCEDURE VID_SP_FEI_FACTURA_DR
(
     IN DocEntry		Integer
    ,IN TipoDoc			VarChar(10)
    ,IN ObjType			VarChar(10)
)
LANGUAGE SqlScript
AS
BEGIN
	docs1 = SELECT T0."TpoMov"
				  ,T0."GlosaDR"
				  ,T0."TpoValor"
				  ,T0."ValorDR"
				  ,T0."ValorDROtrMnda"
				  ,T0."IndExeDR"
				  ,T0."LineaOrden"
			  FROM VID_VW_FEI_FACTURA_DR T0 
			 WHERE 1 = 1
			   AND IFNULL(T0."ValorDR", 0) <> 0
			   AND T0."DocEntry" = :DocEntry
			   AND T0."ObjType"  = :ObjType;
			
	docs2 = SELECT T0."TpoMov"
				  ,T0."GlosaDR"
				  ,T0."TpoValor"
				  ,T0."ValorDR"
				  ,T0."ValorDROtrMnda"
				  ,T0."IndExeDR"
				  ,T0."LineaOrden"
			  FROM VID_VW_FEI_FACTURA_DR_EXTRA T0 
			 WHERE 1 = 1
			   AND IFNULL(T0."ValorDR", 0) <> 0
			   AND T0."DocEntry" = :DocEntry
			   AND T0."ObjType"  = :ObjType;
			
	v_out = CE_UNION_ALL(:docs1, :docs2);
	
	--Select final para mostrar
	SELECT ROW_NUMBER() OVER(ORDER BY "LineaOrden")					"NroLinDR"
		  ,"TpoMov"													"TpoMov"
		  ,"GlosaDR"												"GlosaDR"
		  ,"TpoValor"												"TpoValor"
		  ,"ValorDR"												"ValorDR"
		  ,"ValorDROtrMnda"											"ValorDROtrMnda"
		  ,"IndExeDR"												"IndExeDR"
	  FROM :v_out;
			
END;
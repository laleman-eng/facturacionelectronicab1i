DROP PROCEDURE VID_SP_FEI_GUIA_IR;
CREATE PROCEDURE VID_SP_FEI_GUIA_IR
(
     IN DocEntry		Integer
    ,IN TipoDoc			VarChar(10)
    ,IN ObjType			VarChar(10)
)
LANGUAGE SqlScript
AS
BEGIN
	docs1 = SELECT T0."TipoImp"
				  ,T0."TasaImp"
				  ,T0."MontoImp"
			  FROM VID_VW_FEI_GUIA_IR T0 
			 WHERE 1 = 1
			   AND IFNULL(T0."MontoImp", 0) <> 0
			   AND T0."DocEntry" = :DocEntry
			   AND T0."ObjType"  = :ObjType;
			
	docs2 = SELECT T0."TipoImp"
				  ,T0."TasaImp"
				  ,T0."MontoImp"
			  FROM VID_VW_FEI_GUIA_IR_EXTRA T0 
			 WHERE 1 = 1
			   AND IFNULL(T0."MontoImp", 0) <> 0
			   AND T0."DocEntry" = :DocEntry
			   AND T0."ObjType"  = :ObjType;
			
	v_out = CE_UNION_ALL(:docs1, :docs2);
	
	--Select final para mostrar
	SELECT "TipoImp"												"TipoImp"
		  ,"TasaImp"												"TasaImp"
		  ,"MontoImp"												"MontoImp"
	  FROM :v_out;
			
END;
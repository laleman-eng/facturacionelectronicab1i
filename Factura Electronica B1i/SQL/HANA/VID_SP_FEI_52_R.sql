DROP PROCEDURE VID_SP_FEI_52_R;
CREATE PROCEDURE VID_SP_FEI_52_R
(
	 IN DocEntry		Integer
	,IN TipoDoc			VarChar(10)
	,IN ObjType			VarChar(10)
)
LANGUAGE SqlScript
AS
BEGIN
	
	docs1 = SELECT
			 T0."Folio_Sii"						"Folio_Sii"
			,:TipoDoc							"TipoDte"
			,T0."TpoDocRef"						"TpoDocRef"
			,T0."FolioRef"						"FolioRef"
			,T0."FchRef"						"FchRef"
			,IFNULL(T0."CodRef", '')			"CodRef"
			,IFNULL(T0."RazonRef", '')			"RazonRef"
		FROM VID_VW_FE_52_R T0 
		WHERE 1 = 1
			AND T0."DocEntry" = :DocEntry
			AND T0."ObjType" = :ObjType;
	
	docs2 = SELECT
			 T0."Folio_Sii"						"Folio_Sii"
			,:TipoDoc							"TipoDte"
			,T0."TpoDocRef"						"TpoDocRef"
			,T0."FolioRef"						"FolioRef"
			,T0."FchRef"						"FchRef"
			,IFNULL(T0."CodRef", '')			"CodRef"
			,IFNULL(T0."RazonRef", '')			"RazonRef"
		FROM VID_VW_FE_52_R_EXTRA T0 
		WHERE 1 = 1
			AND T0."DocEntry" = :DocEntry
			AND T0."ObjType" = :ObjType;
				
	v_out = CE_UNION_ALL(:docs1, :docs2);
	
	--Select final para mostrar
	SELECT
		 ROW_NUMBER() OVER(ORDER BY "Folio_Sii")	"NroLinRef" 
		,"TpoDocRef"							"TpoDocRef"
		,"FolioRef"								"FolioRef"
		,"FchRef"								"FchRef"
		,"CodRef"								"CodRef"	
		,"RazonRef"								"RazonRef"
	FROM :v_out;
END;
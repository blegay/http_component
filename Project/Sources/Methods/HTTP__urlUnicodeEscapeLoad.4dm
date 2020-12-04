//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

C_POINTER:C301($1;$vp_unicodeCharcodeArrayPtr)
C_POINTER:C301($2;$vp_codeArrayPtr)

If (Count parameters:C259>1)
	
	$vp_unicodeCharcodeArrayPtr:=$1
	$vp_codeArrayPtr:=$2
	
	C_TEXT:C284($vt_filePath)
	$vt_filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"urlUnicodeEscapeList.xml"
	ASSERT:C1129(Test path name:C476($vt_filePath)=Is a document:K24:1;"file \""+$vt_filePath+"\" not found")
	
	If (Test path name:C476($vt_filePath)=Is a document:K24:1)
		
		ARRAY LONGINT:C221($tl_unicodeCharcodeArray;0)
		ARRAY TEXT:C222($tt_codeArray;0)
		
		C_TEXT:C284($vt_elementName)
		C_TEXT:C284($vt_xmlDomRootRef;$vt_xmlDomElementRef)
		$vt_xmlDomRootRef:=DOM Parse XML source:C719($vt_filePath)
		If (ok=1)
			
			$vt_xmlDomElementRef:=DOM Get first child XML element:C723($vt_xmlDomRootRef;$vt_elementName)
			While (ok=1)
				
				If ($vt_elementName="urlEscapeUnicode")
					
					C_TEXT:C284($vt_unicodeValue;$vt_code;$vt_standard;$vt_dtd)
					
					  //<urlEscapeUnicode unicode="U+00E8"name="LATIN SMALL LETTER E WITH GRAVE"char="è"sequence="c3a8"/>
					
					DOM GET XML ATTRIBUTE BY NAME:C728($vt_xmlDomElementRef;"unicode";$vt_unicodeValue)
					DOM GET XML ATTRIBUTE BY NAME:C728($vt_xmlDomElementRef;"sequence";$vt_code)
					
					APPEND TO ARRAY:C911($tl_unicodeCharcodeArray;HEX_hexTextToLong (Substring:C12($vt_unicodeValue;3)))
					APPEND TO ARRAY:C911($tt_codeArray;$vt_code)
					
				End if 
				
				$vt_xmlDomElementRef:=DOM Get next sibling XML element:C724($vt_xmlDomElementRef;$vt_elementName)
			End while 
			
			DOM CLOSE XML:C722($vt_xmlDomRootRef)
		End if 
		
		  //Si (Nombre de parametres>1)
		COPY ARRAY:C226($tl_unicodeCharcodeArray;$vp_unicodeCharcodeArrayPtr->)
		COPY ARRAY:C226($tt_codeArray;$vp_codeArrayPtr->)
		  //Fin de si 
		
		ARRAY LONGINT:C221($tl_unicodeCharcodeArray;0)
		ARRAY TEXT:C222($tt_codeArray;0)
		
	End if 
	
End if 


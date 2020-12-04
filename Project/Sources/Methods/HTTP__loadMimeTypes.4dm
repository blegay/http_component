//%attributes = {"invisible":true,"preemptive":"capable","shared":false}


C_POINTER:C301($1;$vp_mimeTypesArrayPtr)
C_POINTER:C301($2;$vp_mimeTypeCompressArrayPtr)

If (Count parameters:C259>1)
	$vp_mimeTypesArrayPtr:=$1
	$vp_mimeTypeCompressArrayPtr:=$2
	
	If ((Type:C295($vp_mimeTypesArrayPtr->)=Text array:K8:16) & (Type:C295($vp_mimeTypeCompressArrayPtr->)=Boolean array:K8:21))
		
		C_TEXT:C284($vt_xmlFilePath)
		$vt_xmlFilePath:=Get 4D folder:C485(Current resources folder:K5:16)+"mimeList.xml"
		ASSERT:C1129(Test path name:C476($vt_xmlFilePath)=Is a document:K24:1;"file \""+$vt_xmlFilePath+"\" not found")
		
		If (Test path name:C476($vt_xmlFilePath)=Is a document:K24:1)
			ARRAY TEXT:C222($tt_mimeTypes;0)
			ARRAY BOOLEAN:C223($tb_mimeTypeCompress;0)
			C_TEXT:C284($vt_elementName)
			C_TEXT:C284($vt_xmlDomRootRef;$vt_xmlDomElementRef)
			$vt_xmlDomRootRef:=DOM Parse XML source:C719($vt_xmlFilePath)
			If (ok=1)
				
				$vt_xmlDomElementRef:=DOM Get first child XML element:C723($vt_xmlDomRootRef;$vt_elementName)
				While (ok=1)
					
					If ($vt_elementName="mime")
						
						C_TEXT:C284($vt_mimeType)
						C_BOOLEAN:C305($vb_compress)
						
						  //<mime type="text/html"/>
						  //<mime type="audio/aiff" compress="true"/>
						  //<mime type="audio/wav" compress="false"/>
						
						DOM GET XML ATTRIBUTE BY NAME:C728($vt_xmlDomElementRef;"type";$vt_mimeType)
						
						If (DOM Count XML attributes:C727($vt_xmlDomElementRef)>1)
							DOM GET XML ATTRIBUTE BY NAME:C728($vt_xmlDomElementRef;"compress";$vb_compress)
						Else 
							$vb_compress:=True:C214
						End if 
						
						APPEND TO ARRAY:C911($tt_mimeTypes;$vt_mimeType)
						APPEND TO ARRAY:C911($tb_mimeTypeCompress;$vb_compress)
						
					End if 
					
					$vt_xmlDomElementRef:=DOM Get next sibling XML element:C724($vt_xmlDomElementRef;$vt_elementName)
				End while 
				
				DOM CLOSE XML:C722($vt_xmlDomRootRef)
			End if   //dom
			
			COPY ARRAY:C226($tt_mimeTypes;$vp_mimeTypesArrayPtr->)
			COPY ARRAY:C226($tb_mimeTypeCompress;$vp_mimeTypeCompressArrayPtr->)
			
			ARRAY TEXT:C222($tt_mimeTypes;0)
			ARRAY BOOLEAN:C223($tb_mimeTypeCompress;0)
		End if   //test document
		
	End if   //parameter type check
	
End if   //nb param check

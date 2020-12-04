//%attributes = {"invisible":true,"preemptive":"capable"}


C_POINTER:C301($1;$vp_extensionsArrayPtr)
C_POINTER:C301($2;$vp_mimeTypesArrayPtr)

If (Count parameters:C259>1)
	$vp_extensionsArrayPtr:=$1
	$vp_mimeTypesArrayPtr:=$2
	
	If ((Type:C295($vp_extensionsArrayPtr->)=Text array:K8:16) & (Type:C295($vp_mimeTypesArrayPtr->)=Text array:K8:16))
		
		C_TEXT:C284($vt_resourceDir)
		$vt_resourceDir:=Get 4D folder:C485(Current resources folder:K5:16)
		
		C_TEXT:C284($vt_xmlFilePath)
		$vt_xmlFilePath:=$vt_resourceDir+"extensionMimeLookup.xml"
		ASSERT:C1129(Test path name:C476($vt_xmlFilePath)=Is a document:K24:1;"file \""+$vt_xmlFilePath+"\" not found")
		
		C_TEXT:C284($vt_xsdFilePath)
		$vt_xsdFilePath:=$vt_resourceDir+"extensionMimeLookup.xsd"
		ASSERT:C1129(Test path name:C476($vt_xsdFilePath)=Is a document:K24:1;"file \""+$vt_xsdFilePath+"\" not found")
		
		  //HTTP__moduleDebugDateTimeLine (4;"xmlFilePath : \""+$vt_xmlFilePath+"\", xsdFilePath : \""+$vt_xsdFilePath+"\"")
		
		If ((Test path name:C476($vt_xmlFilePath)=Is a document:K24:1) & (Test path name:C476($vt_xsdFilePath)=Is a document:K24:1))
			ARRAY TEXT:C222($tt_extensions;0)
			ARRAY TEXT:C222($tt_mimeTypes;0)
			
			C_BOOLEAN:C305($vb_validate)
			$vb_validate:=(Substring:C12($vt_xsdFilePath;1;2)#"\\\\")  //Vrai
			  // note : Quand le chemin du xsd commence par  //   "\\MACBOOKPRO-29A7\..." on a une erreur "Le fichier xml n'est pas valide ou n'est pas bien formé. (An exception occured! Type:MalformedURLException, Message:The URL used and unsupported protocol : Ligne #0,Colone # 0.)"
			  // Bruno LEGAY le 18/12/2015 sur 4D v12.6 (windows)
			
			C_TEXT:C284($vt_elementName)
			C_TEXT:C284($vt_xmlDomRootRef;$vt_xmlDomElementRef)
			$vt_xmlDomRootRef:=DOM Parse XML source:C719($vt_xmlFilePath;$vb_validate;$vt_xsdFilePath)
			If (ok=1)
				
				$vt_xmlDomElementRef:=DOM Get first child XML element:C723($vt_xmlDomRootRef;$vt_elementName)
				While (ok=1)
					
					If ($vt_elementName="extMimeLookup")
						
						C_TEXT:C284($vt_extension;$vt_mimeType)
						
						  //<extMimeLookup extension=".htm" mime="text/html"/>
						
						DOM GET XML ATTRIBUTE BY NAME:C728($vt_xmlDomElementRef;"extension";$vt_extension)
						DOM GET XML ATTRIBUTE BY NAME:C728($vt_xmlDomElementRef;"mime";$vt_mimeType)
						
						APPEND TO ARRAY:C911($tt_extensions;$vt_extension)
						APPEND TO ARRAY:C911($tt_mimeTypes;$vt_mimeType)
						
					End if 
					
					$vt_xmlDomElementRef:=DOM Get next sibling XML element:C724($vt_xmlDomElementRef;$vt_elementName)
				End while 
				
				DOM CLOSE XML:C722($vt_xmlDomRootRef)
			End if   //dom
			
			COPY ARRAY:C226($tt_extensions;$vp_extensionsArrayPtr->)
			COPY ARRAY:C226($tt_mimeTypes;$vp_mimeTypesArrayPtr->)
			
			ARRAY TEXT:C222($tt_extensions;0)
			ARRAY TEXT:C222($tt_mimeTypes;0)
		End if   //test document
		
	End if   //parameter type check
	
End if   //nb param check

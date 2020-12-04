//%attributes = {"invisible":true,"preemptive":"capable"}

If (Not:C34(Bool:C1537(Storage:C1525.http.init)))
	
	
	  //<Modif> Bruno LEGAY (BLE) (06/08/2020)
	  // in compiled mode, the assert will be automatically disabled (for the component and all processes)
	C_BOOLEAN:C305($vb_assertEnabled)
	$vb_assertEnabled:=Not:C34(Is compiled mode:C492(*))
	SET ASSERT ENABLED:C1131($vb_assertEnabled)
	  //<Modif>
	
	
	Use (Storage:C1525)
		
		If (Not:C34(OB Is defined:C1231(Storage:C1525;"http")))
			
			Storage:C1525.http:=New shared object:C1526(\
				"init";False:C215;\
				"httpEscapeLookup";New shared collection:C1527;\
				"unicodeEscapeLookup";New shared collection:C1527;\
				"mimeTypeCompressLookup";New shared collection:C1527;\
				"mimeTypeLookup";New shared collection:C1527)
		End if 
		
		If (False:C215)
			  //If (True)
			  //C_COLLECTION($co_httpEscapeLookup)
			  //$co_httpEscapeLookup:=New shared collection
			
			  //ARRAY LONGINT($tl_HTTP_ascii;0)
			  //ARRAY TEXT($tt_HTTP_escaped;0)
			
			  //HTTP__httpEscapeLoad (->$tl_HTTP_ascii;->$tt_HTTP_escaped)
			
			  //ARRAY TO COLLECTION($co_httpEscapeLookup;\
				$tl_HTTP_ascii;"ascii";\
				$tt_HTTP_escaped;"httpEscaped")
			
			  //ARRAY LONGINT($tl_HTTP_ascii;0)
			  //ARRAY TEXT($tt_HTTP_escaped;0)
			  //End if 
			
			  //If (True)
			  //C_COLLECTION($co_unicodeEscapeLookup)
			  //$co_unicodeEscapeLookup:=New shared collection
			
			  //ARRAY LONGINT($tl_HTTP_urlUnicode;0)
			  //ARRAY TEXT($tt_HTTP_urlUnicodeEscaped;0)
			
			  //HTTP__urlUnicodeEscapeLoad (->$tl_HTTP_urlUnicode;->$tt_HTTP_urlUnicodeEscaped)
			
			  //ARRAY TO COLLECTION($co_unicodeEscapeLookup;\
				$tl_HTTP_urlUnicode;"unicode";\
				$tt_HTTP_urlUnicodeEscaped;"unicodeEscaped")
			
			  //ARRAY LONGINT($tl_HTTP_urlUnicode;0)
			  //ARRAY TEXT($tt_HTTP_urlUnicodeEscaped;0)
			  //End if 
			
			  //If (True)
			  //C_COLLECTION($co_mimeTypeCompressLookup)
			  //$co_mimeTypeCompressLookup:=New shared collection
			
			  //ARRAY TEXT($tt_HTTP_mimeTypes;0)
			  //ARRAY BOOLEAN($tb_HTTP_mimeTypesCompress;0)
			
			  //HTTP__loadMimeTypes (->$tt_HTTP_mimeTypes;->$tb_HTTP_mimeTypesCompress)
			
			  //ARRAY TO COLLECTION($co_mimeTypeCompressLookup;\
				$tt_HTTP_mimeTypes;"mimeType";\
				$tb_HTTP_mimeTypesCompress;"compress")
			
			  //ARRAY TEXT($tt_HTTP_mimeTypes;0)
			  //ARRAY BOOLEAN($tb_HTTP_mimeTypesCompress;0)
			  //End if 
			
			  //If (True)
			  //C_COLLECTION($co_mimeTypeLookup)
			  //$co_mimeTypeLookup:=New shared collection
			
			  //ARRAY TEXT($tt_HTTP_extMimeLookupExt;0)
			  //ARRAY TEXT($tt_HTTP_extMimeLookupMime;0)
			
			  //HTTP__loadExtMimeLookup (->$tt_HTTP_extMimeLookupExt;->$tt_HTTP_extMimeLookupMime)
			
			  //ARRAY TO COLLECTION($co_mimeTypeLookup;\
				$tt_HTTP_extMimeLookupExt;"extension";\
				$tt_HTTP_extMimeLookupMime;"mimeType")
			
			  //ARRAY TEXT($tt_HTTP_extMimeLookupExt;0)
			  //ARRAY TEXT($tt_HTTP_extMimeLookupMime;0)
			  //End if 
		End if 
		
		If (Not:C34(Bool:C1537(Storage:C1525.http.init)))
			Use (Storage:C1525.http)
				  // DBG__systemLogEvent(Current method name+" : calling DBG__logFileNew...")
				
				If (False:C215)
					  //C_TEXT($vt_logFilePath)
					  //$vt_logFilePath:=DBG__logFileNew
					  //Storage.http.httpEscapeLookup:=$co_httpEscapeLookup
					  //Storage.http.unicodeEscapeLookup:=$co_unicodeEscapeLookup
					  //Storage.http.mimeTypeCompressLookup:=$co_mimeTypeCompressLookup
					  //Storage.http.mimeTypeLookup:=$co_mimeTypeLookup
				End if 
				
				If (True:C214)
					ARRAY LONGINT:C221($tl_HTTP_ascii;0)
					ARRAY TEXT:C222($tt_HTTP_escaped;0)
					
					HTTP__httpEscapeLoad (->$tl_HTTP_ascii;->$tt_HTTP_escaped)
					
					ARRAY TO COLLECTION:C1563(Storage:C1525.http.httpEscapeLookup;\
						$tl_HTTP_ascii;"ascii";\
						$tt_HTTP_escaped;"httpEscaped")
					
					ARRAY LONGINT:C221($tl_HTTP_ascii;0)
					ARRAY TEXT:C222($tt_HTTP_escaped;0)
				End if 
				
				If (True:C214)
					ARRAY LONGINT:C221($tl_HTTP_urlUnicode;0)
					ARRAY TEXT:C222($tt_HTTP_urlUnicodeEscaped;0)
					
					HTTP__urlUnicodeEscapeLoad (->$tl_HTTP_urlUnicode;->$tt_HTTP_urlUnicodeEscaped)
					
					ARRAY TO COLLECTION:C1563(Storage:C1525.http.unicodeEscapeLookup;\
						$tl_HTTP_urlUnicode;"unicode";\
						$tt_HTTP_urlUnicodeEscaped;"unicodeEscaped")
					
					ARRAY LONGINT:C221($tl_HTTP_urlUnicode;0)
					ARRAY TEXT:C222($tt_HTTP_urlUnicodeEscaped;0)
				End if 
				
				If (True:C214)
					ARRAY TEXT:C222($tt_HTTP_mimeTypes;0)
					ARRAY BOOLEAN:C223($tb_HTTP_mimeTypesCompress;0)
					
					HTTP__loadMimeTypes (->$tt_HTTP_mimeTypes;->$tb_HTTP_mimeTypesCompress)
					
					ARRAY TO COLLECTION:C1563(Storage:C1525.http.mimeTypeCompressLookup;\
						$tt_HTTP_mimeTypes;"mimeType";\
						$tb_HTTP_mimeTypesCompress;"compress")
					
					ARRAY TEXT:C222($tt_HTTP_mimeTypes;0)
					ARRAY BOOLEAN:C223($tb_HTTP_mimeTypesCompress;0)
				End if 
				
				If (True:C214)
					ARRAY TEXT:C222($tt_HTTP_extMimeLookupExt;0)
					ARRAY TEXT:C222($tt_HTTP_extMimeLookupMime;0)
					
					HTTP__loadExtMimeLookup (->$tt_HTTP_extMimeLookupExt;->$tt_HTTP_extMimeLookupMime)
					
					ARRAY TO COLLECTION:C1563(Storage:C1525.http.mimeTypeLookup;\
						$tt_HTTP_extMimeLookupExt;"extension";\
						$tt_HTTP_extMimeLookupMime;"mimeType")
					
					ARRAY TEXT:C222($tt_HTTP_extMimeLookupExt;0)
					ARRAY TEXT:C222($tt_HTTP_extMimeLookupMime;0)
				End if 
				
				Storage:C1525.http.init:=True:C214
			End use 
		End if 
		
	End use 
	
End if 


//%attributes = {"shared":true,"preemptive":"capable","invisible":false}

  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_extensionToMime
  //@scope : public
  //@attributes : ThreadSafe   
  //@deprecated : no
  //@description : This function returns a mime type from an extension
  //@parameter[0-OUT-mime-TEXT] : mime (e.g. "image/jpeg")
  //@parameter[1-IN-extension-TEXT] : extension (e.g. ".jpg" or "jpg")
  //@notes : the method uses an xml file http_component.4dbase/Resources/extensionMimeLookup.xml
  //@example : HTTP_extensionToMime (".gif") => "image/gif"
  //
  //ASSERT(HTTP_extensionToMime (".gif")="image/gif")
  //ASSERT(HTTP_extensionToMime (".jpg")="image/jpeg")
  //ASSERT(HTTP_extensionToMime (".bmp")="image/bmp")
  //
  //@see : HTTP_mimeToImageCodec
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 10/11/2015, 11:09:33 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_mimeType)
C_TEXT:C284($1;$vt_extension)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_mimeType:=""
If (Count parameters:C259>0)
	$vt_extension:=$1
	
	If (Length:C16($vt_extension)>0)
		If (Substring:C12($vt_extension;1;1)#".")
			$vt_extension:="."+$vt_extension
		End if 
		
		ARRAY TEXT:C222($tt_extensionList;0)
		ARRAY TEXT:C222($tt_mimeList;0)
		
		HTTP__init 
		
		C_COLLECTION:C1488($co_mimeTypeLookup)
		$co_mimeTypeLookup:=Storage:C1525.http.mimeTypeLookup
		
		COLLECTION TO ARRAY:C1562($co_mimeTypeLookup;\
			$tt_extensionList;"extension";\
			$tt_mimeList;"mimeType")
		
		C_LONGINT:C283($vl_found)
		$vl_found:=Find in array:C230($tt_extensionList;$vt_extension)
		If ($vl_found>0)
			$vt_mimeType:=$tt_mimeList{$vl_found}
		End if 
		
		ARRAY TEXT:C222($tt_extensionList;0)
		ARRAY TEXT:C222($tt_mimeList;0)
		
	End if 
	
End if 
$0:=$vt_mimeType
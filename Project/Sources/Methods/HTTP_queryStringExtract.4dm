//%attributes = {"invisible":false,"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_queryStringExtract
  //@scope : public
  //@deprecated : no
  //@description : This function extracts a query string from a url (text after "?")
  //@parameter[0-OUT-queryString-TEXT] : query string
  //@parameter[1-IN-uri-TEXT] : uri or url
  //@notes :
  //@example : HTTP_queryStringExtract ("http://example.com/over/there?name=ferret")="name=ferret") 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 23/03/2015, 10:56:26 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_queryString)
C_TEXT:C284($1;$vt_uri)

$vt_queryString:=""
If (Count parameters:C259>0)
	$vt_uri:=$1
	
	C_LONGINT:C283($vl_pos)
	$vl_pos:=Position:C15("?";$vt_uri)
	If ($vl_pos>0)
		$vt_queryString:=Substring:C12($vt_uri;$vl_pos+1)
	End if 
	
End if 
$0:=$vt_queryString
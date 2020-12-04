//%attributes = {"shared":true,"preemptive":"capable"}

  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_statusMessageGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns an http status for a http status value
  //@parameter[0-OUT-httpStatusText-TEXT] : http status code (e.g. "OK")
  //@parameter[1-IN-httpStatusCode-LONGINT] : http status code (e.g. 200)
  //@notes :
  //@example : HTTP_statusMessageGet (200) => "OK"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 02/12/2020, 13:21:07 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_httpStatusMessage)
C_LONGINT:C283($1;$vl_httpStatusCode)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_httpStatusMessage:=""
If (Count parameters:C259>0)
	$vl_httpStatusCode:=$1
	
	Case of 
		: ($vl_httpStatusCode=200)
			$vt_httpStatusMessage:="OK"
			
		: ($vl_httpStatusCode=201)
			$vt_httpStatusMessage:="CREATED"
			
		: ($vl_httpStatusCode=202)
			$vt_httpStatusMessage:="ACCEPTED"
			
		: ($vl_httpStatusCode=203)
			$vt_httpStatusMessage:="PARTIAL INFORMATION"
			
		: ($vl_httpStatusCode=204)
			$vt_httpStatusMessage:="NO RESPONSE"
			
		: ($vl_httpStatusCode=205)
			$vt_httpStatusMessage:="RESET CONTENT"
			
		: ($vl_httpStatusCode=206)
			$vt_httpStatusMessage:="PARTIAL CONTENT"
			
		: ($vl_httpStatusCode=301)
			$vt_httpStatusMessage:="MOVED"
			
		: ($vl_httpStatusCode=302)
			$vt_httpStatusMessage:="FOUND"
			
		: ($vl_httpStatusCode=303)
			$vt_httpStatusMessage:="METHOD"
			
		: ($vl_httpStatusCode=304)
			$vt_httpStatusMessage:="NOT MODIFIED"
			
		: ($vl_httpStatusCode=400)
			$vt_httpStatusMessage:="BAD REQUEST"
			
		: ($vl_httpStatusCode=401)
			$vt_httpStatusMessage:="UNAUTHORIZED"
			
		: ($vl_httpStatusCode=402)
			$vt_httpStatusMessage:="PAYMENT REQUIRED"
			
		: ($vl_httpStatusCode=403)
			$vt_httpStatusMessage:="FORBIDDEN"
			
		: ($vl_httpStatusCode=404)
			$vt_httpStatusMessage:="NOT FOUND"
			
		: ($vl_httpStatusCode=500)
			$vt_httpStatusMessage:="INTERNAL ERROR"
			
		: ($vl_httpStatusCode=501)
			$vt_httpStatusMessage:="NOT IMPLEMENTED"
			
		: ($vl_httpStatusCode=502)
			$vt_httpStatusMessage:="BAD GATEWAY"
			
		: ($vl_httpStatusCode=503)
			$vt_httpStatusMessage:="SERVICE UNAVAILABLE"
			
		: ($vl_httpStatusCode=504)
			$vt_httpStatusMessage:="GATEWAY TIMEOUT"
			
		Else 
			$vt_httpStatusMessage:="UNKNOW STATUS ("+String:C10($vl_httpStatusCode)+")"
	End case 
	
	
	  //C_LONGINT($vl_found)
	  //$vl_found:=Find in array(<>te_HTTP_statusCode;$vl_httpStatusCode)
	  //If ($vl_found>0)
	  //$vt_httpStatusMessage:=<>tt_HTTP_statusMessage{$vl_found}
	  //Else 
	  //HTTP__moduleDebugDateTimeLine (2;Current method name;"http status "+String($vl_httpStatusCode)+" is unknown")
	  //End if 
	
End if 
$0:=$vt_httpStatusMessage

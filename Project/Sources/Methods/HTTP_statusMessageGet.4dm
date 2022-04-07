//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
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
  // https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
  // https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
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
		: ($vl_httpStatusCode=100)
			$vt_httpStatusMessage:="Continue"
			
		: ($vl_httpStatusCode=101)
			$vt_httpStatusMessage:="Switching Protocols"
			
		: ($vl_httpStatusCode=102)
			$vt_httpStatusMessage:="Processing"
			
		: ($vl_httpStatusCode=103)
			$vt_httpStatusMessage:="Early Hints"
			
			
			
		: ($vl_httpStatusCode=200)
			$vt_httpStatusMessage:="OK"
			
		: ($vl_httpStatusCode=201)
			$vt_httpStatusMessage:="Created"
			
		: ($vl_httpStatusCode=202)
			$vt_httpStatusMessage:="Accepted"
			
		: ($vl_httpStatusCode=203)
			$vt_httpStatusMessage:="Non-Authoritative Information"
			
		: ($vl_httpStatusCode=204)
			$vt_httpStatusMessage:="No Content"
			
		: ($vl_httpStatusCode=205)
			$vt_httpStatusMessage:="Reset Content"
			
		: ($vl_httpStatusCode=206)
			$vt_httpStatusMessage:="Partial Content"
			
		: ($vl_httpStatusCode=207)
			$vt_httpStatusMessage:="Multi-Status"
			
		: ($vl_httpStatusCode=208)
			$vt_httpStatusMessage:="Already Reported"
			
		: ($vl_httpStatusCode=226)
			$vt_httpStatusMessage:="IM Used"
			
			
			
			
			
		: ($vl_httpStatusCode=301)
			$vt_httpStatusMessage:="Moved Permanently"
			
		: ($vl_httpStatusCode=302)
			$vt_httpStatusMessage:="Found"
			
		: ($vl_httpStatusCode=303)
			$vt_httpStatusMessage:="See Other"
			
		: ($vl_httpStatusCode=304)
			$vt_httpStatusMessage:="Not Modified"
			
		: ($vl_httpStatusCode=305)
			$vt_httpStatusMessage:="Use Proxy"
			
		: ($vl_httpStatusCode=306)
			$vt_httpStatusMessage:="Switch Proxy (Unused)"
			
		: ($vl_httpStatusCode=307)
			$vt_httpStatusMessage:="Temporary Redirect"
			
		: ($vl_httpStatusCode=308)
			$vt_httpStatusMessage:="Permanent Redirect"
			
			
			
			
			
		: ($vl_httpStatusCode=400)
			$vt_httpStatusMessage:="Bad Request"
			
		: ($vl_httpStatusCode=401)
			$vt_httpStatusMessage:="Unauthorized"
			
		: ($vl_httpStatusCode=402)
			$vt_httpStatusMessage:="Payment Required"
			
		: ($vl_httpStatusCode=403)
			$vt_httpStatusMessage:="Forbidden"
			
		: ($vl_httpStatusCode=404)
			$vt_httpStatusMessage:="Not Found"
			
		: ($vl_httpStatusCode=405)
			$vt_httpStatusMessage:="Method Not Allowed"
			
		: ($vl_httpStatusCode=406)
			$vt_httpStatusMessage:="Not Acceptable"
			
		: ($vl_httpStatusCode=407)
			$vt_httpStatusMessage:="Proxy Authentication Required"
			
		: ($vl_httpStatusCode=408)
			$vt_httpStatusMessage:="Request Timeout"
			
		: ($vl_httpStatusCode=409)
			$vt_httpStatusMessage:="Conflict"
			
		: ($vl_httpStatusCode=410)
			$vt_httpStatusMessage:="Gone"
			
		: ($vl_httpStatusCode=411)
			$vt_httpStatusMessage:="Length Required"
			
		: ($vl_httpStatusCode=412)
			$vt_httpStatusMessage:="Precondition Failed"
			
		: ($vl_httpStatusCode=413)
			$vt_httpStatusMessage:="Request Entity Too Large"
			
		: ($vl_httpStatusCode=414)
			$vt_httpStatusMessage:="Request-URI Too Long"
			
		: ($vl_httpStatusCode=415)
			$vt_httpStatusMessage:="Unsupported Media Type"
			
		: ($vl_httpStatusCode=416)
			$vt_httpStatusMessage:="Requested Range Not Satisfiable"
			
		: ($vl_httpStatusCode=417)
			$vt_httpStatusMessage:="Expectation Failed"
			
		: ($vl_httpStatusCode=418)
			$vt_httpStatusMessage:="I'm a teapot"
			
		: ($vl_httpStatusCode=421)
			$vt_httpStatusMessage:="Misdirected Request"
			
		: ($vl_httpStatusCode=422)
			$vt_httpStatusMessage:="Unprocessable Entity"
			
		: ($vl_httpStatusCode=423)
			$vt_httpStatusMessage:="Locked"
			
		: ($vl_httpStatusCode=424)
			$vt_httpStatusMessage:="Failed Dependency"
			
		: ($vl_httpStatusCode=425)
			$vt_httpStatusMessage:="Too Early"
			
		: ($vl_httpStatusCode=426)
			$vt_httpStatusMessage:="Upgrade Required"
			
		: ($vl_httpStatusCode=428)
			$vt_httpStatusMessage:="Precondition Required"
			
		: ($vl_httpStatusCode=429)
			$vt_httpStatusMessage:="Too Many Requests"
			
		: ($vl_httpStatusCode=431)
			$vt_httpStatusMessage:="Request Header Fields Too Large"
			
		: ($vl_httpStatusCode=451)
			$vt_httpStatusMessage:="Unavailable For Legal Reasons"
			
			
			
		: ($vl_httpStatusCode=500)
			$vt_httpStatusMessage:="Internal Server Error"
			
		: ($vl_httpStatusCode=501)
			$vt_httpStatusMessage:="Not Implemented"
			
		: ($vl_httpStatusCode=502)
			$vt_httpStatusMessage:="Bad Gateway"
			
		: ($vl_httpStatusCode=503)
			$vt_httpStatusMessage:="Service Unavailable"
			
		: ($vl_httpStatusCode=504)
			$vt_httpStatusMessage:="Gateway Timeout"
			
		: ($vl_httpStatusCode=505)
			$vt_httpStatusMessage:="HTTP Version Not Supported"
			
		: ($vl_httpStatusCode=506)
			$vt_httpStatusMessage:="Variant Also Negotiates"
			
		: ($vl_httpStatusCode=507)
			$vt_httpStatusMessage:="Insufficient Storage"
			
		: ($vl_httpStatusCode=508)
			$vt_httpStatusMessage:="Loop Detected"
			
		: ($vl_httpStatusCode=510)
			$vt_httpStatusMessage:="Not Extended"
			
		: ($vl_httpStatusCode=511)
			$vt_httpStatusMessage:="Network Authentication Required"
			
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

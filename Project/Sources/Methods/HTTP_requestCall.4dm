//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_requestCall
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function calls an http request
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-INOUT-httpObject-OBJECT] : ParamDescription
  //@parameter[2-IN-requestBodyPtr-POINTER] : text, blob or object pointer (not modified)
  //@parameter[3-OUT-responseBodyPtr-POINTER] : text, blob or object pointer (modified)
  //@notes : 
  //@example : HTTP_requestCall (
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 11:32:00 - 1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_OBJECT:C1216($1;$vo_httpObject)
C_POINTER:C301($2;$vp_requestBodyPtr)
C_POINTER:C301($3;$vp_responseBodyPtr)
ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")

$vb_ok:=False:C215
If ($1#Null:C1517)
	
	$vo_httpObject:=$1
	$vp_requestBodyPtr:=$2
	$vp_responseBodyPtr:=$3
	
	C_LONGINT:C283($vl_requestBodyType;$vl_responseBodyType)
	$vl_requestBodyType:=Type:C295($vp_requestBodyPtr->)
	$vl_responseBodyType:=Type:C295($vp_responseBodyPtr->)
	
	C_BLOB:C604($vx_requestBodyBlob;$vx_responseBodyBlob)
	SET BLOB SIZE:C606($vx_requestBodyBlob;0)
	SET BLOB SIZE:C606($vx_responseBodyBlob;0)
	Case of 
		: ($vl_requestBodyType=Is BLOB:K8:12)
		: (($vl_requestBodyType=Is text:K8:3) | ($vl_requestBodyType=Is alpha field:K8:1))
		: ($vl_requestBodyType=Is object:K8:27)
		Else 
			$vp_requestBodyPtr:=->$vx_requestBodyBlob
	End case 
	Case of 
		: ($vl_responseBodyType=Is BLOB:K8:12)
		: (($vl_responseBodyType=Is text:K8:3) | ($vl_responseBodyType=Is alpha field:K8:1))
		: ($vl_responseBodyType=Is object:K8:27)
		Else 
			$vp_responseBodyPtr:=->$vx_responseBodyBlob
	End case 
	
	SET BLOB SIZE:C606($vx_requestBodyBlob;0)
	SET BLOB SIZE:C606($vx_responseBodyBlob;0)
	
	C_TEXT:C284($vt_url;$vt_verb)
	$vt_url:=$vo_httpObject.url
	$vt_verb:=$vo_httpObject.verb
	
	C_BOOLEAN:C305($vb_keepAlive)
	$vb_keepAlive:=$vo_httpObject.keepAlive
	
	ARRAY TEXT:C222($tt_headerKeys;0)
	ARRAY TEXT:C222($tt_headerValues;0)
	
	If (Not:C34($vb_keepAlive))  // explicit handling of the ""Connection" header
		HTTP_headerValueSet ($vo_httpObject.request.headers;"Connection";"close")
		  // http server will reply with : 
		  //  "Connection: close" (and close the connexion)
		  // if "keep-alive", it will respond with
		  //   "Connection: Keep-Alive"
	End if 
	
	C_TEXT:C284($vt_headerLine;$vt_key;$vt_value)
	For each ($vt_headerLine;$vo_httpObject.request.headers)
		$vt_key:=""
		$vt_value:=""
		If (HTTP_headerLineSplit ($vt_headerLine;->$vt_key;->$vt_value))
			APPEND TO ARRAY:C911($tt_headerKeys;$vt_key)
			APPEND TO ARRAY:C911($tt_headerValues;$vt_value)
		End if 
		$vt_key:=""
		$vt_value:=""
	End for each 
	
	
	HTTP SET OPTION:C1160(HTTP compression:K71:15;Choose:C955($vo_httpObject.options.compression;1;0))
	HTTP SET OPTION:C1160(HTTP display auth dial:K71:13;Choose:C955($vo_httpObject.options.displayAuthDial;1;0))
	HTTP SET OPTION:C1160(HTTP follow redirect:K71:11;Choose:C955($vo_httpObject.options.followRedirect;1;0))
	HTTP SET OPTION:C1160(HTTP max redirect:K71:12;$vo_httpObject.options.maxRedirect)
	HTTP SET OPTION:C1160(HTTP reset auth settings:K71:14;Choose:C955($vo_httpObject.options.resetAuthSettings;1;0))
	HTTP SET OPTION:C1160(HTTP timeout:K71:10;$vo_httpObject.options.httpTimeout)
	
	$vo_httpObject.start:=Timestamp:C1445
	C_LONGINT:C283($vl_durationMs)
	$vl_durationMs:=Milliseconds:C459
	
	C_LONGINT:C283(error;$vl_error)
	error:=0
	
	C_TEXT:C284($vt_onErrCall)
	$vt_onErrCall:=Method called on error:C704
	ON ERR CALL:C155("HTTP__errorHandler")
	
	C_LONGINT:C283($vl_status)
	If ($vb_keepAlive)
		$vl_status:=HTTP Request:C1158($vt_verb;$vt_url;$vp_requestBodyPtr->;$vp_responseBodyPtr->;$tt_headerKeys;$tt_headerValues;*)  // with "keep-alive"
	Else 
		$vl_status:=HTTP Request:C1158($vt_verb;$vt_url;$vp_requestBodyPtr->;$vp_responseBodyPtr->;$tt_headerKeys;$tt_headerValues)
	End if 
	
	$vl_error:=error
	
	Case of 
		: ($vl_error=0)
			
		: ($vl_error=17)  // https://kb.4d.com/assetid=78775
			HTTP__moduleDebugDateTimeLine (2;Current method name:C684;"error : "+String:C10($vl_error)+", status : "+String:C10($vl_status)+", http request : "+JSON Stringify:C1217($vo_httpObject)+" => retry (without keep-alive)")
			
			$vl_status:=HTTP Request:C1158($vt_verb;$vt_url;$vp_requestBodyPtr->;$vp_responseBodyPtr->;$tt_headerKeys;$tt_headerValues)
			
			$vl_error:=error
			HTTP__moduleDebugDateTimeLine (2;Current method name:C684;"error : "+String:C10($vl_error)+", status : "+String:C10($vl_status)+", http request : "+JSON Stringify:C1217($vo_httpObject))
			
		Else 
			HTTP__moduleDebugDateTimeLine (2;Current method name:C684;"error "+String:C10($vl_error)+", status : "+String:C10($vl_status)+", http request : "+JSON Stringify:C1217($vo_httpObject)+" => no retry")
	End case 
	
	$vb_ok:=($vl_error=0)
	
	ON ERR CALL:C155($vt_onErrCall)
	error:=0
	
	$vo_httpObject.status:=$vl_status
	$vo_httpObject.statusText:=HTTP_statusMessageGet ($vl_status)
	$vo_httpObject.error:=$vl_error
	
	C_LONGINT:C283($vl_durationMs)
	$vl_durationMs:=LONG_durationDifference ($vl_durationMs;Milliseconds:C459)
	$vo_httpObject.end:=Timestamp:C1445
	$vo_httpObject.duration:=$vl_durationMs/1000
	
	C_LONGINT:C283($i)
	C_TEXT:C284($vt_headerLine)
	For ($i;1;Size of array:C274($tt_headerKeys))
		$vt_headerLine:=HTTP_headerLineCombine ($tt_headerKeys{$i};$tt_headerValues{$i})
		If (Length:C16($vt_headerLine)>0)
			$vo_httpObject.response.headers.push($vt_headerLine)
		End if 
	End for 
	
	HTTP__moduleDebugDateTimeLine (Choose:C955($vb_ok;4;2);Current method name:C684;"error "+String:C10($vl_error)+", status : "+String:C10($vl_status)+\
		", http request : "+JSON Stringify:C1217($vo_httpObject)+\
		", request body size : "+HTTP__debugBodySize ($vp_requestBodyPtr)+\
		", response body size : "+HTTP__debugBodySize ($vp_responseBodyPtr)+\
		". "+Choose:C955($vb_ok;"[OK]";"[KO]"))
	
Else 
	HTTP__moduleDebugDateTimeLine (2;Current method name:C684;"$1 is null")
End if 
$0:=$vb_ok
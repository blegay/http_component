//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_requestNew
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function creates an http object for a 4D http request
  //@parameter[0-OUT-httpObject-OBJECT] : http object
  //@notes : 
  //@example : 
  //
  //  C_OBJECT($vo_httpObject)
  //  $vo_httpObject:=HTTP_requestNew (HTTP GET method;"https://www.rfc-editor.org/rfc/rfc1.txt")
  //
  //    //$vo_httpObject.request.headers.push("Accept-Encoding: gzip, deflate")
  //  $vo_httpObject.request.headers.push(HTTP_headerLineCombine ("Accept-Encoding";"gzip, deflate"))
  //
  //  C_TEXT($vt_requestBody;$vt_responseBody)
  //  If (HTTP_requestCall ($vo_httpObject;->$vt_requestBody;->$vt_responseBody))
  //    If ($vo_httpObject.status=200)
  //
  //    End if 
  //  End if 
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 11:26:47 - 1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_httpObject)

C_TEXT:C284($1;$vt_verb)
C_TEXT:C284($2;$vt_url)

HTTP__init 

$vo_httpObject:=New object:C1471

C_LONGINT:C283($vl_nbParams)
$vl_nbParams:=Count parameters:C259
Case of 
	: ($vl_nbParams=0)
		$vt_verb:="GET"
		$vt_url:="http://"
		
	: ($vl_nbParams=1)
		$vt_verb:=$1
		$vt_url:="http://"
		
	Else 
		  //: ($vl_nbParams=2)
		$vt_verb:=$1
		$vt_url:=$2
End case 

$vo_httpObject.verb:=$vt_verb
$vo_httpObject.url:=$vt_url

$vo_httpObject.request:=New object:C1471("headers";New collection:C1472("User-Agent: "+HTTP__userAgentString ))
$vo_httpObject.response:=New object:C1471("headers";New collection:C1472)

$vo_httpObject.keepAlive:=True:C214

$vo_httpObject.status:=0
$vo_httpObject.error:=0

$vo_httpObject.options:=New object:C1471

$vo_httpObject.options.compression:=False:C215
$vo_httpObject.options.displayAuthDial:=False:C215
$vo_httpObject.options.followRedirect:=True:C214
$vo_httpObject.options.maxRedirect:=3
$vo_httpObject.options.resetAuthSettings:=False:C215
$vo_httpObject.options.httpTimeout:=120  // seconds

$0:=$vo_httpObject
//%attributes = {"shared":false,"invisible":true}

  // https://oauth.net/2/grant-types/authorization-code/
  // client_id : "EZM-UgHLz9mCAM9Xwa9n0FvK"
  // client_secret : RO32LbUQNLyNklveftR_cs6uybzw7T8Q7n1xVaZ9W49bBZPS
  // login : precious-crane@example.com
  // password : Breakable-Fish-18

C_TEXT:C284($vt_login;$vt_password)
$vt_login:="precious-crane@example.com"
$vt_password:="Breakable-Fish-18"

If (False:C215)  // step 1
	C_TEXT:C284($vt_url;$vt_requestBody;$vt_responseBody)
	If (False:C215)
		$vt_url:="https://authorization-server.com/authorize?"+\
			"response_type=code"+\
			"&client_id=EZM-UgHLz9mCAM9Xwa9n0FvK"+\
			"&redirect_uri=https://www.oauth.com/playground/authorization-code.html"+\
			"&scope=photo+offline_access"+\
			"&state=FFDlUK1ZYDbQbDBk"
	End if 
	
	C_OBJECT:C1216($vo_queryStringParameters)
	$vo_queryStringParameters:=New object:C1471
	$vo_queryStringParameters.response_type:="code"
	$vo_queryStringParameters.client_id:="EZM-UgHLz9mCAM9Xwa9n0FvK"
	$vo_queryStringParameters.redirect_uri:="https://www.oauth.com/playground/authorization-code.html"
	$vo_queryStringParameters.scope:="photo+offline_access"
	$vo_queryStringParameters.state:="FFDlUK1ZYDbQbDBk"
	
	C_TEXT:C284($vt_url;$vt_queryString)
	$vt_queryString:=HTTP_queryStringStringify ($vo_queryStringParameters)
	$vt_url:="https://authorization-server.com/authorize"+$vt_queryString
	
	  // state is a random string used 
	
	ARRAY TEXT:C222($tt_headersKey;0)
	ARRAY TEXT:C222($tt_headersValue;0)
	
	  //C_LONGINT($vl_status)
	  //$vl_status:=HTTP Request(HTTP POST method;$vt_url;$vt_requestBody;$vt_responseBody;$tt_headersKey;$tt_headersValue)
	
	  // ALERT(String($vl_status)+"\r"+$vt_responseBody)
	
	  // Here display a web area with this url
	  // users enters login and password and the site will (on success)
	  // redirect (here, same site cf redirect_uri) with additionnal parameters in the query string
	  // we need to check "state" matches our radom generated "state"
	  // and keep the "code" for further use
	
	  //"?state=FFDlUK1ZYDbQbDBk&code=fxizYvUTwOxxOBVrAVm3D_tROPMpxVEE9IEnD3_hD1Tfp3zc"
	
	
End if 

If (True:C214)  // step2
	
	  // POST https://authorization-server.com/token
	  // 
	  // grant_type=authorization_code
	  // &client_id=EZM-UgHLz9mCAM9Xwa9n0FvK
	  // &client_secret=RO32LbUQNLyNklveftR_cs6uybzw7T8Q7n1xVaZ9W49bBZPS
	  // &redirect_uri=https://www.oauth.com/playground/authorization-code.html
	  // &code=fxizYvUTwOxxOBVrAVm3D_tROPMpxVEE9IEnD3_hD1Tfp3zc
	
	C_TEXT:C284($vt_url;$vt_requestBody;$vt_responseBody)
	$vt_url:="https://authorization-server.com/token"
	
	C_OBJECT:C1216($vo_formParameters)
	$vo_formParameters:=New object:C1471
	$vo_formParameters.grant_type:="authorization_code"
	$vo_formParameters.client_id:="EZM-UgHLz9mCAM9Xwa9n0FvK"
	$vo_formParameters.client_secret:="RO32LbUQNLyNklveftR_cs6uybzw7T8Q7n1xVaZ9W49bBZPS"
	$vo_formParameters.redirect_uri:="https://www.oauth.com/playground/authorization-code.html"
	$vo_formParameters.code:="fxizYvUTwOxxOBVrAVm3D_tROPMpxVEE9IEnD3_hD1Tfp3zc"
	
	$vt_requestBody:=HTTP_wwwFormUrlStringify ($vo_formParameters)
	
	$vt_requestBody:="grant_type=authorization_code"+\
		"&client_id=EZM-UgHLz9mCAM9Xwa9n0FvK"+\
		"&client_secret=RO32LbUQNLyNklveftR_cs6uybzw7T8Q7n1xVaZ9W49bBZPS"+\
		"&redirect_uri=https://www.oauth.com/playground/authorization-code.html"+\
		"&code=fxizYvUTwOxxOBVrAVm3D_tROPMpxVEE9IEnD3_hD1Tfp3zc"
	
	  // 
	ALERT:C41($vt_requestBody)
	
	ARRAY TEXT:C222($tt_headersKey;0)
	ARRAY TEXT:C222($tt_headersValue;0)
	APPEND TO ARRAY:C911($tt_headersKey;"Content-Type")
	APPEND TO ARRAY:C911($tt_headersValue;"application/x-www-form-urlencoded")
	APPEND TO ARRAY:C911($tt_headersKey;"Accept")
	APPEND TO ARRAY:C911($tt_headersValue;"application/json")
	
	HTTP SET OPTION:C1160(HTTP follow redirect:K71:11;1)
	
	HTTP AUTHENTICATE:C1161($vt_login;$vt_password;HTTP basic:K71:8)
	C_LONGINT:C283($vl_status)
	$vl_status:=HTTP Request:C1158(HTTP POST method:K71:2;$vt_url;$vt_requestBody;$vt_responseBody;$tt_headersKey;$tt_headersValue)
	
	  // 302 => "https://oauth2simplified.com/"
	
	  //$vt_url:="https://oauth2simplified.com/"
	  //ARRAY TEXT($tt_headersKey;0)
	  //ARRAY TEXT($tt_headersValue;0)
	  //APPEND TO ARRAY($tt_headersKey;"Content-Type")
	  //APPEND TO ARRAY($tt_headersValue;"application/x-www-form-urlencoded")
	  //$vl_status:=HTTP Request(HTTP POST method;$vt_url;$vt_requestBody;$vt_responseBody;$tt_headersKey;$tt_headersValue)
	
	
	ALERT:C41(String:C10($vl_status)+"\r"+$vt_responseBody)
	
End if 

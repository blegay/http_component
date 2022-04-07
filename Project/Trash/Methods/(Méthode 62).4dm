//%attributes = {"shared":false,"invisible":true}


C_TEXT:C284($vt_url;$vt_requestBody;$vt_responseBody)
$vt_url:="https://test-api.service.hmrc.gov.uk/oauth/token"

C_OBJECT:C1216($vo_formParameters)
$vo_formParameters:=New object:C1471
$vo_formParameters.grant_type:="client_credentials"
$vo_formParameters.client_id:=434341791131
$vo_formParameters.client_secret:="rbQe4c8jm12z"
  //$vo_formParameters.redirect_uri:=$vt_url
  //$vo_formParameters.code:="???"



$vt_requestBody:=HTTP_wwwFormUrlStringify ($vo_formParameters)
ALERT:C41($vt_requestBody)

ARRAY TEXT:C222($tt_headersKey;0)
ARRAY TEXT:C222($tt_headersValue;0)
APPEND TO ARRAY:C911($tt_headersKey;"Content-Type")
APPEND TO ARRAY:C911($tt_headersValue;"application/x-www-form-urlencoded")

C_LONGINT:C283($vl_status)
$vl_status:=HTTP Request:C1158(HTTP POST method:K71:2;$vt_url;$vt_requestBody;$vt_responseBody;$tt_headersKey;$tt_headersValue)

ALERT:C41(String:C10($vl_status)+"\r"+$vt_responseBody)

  // curl -i -H 'Content-Type: application/x-www-form-urlencoded' -X POST 'https://docs-test.apigee.net/oauth/accesstoken' -d 'grant_type=client_credentials&client_id=ns4fQc14Zg4hKFCNaSzArVuwszX95X&client_secret=ZIjFyTsNgQNyxI'
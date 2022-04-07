//%attributes = {"shared":false,"invisible":true}

$vt_url:=HTTP_urlEncode ("Test 4D+ITK éàèù")  // Test%204D%2BITK%20%C3%A9%C3%A0%C3%A8%C3%B9

ALERT:C41(HTTP_urlDecode ($vt_url))  //"Test+4D%2BITK+%E9%E0%E8%F9"))
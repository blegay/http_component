//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_urlDecode
  //@scope : public 
  //@deprecated : no
  //@description : This function returns a url decoded
  //@parameter[0-OUT-urlOut-TEXT] : decoded url
  //@parameter[1-IN-urlIn-TEXT] : encode url
  //@notes :
  //@example : HTTP_urlDecode 
  //@see : 
  // https://en.wikipedia.org/wiki/Percent-encoding
  // HTTP_urlEncode
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 19/04/2016, 12:05:56 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_urlOut)
C_TEXT:C284($1;$vt_urlIn)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_urlOut:=""
If (Count parameters:C259>0)
	$vt_urlIn:=$1
	
	If (Length:C16($vt_urlIn)>0)
		C_TEXT:C284($vt_url)
		$vt_url:=$vt_urlIn
		
		  // hard coded : replace "+" in Url which is a substribtute to space
		$vt_url:=Replace string:C233($vt_url;"+";" ";*)
		
		  // get a group of consecutive "%xx" where "xx" are hexadecimal characters
		C_TEXT:C284($vt_regexPattern)
		$vt_regexPattern:="(?:%[[:xdigit:]][[:xdigit:]])+"  // this is a non-capturing group made of "%" followed by two hexadecimal characters, repeated one or more times
		
		C_TEXT:C284($vt_escaped;$vt_unescaped)
		C_LONGINT:C283($vl_start;$vl_pos;$vl_length)
		$vl_start:=1
		While (Match regex:C1019($vt_regexPattern;$vt_url;$vl_start;$vl_pos;$vl_length))
			
			$vt_escaped:=Substring:C12($vt_url;$vl_pos;$vl_length)  // e.g. "%e2%82%ac"
			$vt_escaped:=Replace string:C233($vt_escaped;"%";"";*)  // e.g. "e282ac"
			
			  // remove the encoded string from the url
			$vt_url:=Delete string:C232($vt_url;$vl_pos;$vl_length)
			
			C_BLOB:C604($vx_blob)
			SET BLOB SIZE:C606($vx_blob;0)
			HEX_hexTextToBlob ($vt_escaped;->$vx_blob)
			$vt_unescaped:=Convert to text:C1012($vx_blob;"UTF-8")
			SET BLOB SIZE:C606($vx_blob;0)
			
			  // insert the decoded string in the url
			$vt_url:=Insert string:C231($vt_url;$vt_unescaped;$vl_pos)
			
			$vl_start:=$vl_pos+Length:C16($vt_unescaped)  //start after the inserted decoded string
		End while 
		
		$vt_urlOut:=$vt_url
	End if 
	
End if 
$0:=$vt_urlOut
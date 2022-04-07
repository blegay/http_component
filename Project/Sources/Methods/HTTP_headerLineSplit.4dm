//%attributes = {"invisible":false,"shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_headerLineSplit
  //@scope : public
  //@deprecated : no
  //@description : This function splits a header line into a key/value pair
  //@parameter[0-OUT-ok-BOOLEAN] : True if ok, false otherwise
  //@parameter[1-IN-headerLine-TEXT] : http header line
  //@parameter[2-OUT-keyPtr-POINTER] : key pointer (modified)
  //@parameter[3-OUT-valuePtr-POINTER] : value pointer (modified)
  //@notes :
  //@example : 
  //  HTTP_headerLineSplit ("HTTP/1.0 200 OK";->$vt_key;->$vt_value) => $vt_key="HTTP/1.0", $vt_value="200 OK"
  //  HTTP_headerLineSplit ("Age: 272";->$vt_key;->$vt_value) => $vt_key="Age", $vt_value="272"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 09/09/2013, 11:13:52 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)  //ok
C_TEXT:C284($1;$vt_httpHeaderLine)  //header line
C_POINTER:C301($2;$vp_keyPtr)  //key pointer
C_POINTER:C301($3;$vp_valuePtr)  //value pointer

$vb_ok:=False:C215
ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(Type:C295($2->)=Is text:K8:3;"$2 should be a text pointer")
ASSERT:C1129(Type:C295($3->)=Is text:K8:3;"$3 should be a text pointer")

$vt_httpHeaderLine:=$1  //header line
$vp_keyPtr:=$2
$vp_valuePtr:=$3


C_TEXT:C284($vt_key;$vt_value)
$vt_key:=""
$vt_value:=""

If (Length:C16($vt_httpHeaderLine)>0)
	
	  // a ":" or a "whitespace" followed by 0 or more white spaces
	C_TEXT:C284($vt_pattern)
	$vt_pattern:="(:|\\s)\\s*"
	
	  // HTTP/1.1 200 OK
	  // Transfer-Encoding: chunked
	
	C_LONGINT:C283($vl_pos;$vl_length)
	If (Match regex:C1019($vt_pattern;$vt_httpHeaderLine;1;$vl_pos;$vl_length))
		$vt_key:=Substring:C12($vt_httpHeaderLine;1;$vl_pos-1)
		$vt_value:=Substring:C12($vt_httpHeaderLine;$vl_pos+$vl_length)
		$vb_ok:=True:C214
	Else 
		$vt_key:=$vt_httpHeaderLine
		$vt_value:=""
	End if 
	
End if 

$vp_keyPtr->:=$vt_key
$vp_valuePtr->:=$vt_value

$0:=$vb_ok
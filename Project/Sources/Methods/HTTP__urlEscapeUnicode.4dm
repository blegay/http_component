//%attributes = {"invisible":true,"preemptive":"capable"}

  //================================================================================
  //@xdoc-start : en
  //@name : HTTP__urlEscapeUnicode
  //@scope : public
  //@deprecated : no
  //@description : This function returns character url escaped for a given unicode character code
  //@parameter[0-OUT-unicodeEscaped-TEXT] : character url escaped
  //@parameter[1-IN-unicode-LONGINT] : unicode character code
  //@notes :
  //@example : 
  //  HTTP__urlEscapeUnicode (32) => "%20" 
  //  HTTP__urlEscapeUnicode ("é") => "%C3%A9" 
  //  HTTP__urlEscapeUnicode (233) => "%C3%A9" 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 17/04/2016, 08:21:17 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_unicodeEscaped)
C_LONGINT:C283($1;$vl_unicode)

$vt_unicodeEscaped:=""
If (Count parameters:C259>0)
	$vl_unicode:=$1
	
	C_BLOB:C604($vx_blob)
	SET BLOB SIZE:C606($vx_blob;0)
	CONVERT FROM TEXT:C1011(Char:C90($vl_unicode);"utf-8";$vx_blob)
	
	C_LONGINT:C283($vl_offset)
	For ($vl_offset;0;BLOB size:C605($vx_blob)-1)
		C_LONGINT:C283($vl_byte)
		$vl_byte:=$vx_blob{$vl_offset}
		$vt_unicodeEscaped:=$vt_unicodeEscaped+"%"+HEX_byteToHexStr ($vl_byte)
	End for 
	
	SET BLOB SIZE:C606($vx_blob;0)
	
End if 
$0:=$vt_unicodeEscaped

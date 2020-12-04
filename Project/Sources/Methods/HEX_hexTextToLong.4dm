//%attributes = {"invisible":true,"shared":false}

  //0x7FFFFFFFF =>  2 147 483 647
  //0xFFFFFFFFF => -1
  //0x7F0000000 =>  2 130 706 432
  //0xFF0000000 => -16 777 216
  //0x0000000FF =>  255
  //0xFF        =>  255
  //0xF         =>  15

C_LONGINT:C283($0;$vl_long)
C_TEXT:C284($1;$vt_hex)

$vl_long:=0
If (Count parameters:C259>0)
	$vt_hex:=$1
	
	C_TEXT:C284($vt_hexChar)
	C_LONGINT:C283($vl_shift;$vl_pos)
	$vl_shift:=0
	For ($vl_pos;Length:C16($vt_hex);1;-1)
		
		$vt_hexChar:=$vt_hex[[$vl_pos]]
		If ($vt_hex#"0")
			  //shift 0, 4, 8, 12, 16, 20, 24 and 28
			$vl_long:=$vl_long | (HEX_hexCharToInt ($vt_hexChar) << $vl_shift)
		End if 
		
		$vl_shift:=$vl_shift+4
		
		  //0 4 8 12 16 20 24 28 (not over 28)
		If ($vl_shift>28)  //exit when we get 32
			$vl_pos:=0
		End if 
		
	End for 
	
End if 
$0:=$vl_long

//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : HEX_hexTextToBlob
  //@scope : public 
  //@deprecated : no
  //@description : This method converts some hexadecimal data into blob raw data 
  //@parameter[1-IN-hexadecimal-TEXT] : hexa decimal data
  //@parameter[2-OUT-blobPtr-POINTER] : blob pointer (modified)
  //@notes :
  //@example : HEX_hexTextToBlob 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 20/11/2012, 12:00:12 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($1;$vt_hexData)
C_POINTER:C301($2;$vp_blobData)

If (Count parameters:C259>1)
	$vt_hexData:=$1
	$vp_blobData:=$2
	
	$vt_hexData:=Replace string:C233($vt_hexData;" ";"";*)
	$vt_hexData:=Replace string:C233($vt_hexData;"-";"";*)
	$vt_hexData:=Replace string:C233($vt_hexData;"%";"";*)
	$vt_hexData:=Replace string:C233($vt_hexData;"\r";"";*)
	$vt_hexData:=Replace string:C233($vt_hexData;"\n";"";*)
	$vt_hexData:=Replace string:C233($vt_hexData;"\t";"";*)
	
	If (Type:C295($vp_blobData->)=Is BLOB:K8:12)
		C_LONGINT:C283($vl_textLength)
		$vl_textLength:=Length:C16($vt_hexData)
		
		
		SET BLOB SIZE:C606($vp_blobData->;0)
		SET BLOB SIZE:C606($vp_blobData->;$vl_textLength\2;0x00FF)
		
		If (LONG_isEven ($vl_textLength))
			
			C_LONGINT:C283($i;$vl_offset)
			C_TEXT:C284($vt_hex)
			
			$vl_offset:=0
			For ($i;1;$vl_textLength;2)
				$vt_hex:=Substring:C12($vt_hexData;$i;2)
				
				$vp_blobData->{$vl_offset}:=HEX_hexByteStrToByteInteger ($vt_hex)
				
				$vl_offset:=$vl_offset+1
			End for 
			
		End if 
		
	End if 
	
End if 


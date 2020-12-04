//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : BLB_appendText
  //@scope : public 
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-bufferBlobPtr-POINTER] : buffer blob pointer (modified)
  //@parameter[2-IN-encoding-TEXT] : encoding (optional, default value : "utf-8")
  //@notes :
  //@example : BLB_appendText 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 11/09/2015, 16:55:13 - v1.00.00
  //@xdoc-end
  //================================================================================

C_POINTER:C301($1;$vp_blobPtr)
C_TEXT:C284($2;$vt_buffer)
C_TEXT:C284($3;$vt_encoding)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vp_blobPtr:=$1
	$vt_buffer:=$2
	
	Case of 
		: ($vl_nbParam=2)
			$vt_encoding:="utf-8"
			
		Else 
			$vt_encoding:=$3
	End case 
	
	If (Type:C295($vp_blobPtr->)=Is BLOB:K8:12)
		
		If (Length:C16($vt_buffer)>0)
			
			C_BLOB:C604($vx_buffer)
			SET BLOB SIZE:C606($vx_buffer;0)
			CONVERT FROM TEXT:C1011($vt_buffer;$vt_encoding;$vx_buffer)
			
			C_LONGINT:C283($vl_nbBytesToCopy)
			$vl_nbBytesToCopy:=BLOB size:C605($vx_buffer)
			If ($vl_nbBytesToCopy>0)
				
				C_LONGINT:C283($vl_srcOffset)
				$vl_srcOffset:=0
				
				C_LONGINT:C283($vl_dstOffset)
				$vl_dstOffset:=BLOB size:C605($vp_blobPtr->)
				
				COPY BLOB:C558($vx_buffer;$vp_blobPtr->;$vl_srcOffset;$vl_dstOffset;$vl_nbBytesToCopy)
				
			End if 
			SET BLOB SIZE:C606($vx_buffer;0)
			
		End if 
		
	End if 
	
End if 
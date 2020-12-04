//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : BLB_append
  //@scope : public 
  //@deprecated : no
  //@description : this method is used to copy/append a blob ($2) at the end of another blob ($1) 
  //@parameter[1-IN-blobPtr-POINTER] : blob pointer (modified)
  //@parameter[2-IN-blobToAddPtr-POINTER] : blob to add pointer (not modified)
  //@notes :
  //@example : BLB_append 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 19/01/2009, 20:11:24 - v1.00.00
  //@xdoc-end
  //================================================================================

C_POINTER:C301($1;$vp_blobMainPtr)  //blob where we want to append data (at the end)
C_POINTER:C301($2;$vp_blobAdditionPtr)  //blob to add at the end of the first blob

If (Count parameters:C259>1)
	
	$vp_blobMainPtr:=$1
	$vp_blobAdditionPtr:=$2
	
	If ((Type:C295($vp_blobMainPtr->)=Is BLOB:K8:12) & (Type:C295($vp_blobAdditionPtr->)=Is BLOB:K8:12))
		
		C_LONGINT:C283($vl_nbBytesToCopy)
		$vl_nbBytesToCopy:=BLOB size:C605($vp_blobAdditionPtr->)
		
		If ($vl_nbBytesToCopy>0)
			
			C_LONGINT:C283($vl_srcOffset)
			$vl_srcOffset:=0
			
			C_LONGINT:C283($vl_dstOffset)
			$vl_dstOffset:=BLOB size:C605($vp_blobMainPtr->)
			
			  //adding all the bytes of blobAddition (starting at offset 0) at the end of blobMain
			COPY BLOB:C558($vp_blobAdditionPtr->;$vp_blobMainPtr->;$vl_srcOffset;$vl_dstOffset;$vl_nbBytesToCopy)
			
		End if 
		
	End if 
	
End if 

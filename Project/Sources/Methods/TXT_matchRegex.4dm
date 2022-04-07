//%attributes = {"shared":false,"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : TXT_matchRegex
  //@scope : public
  //@deprecated : no
  //@description : This function is a wrapper on Match Regex. 
  //@parameter[0-OUT-found-BOOLEAN] : true id pattern matches, False otherwise
  //@parameter[1-IN-regexPattern-TEXT] : regex pattern
  //@parameter[2-IN-textPtr-POINTER] : text pointer (not modified)
  //@parameter[3-IN-start-LONGINT] : start position, between 1 and text length (optional, default value : 1)
  //@parameter[4-OUT-positionPtr-POINTER] : position longint or longint array pointer (optional, modified)
  //@parameter[5-OUT-lengthPtr-POINTER] : length longint or longint array pointer (optional, modified)
  //@parameter[6-IN-searchAtPositionOnly-BOOLEAN] : search at start position only (optional, default value : False)
  //@notes :
  //  This functions prevents the U_INDEX_OUTOFBOUNDS_ERROR errors if (start < 1) or (start > length+1)
  //  U_INDEX_OUTOFBOUNDS_ERROR seen in 4D v11r9, 4D v12.3, 4D v12.4 
  //  If start<1 => start=1
  //  If start>length => returns false without trying to match the regex
  //@example : TXT_matchRegex 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 04/09/2012, 10:24:27 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_found)  //found
C_TEXT:C284($1;$vt_pattern)  //regex pattern
C_POINTER:C301($2;$vp_textPtr)  //text pointer
C_LONGINT:C283($3;$vl_start)  //start position
C_POINTER:C301($4;$vp_posPtr)  //position pointer
C_POINTER:C301($5;$vp_lenPtr)  //length pointer
C_BOOLEAN:C305($6;$vb_searchAtPositionOnly)  //search at position only

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vt_pattern:=$1
	$vp_textPtr:=$2
	
	Case of 
		: ($vl_nbParam=2)
			$vl_start:=1
			$vb_searchAtPositionOnly:=False:C215
			
		: ($vl_nbParam=3)
			$vl_start:=$3
			$vb_searchAtPositionOnly:=False:C215
			
		: ($vl_nbParam=4)
			$vl_start:=$3
			$vp_posPtr:=$4
			$vb_searchAtPositionOnly:=False:C215
			
		: ($vl_nbParam=5)
			$vl_start:=$3
			$vp_posPtr:=$4
			$vp_lenPtr:=$5
			$vb_searchAtPositionOnly:=False:C215
			
		Else 
			  //: ($vl_nbParam=6)
			$vl_start:=$3
			$vp_posPtr:=$4
			$vp_lenPtr:=$5
			$vb_searchAtPositionOnly:=$6
	End case 
	
	C_LONGINT:C283($vl_type)
	
	If (True:C214)  //verification du pointeur sur position
		C_LONGINT:C283($vl_pos)
		$vl_pos:=0
		If (Not:C34(Is nil pointer:C315($vp_posPtr)))
			
			$vl_type:=Type:C295($vp_posPtr->)
			Case of 
				: ($vl_type=Is longint:K8:6)
					$vp_posPtr->:=0
					
				: ($vl_type=Is integer:K8:5)
					$vp_posPtr->:=0
					
				: ($vl_type=Is integer 64 bits:K8:25)
					$vp_posPtr->:=0
					
				: ($vl_type=Is real:K8:4)
					$vp_posPtr->:=0
					
				: ($vl_type=LongInt array:K8:19)
					CLEAR VARIABLE:C89($vp_posPtr->)
					
				: ($vl_type=Integer array:K8:18)
					CLEAR VARIABLE:C89($vp_posPtr->)
					
				: ($vl_type=Real array:K8:17)
					CLEAR VARIABLE:C89($vp_posPtr->)
					
				Else 
					CLEAR VARIABLE:C89($vp_posPtr->)
					$vp_posPtr:=->$vl_pos
			End case 
			
		Else 
			$vp_posPtr:=->$vl_pos
		End if 
	End if 
	
	If (True:C214)  //verification du pointeur sur length
		C_LONGINT:C283($vl_length)
		$vl_length:=0
		If (Not:C34(Is nil pointer:C315($vp_lenPtr)))
			
			$vl_type:=Type:C295($vp_lenPtr->)
			Case of 
				: ($vl_type=Is longint:K8:6)
					$vp_lenPtr->:=0
				: ($vl_type=Is integer:K8:5)
					$vp_lenPtr->:=0
					
				: ($vl_type=Is integer 64 bits:K8:25)
					$vp_lenPtr->:=0
					
				: ($vl_type=Is real:K8:4)
					$vp_lenPtr->:=0
					
				: ($vl_type=LongInt array:K8:19)
					CLEAR VARIABLE:C89($vp_lenPtr->)
					
				: ($vl_type=Integer array:K8:18)
					CLEAR VARIABLE:C89($vp_lenPtr->)
					
				: ($vl_type=Real array:K8:17)
					CLEAR VARIABLE:C89($vp_lenPtr->)
					
				Else 
					CLEAR VARIABLE:C89($vp_lenPtr->)
					$vp_lenPtr:=->$vl_length
			End case 
			
		Else 
			$vp_lenPtr:=->$vl_length
		End if 
	End if 
	
	$vl_type:=Type:C295($vp_textPtr->)
	If (($vl_type=Is alpha field:K8:1) | ($vl_type=Is text:K8:3))
		
		C_LONGINT:C283($vl_textLength)
		$vl_textLength:=Length:C16($vp_textPtr->)
		If ($vl_textLength>0)
			
			If ($vl_start<1)  //prevent U_INDEX_OUTOFBOUNDS_ERROR
				$vl_start:=1
			End if 
			
			If ($vl_start<=$vl_textLength)  //prevent U_INDEX_OUTOFBOUNDS_ERROR
				
				If ($vb_searchAtPositionOnly)
					
					  //Au cas ou 
					  //: ($vl_nbParam>4)
					$vb_found:=Match regex:C1019($vt_pattern;$vp_textPtr->;$vl_start;$vp_posPtr->;$vp_lenPtr->;*)
					
					  //: ($vl_nbParam=4)
					  //$vb_found:=Trouver regex($vt_pattern;$vp_textPtr->;$vl_start;$vp_posPtr->;*)
					  //
					  //: ($vl_nbParam=3)
					  //$vb_found:=Trouver regex($vt_pattern;$vp_textPtr->;$vl_start;*)
					  //
					  //Sinon 
					  //  `: ($vl_nbParam=2)
					  //$vb_found:=Trouver regex($vt_pattern;$vp_textPtr->;*)
					  //Fin de cas 
					
				Else 
					
					Case of 
						: ($vl_nbParam>4)
							$vb_found:=Match regex:C1019($vt_pattern;$vp_textPtr->;$vl_start;$vp_posPtr->;$vp_lenPtr->)
							
						: ($vl_nbParam=4)
							$vb_found:=Match regex:C1019($vt_pattern;$vp_textPtr->;$vl_start;$vp_posPtr->)
							
						: ($vl_nbParam=3)
							$vb_found:=Match regex:C1019($vt_pattern;$vp_textPtr->;$vl_start)
							
						Else 
							  //: ($vl_nbParam=2)
							$vb_found:=Match regex:C1019($vt_pattern;$vp_textPtr->)
					End case 
					
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End if 
$0:=$vb_found

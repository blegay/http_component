//%attributes = {"shared":false,"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : TXT_replaceRegex
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-textOut-TEXT] : text with replace applied
  //@parameter[1-IN-textIn-TEXT] : text
  //@parameter[2-IN-regex-TEXT] : regex pattern
  //@parameter[3-IN-replaceWith-TEXT] : replaceWith (optional, default value : "")
  //@parameter[4-IN-start-LONGINT] : start position (optional, default value : 1)
  //@parameter[5-IN-maxReplace-LONGINT] : max replace (optional, default replace all)
  //@notes :
  //@example : TXT_replaceRegex 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 31/08/2012, 00:37:17 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_out)  //text out
C_TEXT:C284($1;$vt_in)  //text in
C_TEXT:C284($2;$vt_pattern)  //pattern
C_TEXT:C284($3;$vt_replaceWith)  //replaceWith
C_LONGINT:C283($4;$vl_start)  //start
C_BOOLEAN:C305($5;$vb_searchAtPositionOnly)  //search at position only
C_LONGINT:C283($6;$vl_maxReplace)  //maxReplace

$vt_out:=""

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vt_in:=$1
	$vt_pattern:=$2
	
	  //initialise the local variables for parameters
	Case of 
		: ($vl_nbParam=2)
			$vt_replaceWith:=""
			$vl_start:=1
			$vb_searchAtPositionOnly:=False:C215
			  //$vl_maxReplace:=
			
		: ($vl_nbParam=3)
			$vt_replaceWith:=$3
			$vl_start:=1
			$vb_searchAtPositionOnly:=False:C215
			  //$vl_maxReplace:=
			
		: ($vl_nbParam=4)
			$vt_replaceWith:=$3
			$vl_start:=$4
			$vb_searchAtPositionOnly:=False:C215
			  //$vl_maxReplace:=
			
		: ($vl_nbParam=5)
			$vt_replaceWith:=$3
			$vl_start:=$4
			$vb_searchAtPositionOnly:=$5
			  //$vl_maxReplace:=
			
		Else 
			  //: ($vl_nbParam=6)
			$vt_replaceWith:=$3
			$vl_start:=$4
			$vb_searchAtPositionOnly:=$5
			$vl_maxReplace:=$6
	End case 
	
	If (Length:C16($vt_in)>0)  //check that it is not an empty string
		$vt_out:=$vt_in
		
		  //if start > length+1, then we get a regex error U_INDEX_OUTOFBOUNDS_ERROR (in 4D v11r9, 4D v12.3, 4D v12.4)
		If ($vl_start<=Length:C16($vt_out))
			
			C_LONGINT:C283($vl_replaceWithLength)
			$vl_replaceWithLength:=Length:C16($vt_replaceWith)
			
			C_BOOLEAN:C305($vb_nbMaxReplaceReached)
			$vb_nbMaxReplaceReached:=False:C215
			
			C_LONGINT:C283($vl_replaceCount)
			$vl_replaceCount:=0
			
			C_LONGINT:C283($vl_pos;$vl_length)
			  //Tant que (Trouver regex($vt_pattern;$vt_out;$vl_start;$vl_pos;$vl_length) & Non($vb_nbMaxReplaceReached))
			While (TXT_matchRegex ($vt_pattern;->$vt_out;$vl_start;->$vl_pos;->$vl_length;$vb_searchAtPositionOnly) & Not:C34($vb_nbMaxReplaceReached))
				$vl_replaceCount:=$vl_replaceCount+1  //found another match
				
				If ($vl_nbParam>5)  //we are checking against maxReplace
					$vb_nbMaxReplaceReached:=($vl_replaceCount>$vl_maxReplace)
				End if 
				
				If (Not:C34($vb_nbMaxReplaceReached))
					
					  //remove the string found
					$vt_out:=Delete string:C232($vt_out;$vl_pos;$vl_length)
					
					If ($vl_replaceWithLength>0)  //if there is a replaceWith text insert it
						$vt_out:=Insert string:C231($vt_out;$vt_replaceWith;$vl_pos)
					End if 
					
					  //do the next regex search from the current found position
					  //NOTE : start will never be be greater than length+1
					$vl_start:=$vl_pos+$vl_replaceWithLength
					
				End if 
				
			End while 
			
		End if 
		
	End if 
	
End if 
$0:=$vt_out



//%attributes = {"invisible":true,"preemptive":"capable"}

  //================================================================================
  //@xdoc-start : en
  //@name : TXT_isEqualStrict
  //@scope : public
  //@deprecated : no
  //@description : This function returns true if two text are strictly equal . 
  //@parameter[0-OUT-textAreEqual-BOOLEAN] : True if both text are equal, False otherwise
  //@parameter[1-IN-text1-TEXT] : text 1
  //@parameter[2-IN-text2-TEXT] : text 2
  //@notes : This function is slower than the default 4D text comparison which is diacritic and support joker characters (@)
  // So don't use this function for optimisation purposes...
  //@example : TXT_isEqualStrict 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 19/02/2008, 08:18:08 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_isEqualStrict)
C_TEXT:C284($1;$vt_text1)
C_TEXT:C284($2;$vt_text2)

$vb_isEqualStrict:=False:C215
If (Count parameters:C259>1)
	$vt_text1:=$1
	$vt_text2:=$2
	
	C_LONGINT:C283($vl_length)
	$vl_length:=Length:C16($vt_text1)
	
	Case of 
		: ($vl_length#Length:C16($vt_text2))
			  //If the two string are not of the same length
			  //no need to look further
			
		: ($vl_length=0)
			  //two empty strings are equal
			$vb_isEqualStrict:=True:C214
			
		Else 
			  //we use v11 new diacritic-sensitive option for Position
			  //if the result = 1 (and we know the strings are of same length)
			  //then the strings are strictly equal
			$vb_isEqualStrict:=(Position:C15($vt_text1;$vt_text2;1;*)=1)
	End case 
	
End if 
$0:=$vb_isEqualStrict
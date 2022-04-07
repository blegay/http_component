//%attributes = {"shared":false,"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : TXT_trimWhiteSpaces
  //@scope : public
  //@deprecated : no
  //@description : This function will remove white spaces ([ \t\r\n\v\f]) at the begining and at the end of a text 
  //@parameter[0-OUT-textOut-TEXT] : text 
  //@parameter[1-IN-textIn-TEXT] : text
  //@notes : whitespaces is space, tab, carriage return or line feed
  //@example : ALERT("\""+TXT_trimWhiteSpaces (" \r Bruno\rLEGAY \r\n ")+"\"") 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 31/08/2012, 00:41:11 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_out)  //text out
C_TEXT:C284($1;$vt_in)  //text in

$vt_out:=""

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>0)
	$vt_in:=$1
	
	If (Length:C16($vt_in)>0)
		
		If (False:C215)  //plus rapide dans les tests
			C_TEXT:C284($vt_regex)
			$vt_regex:="^\\s+|\\s+$"
			
			$vt_out:=TXT_replaceRegex ($vt_in;$vt_regex)
		Else   //moins rapide dans les tests...
			
			  //C_BOOLEEN($vb_searchAtPositionOnly)
			C_TEXT:C284($vt_regex)
			$vt_regex:="^\\s+"
			$vt_out:=TXT_replaceRegex ($vt_in;$vt_regex)  //pas d'amélioration sensible avec searchAtPositionOnly
			
			  //$vb_searchAtPositionOnly:=Vrai
			  //$vt_out:=TXT_replaceRegex ($vt_in;$vt_regex;"";1;$vb_searchAtPositionOnly)
			
			C_TEXT:C284($vt_regex)
			$vt_regex:="\\s+$"
			$vt_out:=TXT_replaceRegex ($vt_out;$vt_regex)
			  //$vb_searchAtPositionOnly:=Faux
			  //$vt_out:=TXT_replaceRegex ($vt_out;$vt_regex;"";1;$vb_searchAtPositionOnly)
		End if 
		
	End if 
	
End if 
$0:=$vt_out
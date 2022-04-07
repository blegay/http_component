//%attributes = {"shared":false,"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : DBG_bytes
  //@scope : public
  //@deprecated : no
  //@description : This function returns a size in a formatted way (human readable)
  //@parameter[0-OUT-sizeStr-TEXT] : size string i.e. "1 089,78 bytes"
  //@parameter[1-IN-size-LONGINT] : size in bytes
  //@parameter[2-IN-showPreciseValue-BOOLEAN] : show exact value if True (optional, defaut False)
  //@notes : if size >= 1024    ==> "20,00 Kbyte"
  //         if size >= 1048576 ==> "1 420,05 Mbyte"
  //@notes :
  //@example : DBG_bytes 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 05/09/2013, 23:03:22 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0)
C_LONGINT:C283($1)  //size in bytes
C_BOOLEAN:C305($2)  //show precise value

C_TEXT:C284($vt_sizeStr)
C_LONGINT:C283($vl_size)  //size in bytes
C_BOOLEAN:C305($vb_showPreciseValue)  //show precise value

$vt_sizeStr:=""
C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>0)
	$vl_size:=$1
	
	Case of 
		: ($vl_nbParam=1)
			$vb_showPreciseValue:=False:C215
			
		Else 
			  //: ($vl_nbParam=1)
			$vb_showPreciseValue:=$2
	End case 
	
	$vl_size:=Abs:C99($vl_size)
	
	C_BOOLEAN:C305($vb_addPreciseValueSuffix)
	$vb_addPreciseValueSuffix:=False:C215
	
	Case of 
		: ($vl_size>=0x00100000)  //1048576
			$vt_sizeStr:=String:C10($vl_size/0x00100000;"# ##0.00")+" Mbyte(s)"
			$vb_addPreciseValueSuffix:=$vb_showPreciseValue
			
		: ($vl_size>=0x0400)  //1024)
			$vt_sizeStr:=String:C10($vl_size/0x0400;"# ##0.00")+" Kbyte(s)"
			$vb_addPreciseValueSuffix:=$vb_showPreciseValue
			
		: ($vl_size>1)
			$vt_sizeStr:=String:C10($vl_size;"# ##0")+" bytes"
			
		Else   //$vl_size = 0 or 1
			$vt_sizeStr:=String:C10($vl_size;"# ##0")+" byte"
	End case 
	
	If ($vb_addPreciseValueSuffix)
		$vt_sizeStr:=$vt_sizeStr+" ("+String:C10($vl_size;"# ### ### ##0")+" bytes)"
	End if 
	
End if 
$0:=$vt_sizeStr
//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP__userAgentString
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-userAgentString-TEXT] : userAgentString
  //@notes : 
  //@example : HTTP__userAgentString
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 15:14:49 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_userAgentString)

C_TEXT:C284($vt_plateformStr)
Case of 
	: (Is Windows:C1573)
		$vt_plateformStr:="Windows"
		
	: (Is macOS:C1572)
		$vt_plateformStr:="macOS"
		
	Else 
		$vt_plateformStr:="Linux"
End case 

C_TEXT:C284($vt_plateformeVersStr)
C_OBJECT:C1216($vo_systemInfos)
$vo_systemInfos:=Get system info:C1571

$vt_plateformeVersStr:=$vo_systemInfos.osVersion
  // "Microsoft Windows 10 Professionnel 10.0.14393"
  // "macOS 10.14.6 (18G103)"

C_TEXT:C284($vt_4dVersion)
$vt_4dVersion:=ENV_versionStr 

$vt_userAgentString:="4D-httpComponent/"+HTTP_componentVersionGet +" ("+$vt_plateformStr+"; "+$vt_plateformeVersStr+") 4D/"+$vt_4dVersion
  // 4D-httpComponent/0.00.05 (macOS; macOS 10.14.6 (18G103)) 4D/4D v18.3 Final (Build 255861)

$0:=$vt_userAgentString
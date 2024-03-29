//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_componentVersionGet
  //@scope : public 
  //@deprecated : no
  //@description : This function returns the component version in a string (e.g. "0.00.06")
  //@parameter[0-OUT-componentVersion-TEXT] : componentVersion (e.g. "0.00.06")
  //@notes : 
  //@example : HTTP_componentVersionGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2020
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 04/12/2020, 14:15:27 - 0.00.05
  //  MODIFICATION : Bruno LEGAY (BLE) - 08/04/2022, 01:26:35 - 0.00.06
  //   added few methods
  //    
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_componentVersion)

  //<Modif> Bruno LEGAY (BLE) (08/04/2022)
  //   added few methods
$vt_componentVersion:="0.00.06"
  //<Modif>


  //<Modif> Bruno LEGAY (BLE) (04/12/2020)
  // $vt_componentVersion:="0.00.05"
  //<Modif>

$0:=$vt_componentVersion
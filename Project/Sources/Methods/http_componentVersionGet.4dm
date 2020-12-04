//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : http_componentVersionGet
  //@scope : public 
  //@attributes : ThreadSafe
  //@deprecated : no
  //@description : This function returns the component version in a string (e.g. "0.00.05")
  //@parameter[0-OUT-componentVersion-TEXT] : componentVersion (e.g. "0.00.05")
  //@notes : 
  //@example : http_componentVersionGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2020
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 04/12/2020, 14:15:27 - 0.00.05
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_componentVersion)

  //<Modif> Bruno LEGAY (BLE) (04/12/2020)
$vt_componentVersion:="0.00.05"
  //<Modif>

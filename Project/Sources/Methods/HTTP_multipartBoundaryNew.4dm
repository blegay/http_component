//%attributes = {"shared":true,"preemptive":"capable"}

  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_multipartBoundaryNew
  //@scope : public
  //@deprecated : no
  //@description : This function returns a unique boundary (using a uuid)
  //@parameter[0-OUT-boundary-TEXT] : unique boundary
  //@notes :
  //@example : HTTP_multipartBoundaryNew => "========================e5a421eb183d46e8b1833583d685f7c8"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 10/11/2015, 10:36:21 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_boundary)

$vt_boundary:=("="*24)+Lowercase:C14(Generate UUID:C1066;*)

$0:=$vt_boundary
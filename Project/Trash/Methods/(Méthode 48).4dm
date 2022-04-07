//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : Méthode 48
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-paramName-OBJECT] : ParamDescription
  //@parameter[2-IN-paramName-POINTER] : ParamDescription (not modified)
  //@parameter[3-INOUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[4-OUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[5-IN-paramName-LONGINT] : ParamDescription (optional, default value : 1)
  //@notes : 
  //@example : Méthode 48
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 25/10/2021, 16:03:46 - 0.00.05
  //@xdoc-end
  //================================================================================

  //C_COLLECTION($c_test)
  //$c_test:=New collection(\
New object("param";"param1";"value";"value1");\
New object("param";"param2";"value";"value2"))

  //ASSERT(HTTP_queryStringBuild($c_test)="?param1=value1&param2=value2")

  //C_COLLECTION($c_test)
  //$c_test:=New collection(\
New object("param";"param1";"value";"value1 /=+");\
New object("param";"param2";"value";"été?&"))

  //ASSERT(HTTP_queryStringBuild($c_test)="?param1=value1+%2F%3D%2B&param2=%C3%A9t%C3%A9%3F%26")

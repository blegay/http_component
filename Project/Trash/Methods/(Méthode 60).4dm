//%attributes = {"shared":false,"invisible":true}

C_OBJECT:C1216($vo_formParameters)
$vo_formParameters:=New object:C1471
$vo_formParameters.param1:="value1"
$vo_formParameters.param2:="value2"

ASSERT:C1129(HTTP_wwwFormUrlStringify ($vo_formParameters)="param1=value1&param2=value2")

C_OBJECT:C1216($vo_formParameters)
$vo_formParameters:=New object:C1471
$vo_formParameters.param1:="value1 /=+"
$vo_formParameters.param2:="été?&"

ASSERT:C1129(HTTP_wwwFormUrlStringify ($vo_formParameters)="param1=value1+%2F%3D%2B&param2=%C3%A9t%C3%A9%3F%26")

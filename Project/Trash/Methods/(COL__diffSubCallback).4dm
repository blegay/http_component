//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
C_OBJECT:C1216($1)
C_COLLECTION:C1488($2;$3)
$1.result:=($2.indexOf($1.value)=-1)
If (Not:C34($1.result))
	If ($3.indexOf($1.value)=-1)
		$3.push($1.value)
	End if 
End if 
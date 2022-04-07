//%attributes = {"invisible":true,"shared":false}
C_POINTER:C301($1;$vp_statusCodeArrayPtr)
C_POINTER:C301($2;$vp_statusMessageArrayPtr)

If (Count parameters:C259>1)
	$vp_statusCodeArrayPtr:=$1
	$vp_statusMessageArrayPtr:=$2
	
	If ((Type:C295($vp_statusCodeArrayPtr->)=Integer array:K8:18) & (Type:C295($vp_statusMessageArrayPtr->)=Text array:K8:16))
		
		ARRAY INTEGER:C220($te_statusCode;21)
		ARRAY TEXT:C222($tt_statusMessage;21)
		
		If (True:C214)
			$te_statusCode{1}:=200
			$tt_statusMessage{1}:="OK"
			
			$te_statusCode{2}:=201
			$tt_statusMessage{2}:="CREATED"
			
			$te_statusCode{3}:=202
			$tt_statusMessage{3}:="ACCEPTED"
			
			$te_statusCode{4}:=203
			$tt_statusMessage{4}:="PARTIAL INFORMATION"
			
			$te_statusCode{5}:=204
			$tt_statusMessage{5}:="NO RESPONSE"
			
			$te_statusCode{6}:=205
			$tt_statusMessage{6}:="RESET CONTENT"
			
			$te_statusCode{7}:=206
			$tt_statusMessage{7}:="PARTIAL CONTENT"
			
			$te_statusCode{8}:=301
			$tt_statusMessage{8}:="MOVED"
			
			$te_statusCode{9}:=302
			$tt_statusMessage{9}:="FOUND"
			
			$te_statusCode{10}:=303
			$tt_statusMessage{10}:="METHOD"
			
			$te_statusCode{11}:=304
			$tt_statusMessage{11}:="NOT MODIFIED"
			
			$te_statusCode{12}:=400
			$tt_statusMessage{12}:="BAD REQUEST"
			
			$te_statusCode{13}:=401
			$tt_statusMessage{13}:="UNAUTHORIZED"
			
			$te_statusCode{14}:=402
			$tt_statusMessage{14}:="PAYMENT REQUIRED"
			
			$te_statusCode{15}:=403
			$tt_statusMessage{15}:="FORBIDDEN"
			
			$te_statusCode{16}:=404
			$tt_statusMessage{16}:="NOT FOUND"
			
			$te_statusCode{17}:=500
			$tt_statusMessage{17}:="INTERNAL ERROR"
			
			$te_statusCode{18}:=501
			$tt_statusMessage{18}:="NOT IMPLEMENTED"
			
			$te_statusCode{19}:=502
			$tt_statusMessage{19}:="BAD GATEWAY"
			
			$te_statusCode{20}:=503
			$tt_statusMessage{20}:="SERVICE UNAVAILABLE"
			
			$te_statusCode{21}:=504
			$tt_statusMessage{21}:="GATEWAY TIMEOUT"
		End if 
		
		  //%W-518.1
		COPY ARRAY:C226($te_statusCode;$vp_statusCodeArrayPtr->)
		COPY ARRAY:C226($tt_statusMessage;$vp_statusMessageArrayPtr->)
		  //%W+518.1
		
		ARRAY INTEGER:C220($te_statusCode;0)
		ARRAY TEXT:C222($tt_statusMessage;0)
		
	End if 
End if 
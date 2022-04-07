//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : Méthode 57
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
  //@example : Méthode 57
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 02/11/2021, 10:20:01 - 0.00.05
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_isEqual)
C_COLLECTION:C1488($1;$c_old)
C_COLLECTION:C1488($2;$c_new)
C_POINTER:C301($3;$vp_bothCollPtr)
C_POINTER:C301($4;$vp_oldOnlyCollPtr)
C_POINTER:C301($5;$vp_newOnlyCollPtr)

ASSERT:C1129(Count parameters:C259>4;"requires 5 parameters")
ASSERT:C1129($1#Null:C1517;"$1 is Null")
ASSERT:C1129($2#Null:C1517;"$2 is Null")
ASSERT:C1129(Type:C295($3->)=Is collection:K8:32;"$3 should be a collection pointer")
ASSERT:C1129(Type:C295($4->)=Is collection:K8:32;"$4 should be a collection pointer")
ASSERT:C1129(Type:C295($5->)=Is collection:K8:32;"$5 should be a collection pointer")

$vb_isEqual:=False:C215
$c_old:=$1
$c_new:=$2
$vp_bothCollPtr:=$3
$vp_oldOnlyCollPtr:=$4
$vp_newOnlyCollPtr:=$5

C_COLLECTION:C1488($c_both)
C_COLLECTION:C1488($c_oldOnly)
C_COLLECTION:C1488($c_newOnly)

$c_both:=New collection:C1472
$c_oldOnly:=New collection:C1472
$c_newOnly:=New collection:C1472

Case of 
	: (($c_old.length=0) & ($c_new.length=0))  // optimization
		$vb_isEqual:=True:C214
		
	: ($c_old.length=0)  // optimization
		$c_newOnly:=$c_new.distinct()  // copy().sort()  - .distinct() will remove duplicates and do a sort
		
	: ($c_new.length=0)  // optimization
		$c_oldOnly:=$c_old.distinct()  // copy().sort()  - .distinct() will remove duplicates and do a sort
		
	: ($c_new.equal($c_old))  // optimization
		$vb_isEqual:=True:C214
		$c_both:=$c_new.distinct()  // copy().sort()  - .distinct() will remove duplicates and do a sort
		
	Else 
		
		$c_old:=$c_old.distinct()  // .sort()  - .distinct() will remove duplicates and do a sort
		$c_new:=$c_new.distinct()  // .sort()  - .distinct() will remove duplicates and do a sort
		
		ARRAY LONGINT:C221($tl_new;0)
		ARRAY LONGINT:C221($tl_old;0)
		COLLECTION TO ARRAY:C1562($c_old;$tl_old)
		COLLECTION TO ARRAY:C1562($c_new;$tl_new)
		
		C_LONGINT:C283($vl_oldSize;$vl_newSize)
		$vl_oldSize:=Size of array:C274($tl_old)
		$vl_newSize:=Size of array:C274($tl_new)
		
		C_LONGINT:C283($vl_indexOld;$vl_indexNew)
		$vl_indexOld:=1
		$vl_indexNew:=1
		
		ARRAY LONGINT:C221($tl_both;0)
		ARRAY LONGINT:C221($tl_newOnly;0)
		ARRAY LONGINT:C221($tl_oldOnly;0)
		
		C_LONGINT:C283($vl_old;$vl_new)
		  //%R-
		While (($vl_indexOld<=$vl_oldSize) & ($vl_indexNew<=$vl_newSize))
			$vl_old:=$tl_old{$vl_indexOld}
			$vl_new:=$tl_new{$vl_indexNew}
			Case of 
				: ($vl_old=$vl_new)
					APPEND TO ARRAY:C911($tl_both;$vl_new)
					$vl_indexOld:=$vl_indexOld+1
					$vl_indexNew:=$vl_indexNew+1
					
				: ($vl_old<$vl_new)
					APPEND TO ARRAY:C911($tl_oldOnly;$vl_old)
					$vl_indexOld:=$vl_indexOld+1
					
				Else 
					APPEND TO ARRAY:C911($tl_newOnly;$vl_new)
					$vl_indexNew:=$vl_indexNew+1
					
			End case 
		End while 
		
		If ($vl_indexOld<=$vl_oldSize)
			C_LONGINT:C283($i)
			For ($i;$vl_indexOld;$vl_oldSize)
				APPEND TO ARRAY:C911($tl_oldOnly;$tl_old{$i})
			End for 
			  //$c_oldOnly.combine($c_old.slice($vl_indexOld))
		End if 
		
		If ($vl_indexNew<=$vl_newSize)
			For ($i;$vl_indexNew;$vl_newSize)
				APPEND TO ARRAY:C911($tl_newOnly;$tl_new{$i})
			End for 
			  //$c_newOnly.combine($c_new.slice($vl_indexNew))
		End if 
		
		  //%R+
		
		ARRAY TO COLLECTION:C1563($c_both;$tl_both)
		ARRAY TO COLLECTION:C1563($c_oldOnly;$tl_oldOnly)
		ARRAY TO COLLECTION:C1563($c_newOnly;$tl_newOnly)
		
		ARRAY LONGINT:C221($tl_both;0)
		ARRAY LONGINT:C221($tl_newOnly;0)
		ARRAY LONGINT:C221($tl_oldOnly;0)
		
		ARRAY LONGINT:C221($tl_new;0)
		ARRAY LONGINT:C221($tl_old;0)
		
		  //If ($vl_indexOld<$c_old.length)
		  //$c_oldOnly.combine($c_old.slice($vl_indexOld))
		  //End if 
		
		  //If ($vl_indexNew<$c_new.length)
		  //$c_newOnly.combine($c_new.slice($vl_indexNew))
		  //End if 
		
		$vb_isEqual:=(($c_oldOnly.length=0) & ($c_newOnly.length=0))
End case 

$vp_bothCollPtr->:=$c_both
$vp_oldOnlyCollPtr->:=$c_oldOnly
$vp_newOnlyCollPtr->:=$c_newOnly

$0:=$vb_isEqual
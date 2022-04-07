//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //*==============================================================================
  //Methode projet : COL_scalarLongDiff
  // Publique
  //
  //DESCRIPTION :
  // Cette fonction compare deux collections de scalaire "longint" (unique) et alimente trois collections
  //
  //PARAMETRES :
  //  $0 (BOOLEAN) <= TRUE if isEqual
  //  $1 (COLLECTION) => old (collection de scalaire "longint" unique, non modifiée)
  //  $2 (COLLECTION) => new (collection de scalaire "longint" unique, non modifiée)
  //  $3 (POINTEUR) => collection pointer : both (modifié)
  //  $4 (POINTEUR) => collection pointer : oldOnly (modifié)
  //  $5 (POINTEUR) => collection pointer : newOnly (modifié)
  //  
  //NOTES : 
  //
  //EXAMPLE D'APPEL : 
  // C_COLLECTION($c_keyBoth;$c_keyOldOnly;$c_keyNewOnly)
  // COL_scalarLongDiff ($c_old;$c_new;->$c_keyBoth;->$c_keyOldOnly;->$c_keyNewOnly)
  //  
  //CREATION : Bruno LEGAY (BLE) - 28/10/2021, 23:07:42 - v1.00.00
  //
  // 1999-2006 © A&C Consulting
  //*===============================================================================

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
	: (($c_old.length=0) & ($c_new.length=0))
		$vb_isEqual:=True:C214
		
	: ($c_old.length=0)
		$c_newOnly:=$c_new.copy()
		
	: ($c_new.length=0)
		$c_oldOnly:=$c_old.copy()
		
	: ($c_new.equal($c_old))
		$vb_isEqual:=True:C214
		$c_both:=$c_new.copy()
		
	Else 
		$c_oldOnly:=$c_old.copy()
		
		C_LONGINT:C283($vl_id;$vl_found)
		For each ($vl_id;$c_new)
			$vl_found:=$c_oldOnly.indexOf($vl_id)
			If ($vl_found=-1)
				$c_newOnly.push($vl_id)
			Else 
				$c_oldOnly.remove($vl_found)
				$c_both.push($vl_id)
			End if 
		End for each 
		
		$vb_isEqual:=(($c_oldOnly.length=0) & ($c_newOnly.length=0))
End case 

$vp_bothCollPtr->:=$c_both
$vp_oldOnlyCollPtr->:=$c_oldOnly
$vp_newOnlyCollPtr->:=$c_newOnly

$0:=$vb_isEqual

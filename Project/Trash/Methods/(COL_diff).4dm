//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : COL_diff
  //@scope : public 
  //@attributes :    
  //@deprecated : no
  //@description : This function compares two collections
  //  $0 (BOOLEAN) <= TRUE if isEqual
  //  $1 (COLLECTION) => old (collection, not modified)
  //  $2 (COLLECTION) => new (collection, not modified)
  //  $3 (POINTEUR) => collection pointer : both (modified)
  //  $4 (POINTEUR) => collection pointer : oldOnly (modified)
  //  $5 (POINTEUR) => collection pointer : newOnly (modified)
  //@notes : 
  //  supports various types without using C_VARIANT
  //  use the 4D collection member functions : .copy(), .equal(), .filter(), .indexOf() and .push()
  //  not diacritical, i.e.  "a" = "A", "é" = ""e"  (like the .equal member function)
  //  Original code from Keith Culotta :
  //  https://discuss.4d.com/t/comparing-2-collections-whats-the-most-elegant-way/21025/6
  //@example : COL_diff
  //@see : COL__diffSubCallback
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/10/2021, 07:15:45 - 0.00.05
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
	: (($c_old.length=0) & ($c_new.length=0))  // optimisation
		$vb_isEqual:=True:C214
		
	: ($c_old.length=0)  // optimisation
		$c_newOnly:=$c_new.copy()
		
	: ($c_new.length=0)  // optimisation
		$c_oldOnly:=$c_old.copy()
		
	: ($c_new.equal($c_old))  // optimisation, will only work if both collections are sorted
		$vb_isEqual:=True:C214
		$c_both:=$c_new.copy()
		
	Else 
		$c_oldOnly:=$c_old.filter("COL__diffSubCallback";$c_new;$c_both)
		$c_newOnly:=$c_new.filter("COL__diffSubCallback";$c_both;$c_both)
		
		$vb_isEqual:=(($c_oldOnly.length=0) & ($c_newOnly.length=0))
End case 

$vp_bothCollPtr->:=$c_both
$vp_oldOnlyCollPtr->:=$c_oldOnly
$vp_newOnlyCollPtr->:=$c_newOnly

$0:=$vb_isEqual
//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : COL_scalarLongDiffFast
  //@scope : public 
  //@attributes :    
  //@deprecated : no
  //@description : This function compares two longint scalar collections
  //  $0 (BOOLEAN) <= TRUE if isEqual
  //  $1 (COLLECTION) => old (longint scalar collection, not modified)
  //  $2 (COLLECTION) => new (longint scalar collection, not modified)
  //  $3 (POINTEUR) => collection pointer : both (modified)
  //  $4 (POINTEUR) => collection pointer : oldOnly (modified)
  //  $5 (POINTEUR) => collection pointer : newOnly (modified)
  //@notes :
  //  collection input order is not expected (input can be sorted or not)
  //  collection input values can contain duplicates
  //  collection output order will be sorted, values are unique in output
  //  Original code/algorithm by Peter BOZEK :
  //    https://discuss.4d.com/t/comparing-2-collections-whats-the-most-elegant-way/21025/21
  //  #threadsafe
  //@example : 
  //
  // C_COLLECTION($c_old;$c_new)
  // C_COLLECTION(>$c_diffInBoth;>$c_diffOldOnly;>$c_diffNewOnly)
  // C_COLLECTION($c_diffExpectedBoth;$c_diffExpectedOldOnly;$c_diffExpectedNewOnly)
  //
  // $c_old:=New collection(3;1;2)
  // $c_new:=New collection(2;1;4)
  //
  // $c_diffExpectedBoth:=New collection(1;2)
  // $c_diffExpectedOldOnly:=New collection(3)
  // $c_diffExpectedNewOnly:=New collection(4)
  //
  // ASSERT(Not(COL_scalarLongDiffFast ($c_old;$c_new;->$c_diffInBoth;->$c_diffOldOnly;->$c_diffNewOnly)))
  //
  // ASSERT($c_diffExpectedBoth.equal($c_diffInBoth))
  // ASSERT($c_diffExpectedOldOnly.equal($c_diffOldOnly))
  // ASSERT($c_diffExpectedNewOnly.equal($c_diffNewOnly))
  //
  //@see : COL_scalarLongDiffFast
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 28/10/2021, 23:07:42 - 0.00.05
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
		
		C_LONGINT:C283($vl_indexOld;$vl_indexNew)
		$vl_indexOld:=0
		$vl_indexNew:=0
		
		  //%R-
		While (($vl_indexOld<$c_old.length) & ($vl_indexNew<$c_new.length))
			Case of 
				: ($c_old[$vl_indexOld]=$c_new[$vl_indexNew])
					$c_both.push($c_old[$vl_indexOld])
					$vl_indexOld:=$vl_indexOld+1
					$vl_indexNew:=$vl_indexNew+1
					
				: ($c_old[$vl_indexOld]<$c_new[$vl_indexNew])
					$c_oldOnly.push($c_old[$vl_indexOld])
					$vl_indexOld:=$vl_indexOld+1
					
				Else 
					  //: ($c_old[$vl_indexOld]>$c_new[$vl_indexNew])
					$c_newOnly.push($c_new[$vl_indexNew])
					$vl_indexNew:=$vl_indexNew+1
			End case 
		End while 
		  //%R+
		
		If ($vl_indexOld<$c_old.length)
			$c_oldOnly.combine($c_old.slice($vl_indexOld))
		End if 
		
		If ($vl_indexNew<$c_new.length)
			$c_newOnly.combine($c_new.slice($vl_indexNew))
		End if 
		
		$vb_isEqual:=(($c_oldOnly.length=0) & ($c_newOnly.length=0))
End case 

$vp_bothCollPtr->:=$c_both
$vp_oldOnlyCollPtr->:=$c_oldOnly
$vp_newOnlyCollPtr->:=$c_newOnly

$0:=$vb_isEqual
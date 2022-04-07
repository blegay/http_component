//%attributes = {"shared":false,"invisible":true}
SET ASSERT ENABLED:C1131(True:C214)

C_COLLECTION:C1488($c_old;$c_new)
C_COLLECTION:C1488($c_diffInBoth;$c_diffOldOnly;$c_diffNewOnly)
C_COLLECTION:C1488($c_diffScalarBoth;$c_diffScalarOldOnly;$c_diffScalarNewOnly)
C_COLLECTION:C1488($c_diffScalarFastBoth;$c_diffScalarFastOldOnly;$c_diffScalarFastNewOnly)
C_COLLECTION:C1488($c_diffExpectedBoth;$c_diffExpectedOldOnly;$c_diffExpectedNewOnly)

If (True:C214)
	$c_old:=New collection:C1472("a";"b";"c";"e")
	$c_new:=New collection:C1472("f";"a";"d";"A";"é")
	
	ASSERT:C1129(Not:C34(COL_diff ($c_old;$c_new;->$c_diffInBoth;->$c_diffOldOnly;->$c_diffNewOnly)))
	
	$c_diffExpectedBoth:=New collection:C1472("a";"é")
	$c_diffExpectedOldOnly:=New collection:C1472("b";"c")
	$c_diffExpectedNewOnly:=New collection:C1472("f";"d")  // ;"A") NOTE : not diacritical, i.e.  "a" = "A", "é" = ""e"  (lile the .equal member function)
	
	ASSERT:C1129($c_diffExpectedBoth.equal($c_diffInBoth))
	ASSERT:C1129($c_diffExpectedOldOnly.equal($c_diffOldOnly))
	ASSERT:C1129($c_diffExpectedNewOnly.equal($c_diffNewOnly))
	
	CLEAR VARIABLE:C89($c_old)
	CLEAR VARIABLE:C89($c_new)
	
	CLEAR VARIABLE:C89($c_diffExpectedBoth)
	CLEAR VARIABLE:C89($c_diffExpectedOldOnly)
	CLEAR VARIABLE:C89($c_diffExpectedNewOnly)
	
	CLEAR VARIABLE:C89($c_diffInBoth)
	CLEAR VARIABLE:C89($c_diffOldOnly)
	CLEAR VARIABLE:C89($c_diffNewOnly)
	
End if 

If (True:C214)
	$c_old:=New collection:C1472
	$c_new:=New collection:C1472
	
	C_LONGINT:C283($vl_factor;$i)
	$vl_factor:=100
	
	For ($i;1;110*$vl_factor)
		$c_old.push($i)
	End for 
	
	For ($i;100*$vl_factor;200*$vl_factor)
		$c_new.push($i)
	End for 
	
	C_LONGINT:C283($vl_ms;$vl_durationColDiff;$vl_durationScalarLongDiff;$vl_durationScalarLongDiffFast)
	$vl_ms:=Milliseconds:C459
	
	ASSERT:C1129(Not:C34(COL_diff ($c_old;$c_new;->$c_diffInBoth;->$c_diffOldOnly;->$c_diffNewOnly)))
	
	$vl_durationColDiff:=Milliseconds:C459-$vl_ms
	  // 1529 ms uncompiled, 4D v18.3, Mac OS  X Mojave
	  // 1290 ms uncompiled, 4D v18.3, Mac OS  X Mojave
	
	$vl_ms:=Milliseconds:C459
	
	ASSERT:C1129(Not:C34(COL_scalarLongDiff ($c_old;$c_new;->$c_diffScalarBoth;->$c_diffScalarOldOnly;->$c_diffScalarNewOnly)))
	
	$vl_durationScalarLongDiff:=Milliseconds:C459-$vl_ms
	  // 1243 ms uncompiled, 4D v18.3, Mac OS  X Mojave
	  // 1104 ms uncompiled, 4D v18.3, Mac OS  X Mojave
	
	
	$vl_ms:=Milliseconds:C459
	
	ASSERT:C1129(Not:C34(COL_scalarLongDiffArray ($c_old;$c_new;->$c_diffScalarFastBoth;->$c_diffScalarFastOldOnly;->$c_diffScalarFastNewOnly)))
	
	$vl_durationScalarLongDiffFast:=Milliseconds:C459-$vl_ms
	
	CLEAR VARIABLE:C89($c_old)
	CLEAR VARIABLE:C89($c_new)
	
	ASSERT:C1129($c_diffScalarBoth.equal($c_diffInBoth))
	ASSERT:C1129($c_diffScalarOldOnly.equal($c_diffOldOnly))
	ASSERT:C1129($c_diffScalarNewOnly.equal($c_diffNewOnly))
	
	ASSERT:C1129($c_diffScalarFastBoth.equal($c_diffInBoth))
	ASSERT:C1129($c_diffScalarFastOldOnly.equal($c_diffOldOnly))
	ASSERT:C1129($c_diffScalarFastNewOnly.equal($c_diffNewOnly))
	
	CLEAR VARIABLE:C89($c_diffScalarFastBoth)
	CLEAR VARIABLE:C89($c_diffScalarFastOldOnly)
	CLEAR VARIABLE:C89($c_diffScalarFastNewOnly)
	
	CLEAR VARIABLE:C89($c_diffScalarBoth)
	CLEAR VARIABLE:C89($c_diffScalarOldOnly)
	CLEAR VARIABLE:C89($c_diffScalarNewOnly)
	
	CLEAR VARIABLE:C89($c_diffInBoth)
	CLEAR VARIABLE:C89($c_diffOldOnly)
	CLEAR VARIABLE:C89($c_diffNewOnly)
	
	
	ALERT:C41(Current method name:C684+": \rCOL_diff : "+String:C10($vl_durationColDiff)+\
		"\rCOL_scalarLongDiff : "+String:C10($vl_durationScalarLongDiff)+\
		"\rCOL_scalarFalstLongDiff : "+String:C10($vl_durationScalarLongDiffFast))
End if 
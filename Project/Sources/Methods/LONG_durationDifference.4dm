//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : LONG_durationDifference
  //@scope : public
  //@deprecated : no
  //@description : This function returns a duration between two time measuring
  // values (returned by Milliseconds or Tickcount)
  //@parameter[0-OUT-diff-LONGINT] : signed difference
  //@parameter[1-IN-valueA-LONGINT] : unsigned value for instance returned by Milliseconds or Tickcount
  //@parameter[2-IN-valueB-LONGINT] : unsigned value for instance returned by Milliseconds or Tickcount
  //@notes :
  // after 24.855134803241 days of running, a system will return negative values for Milliseconds
  // after 414.25224672068 days of running, a system will return negative values for Tickcount
  // This is may not be obvious on a dev machine, but more probable on a live/production server
  // (cf uptime http://en.wikipedia.org/wiki/Uptime )

  //@example :
  //
  // C_LONGINT ($vl_milliseconds;$vl_durationInMs)
  // $vl_milliseconds:=Milliseconds
  // `...
  // $vl_durationInMs:=LONG_durationDifference ($vl_milliseconds;Milliseconds)
  //
  //
  // C_LONGINT ($vl_tickCount;$vl_durationInTicks)
  // $vl_tickCount:=Tickcount
  // `...
  // $vl_durationInTicks:=LONG_durationDifference ($vl_tickCount;Tickcount)
  //
  //
  // ASSERT(LONG_durationDifference (1;1)=0)
  // ASSERT(LONG_durationDifference (2;1)=0)  // error (wrong input)
  // ASSERT(LONG_durationDifference (1;2)=1)
  // ASSERT(LONG_durationDifference (-1;1)=2)
  // ASSERT(LONG_durationDifference (2147483647;-2147483648)=1)
  // ASSERT(LONG_durationDifference (2147483647;-2147483647)=2)
  //
  //@see :
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 01/08/2012, 16:29:52 - v1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$vl_diff)
C_LONGINT:C283($1;$vl_valStart)
C_LONGINT:C283($2;$vl_valEnd)

$vl_diff:=0
If (Count parameters:C259>1)
	$vl_valStart:=$1
	$vl_valEnd:=$2
	
	$vl_diff:=$vl_valEnd-$vl_valStart
	If ($vl_diff<0)  // duration can never be negative, error (wrong input)
		$vl_diff:=0
	End if 
	
	  // https://discuss.4d.com/t/nombre-de-millisecondes-quand-le-serveur-ne-redemarre-jamais/17971
	  //Case of 
	  //  //:($vl_valStart=$vl_valEnd)
	  //  //$vl_diff:=0
	  //: (($vl_valStart>=0) & ($vl_valEnd>=0))
	  //$vl_diff:=$vl_valEnd-$vl_valStart
	
	  //: (($vl_valStart<0) & ($vl_valEnd<0))
	  //$vl_diff:=$vl_valEnd-$vl_valStart
	
	  //: ($vl_valEnd>0)
	  //  //$vl_valStart < 0 but in unsigned char above $vl_valEnd
	  //$vl_diff:=Abs((MAXLONG-$vl_valEnd)+($vl_valStart-MAXLONG))
	
	  //Else 
	  //$vl_diff:=($vl_valEnd-MAXLONG)+(MAXLONG-$vl_valStart)
	
	  //End case 
	
End if 
$0:=$vl_diff
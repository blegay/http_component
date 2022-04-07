//%attributes = {"shared":false,"invisible":true}

C_LONGINT:C283($vl_hi;$vl_lo)
  // get 2 16 bits random
$vl_hi:=Random:C100
$vl_lo:=Random:C100

  // combine them to get a 32 bit random
C_LONGINT:C283($vl_random)
$vl_random:=($vl_hi << 16) | $vl_lo



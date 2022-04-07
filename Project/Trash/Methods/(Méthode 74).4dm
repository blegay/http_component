//%attributes = {"shared":false,"invisible":true}



  //String(Current date;ISO date GMT)
C_DATE:C307($vd_date;$vd_dateDecoded)
C_TIME:C306($vh_time;$vh_timeDecoded)
$vd_date:=!2021-06-01!
$vh_time:=?00:30:00?

C_TEXT:C284($vt_timestamp)
$vt_timestamp:=String:C10($vd_date;ISO date GMT:K1:10;$vh_time)  // =>  "2021-05-31T22:30:00Z" (because of my current time zone settings and timezones)


XML DECODE:C1091($vt_timestamp;$vd_dateDecoded)  // => !2021-05-31! et pas !2021-06-01! 
XML DECODE:C1091($vt_timestamp;$vh_timeDecoded)  // => ?00:30:00?




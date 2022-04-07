//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_multipartBuild
  //@scope : public 
  //@deprecated : no
  //@description : This method builds an multipart blob
  //@parameter[1-INOUT-$vp_bodyBlobPtr-POINTER] : body blob pointer (modified)
  //@parameter[2-IN-boundary-TEXT] : boundary (see HTTP_multipartBoundaryNew)
  //@parameter[3-IN-header-TEXT] : part header (optional)
  //@parameter[4-IN-partBlobPtr-POINTER] : part body (optional, not modified)
  //@notes :
  //@example : 
  //C_TEXT($vt_boundary)
  //$vt_boundary:=HTTP_multipartBoundaryNew 
  //  //"========================0C832A9F8D41497F97DA591189E1DB80"
  //
  //C_TEXT($vt_crlf)
  //$vt_crlf:="\r\n"
  //
  //C_BLOB($vx_body)
  //SET BLOB SIZE($vx_body;0)
  //
  //C_TEXT($vt_header)
  //
  //  // set multipart 1
  //$vt_header:=""
  //$vt_header:=$vt_header+"Content-Disposition: form-data; name=\"frontImage\"; filename=\"frontImage.jpg\""+$vt_crlf
  //$vt_header:=$vt_header+"Content-Type: image/jpeg"+$vt_crlf
  //$vt_header:=$vt_header+"Content-Length: "+String(BLOB size($vx_frontImageBlob))+$vt_crlf
  //HTTP_multipartBuild (->$vx_body;$vt_boundary;$vt_header;->$vx_frontImageBlob)
  //
  //  // set multipart 2
  //$vt_header:=""
  //$vt_header:=$vt_header+"Content-Disposition: form-data; name=\"backImage\"; filename=\"backImage.jpg\""+$vt_crlf
  //$vt_header:=$vt_header+"Content-Type: image/jpeg"+$vt_crlf
  //$vt_header:=$vt_header+"Content-Length: "+String(BLOB size($vx_backimageblob))+$vt_crlf
  //HTTP_multipartBuild (->$vx_body;$vt_boundary;$vt_header;->$vx_backimageblob)
  //
  //  // end multipart
  //HTTP_multipartBuild (->$vx_body;$vt_boundary)
  //
  //ARRAY TEXT($tt_headerKeys;0)
  //ARRAY TEXT($tt_headerValues;0)
  //
  //APPEND TO ARRAY($tt_headerKeys;"Content-Type")
  //APPEND TO ARRAY($tt_headerValues;"multipart/form-data; boundary="+$vt_boundary)
  //
  //APPEND TO ARRAY($tt_headerKeys;"Content-Length")
  //APPEND TO ARRAY($tt_headerValues;String(BLOB size($vx_body)))
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
  //@history : CREATION : Bruno LEGAY (BLE) - 10/11/2015, 10:30:56 - v1.00.00
  //@xdoc-end
  //================================================================================

C_POINTER:C301($1;$vp_bodyBlobPtr)  // (modified)
C_TEXT:C284($2;$vt_boundary)
C_TEXT:C284($3;$vt_header)  // (optional)
C_POINTER:C301($4;$vp_partBlobPtr)  // (optional, not modified)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")

If ($vl_nbParam>1)
	$vp_bodyBlobPtr:=$1
	$vt_boundary:=$2
	
	Case of 
		: ($vl_nbParam=2)
			$vt_header:=""
			
		: ($vl_nbParam=3)
			$vt_header:=$3
			
		Else 
			  //: ($vl_nbParam=4)
			$vt_header:=$3
			$vp_partBlobPtr:=$4
	End case 
	
	ASSERT:C1129((Type:C295($vp_bodyBlobPtr->)=Is BLOB:K8:12);"$1 should be a blob pointer")
	
	C_TEXT:C284($vt_crlf)
	$vt_crlf:="\r\n"
	
	C_TEXT:C284($vt_boundaryDelim)
	$vt_boundaryDelim:="--"
	
	C_TEXT:C284($vt_headerPart)
	$vt_headerPart:=""
	If (BLOB size:C605($vp_bodyBlobPtr->)>0)  // start boundary with crlf except for first boundary
		$vt_headerPart:=$vt_headerPart+$vt_crlf
	End if 
	
	If ($vl_nbParam>2)  // header provided
		$vt_headerPart:=$vt_headerPart+$vt_boundaryDelim+$vt_boundary+$vt_crlf
		
		If (Length:C16($vt_header)>0)
			ASSERT:C1129(Position:C15($vt_crlf+$vt_crlf;$vt_header;*)=0;"Header should not contain 2 crlf")
			ASSERT:C1129(Substring:C12($vt_header;Length:C16($vt_header)-1;2)="\r\n";"Header should end with crlf")
			ASSERT:C1129(Substring:C12($vt_header;1;2)#"\r\n";"Header should not start with crlf")
			
			$vt_headerPart:=$vt_headerPart+$vt_header
		End if 
		$vt_headerPart:=$vt_headerPart+$vt_crlf
	Else   // last boundary finishes with "--" (no crlf necessary)
		$vt_headerPart:=$vt_headerPart+$vt_boundaryDelim+$vt_boundary+$vt_boundaryDelim  //+$vt_crlf
	End if 
	
	  // append multipart boundary (and possibly header)
	If (False:C215)
		  // BLB_appendText ($vp_bodyBlobPtr;$vt_headerPart;"us-ascii")
	Else 
		C_BLOB:C604($vx_buffer)
		SET BLOB SIZE:C606($vx_buffer;0)
		CONVERT FROM TEXT:C1011($vt_headerPart;"us-ascii";$vx_buffer)
		COPY BLOB:C558($vx_buffer;$vp_bodyBlobPtr->;0;BLOB size:C605($vp_bodyBlobPtr->);BLOB size:C605($vx_buffer))
		SET BLOB SIZE:C606($vx_buffer;0)
	End if 
	
	  // append multipart body 
	If ($vl_nbParam>3)
		If (Type:C295($vp_partBlobPtr->)=Is BLOB:K8:12)
			
			If (False:C215)
				  // BLB_append ($vp_bodyBlobPtr;$vp_partBlobPtr)
			Else 
				COPY BLOB:C558($vp_partBlobPtr->;$vp_bodyBlobPtr->;0;BLOB size:C605($vp_bodyBlobPtr->);BLOB size:C605($vp_partBlobPtr->))
			End if 
			
		End if 
	End if 
	
End if 
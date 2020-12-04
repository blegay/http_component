//%attributes = {"shared":true,"preemptive":"capable"}

  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_urlEncode
  //@scope : public
  //@deprecated : no
  //@description : This function is a specific URI encoding function for AWS 
  //@parameter[0-OUT-uriEncoded-TEXT] : uri encoded
  //@parameter[1-IN-uri-TEXT] : uri
  //@parameter[2-IN-encodeSlash-BOOLEAN] : if TRUE encode "/", if FALSE "/" is not encoded (optional, default TRUE)
  //@parameter[2-IN-rawUrlEncoding-BOOLEAN] : if TRUE encode " " as "%20", if FALSE " " is encoded with "+" (optional, default TRUE)
  //@notes :
  //  http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html
  //  URI encode every byte. UriEncode() must enforce the following rules:
  //  
  //  URI encode every byte except the unreserved characters: 'A'-'Z', 'a'-'z', '0'-'9', '-', '.', '_', and '~'.
  //  The space character is a reserved character and must be encoded as "%20" (and not as "+").
  //  Each URI encoded byte is formed by a '%' and the two-digit hexadecimal value of the byte.
  //  Letters in the hexadecimal value must be uppercase, for example "%1A".
  //  Encode the forward slash character, '/', everywhere except in the object key name. For example, if the object key name is photos/Jan/sample.jpg, the forward slash in the key name is not encoded.
  //  Caution
  //  The standard UriEncode functions provided by your development platform may not work because of differences in implementation and related ambiguity in the underlying RFCs. We recommend that you write your own custom UriEncode function to ensure that your encoding will work.
  //  The following is an example uri-encode() function in Java.
  //
  //            UriEncode(CharSequence input, boolean encodeSlash) {
  //              StringBuilder result = new StringBuilder();
  //              for (int i = 0; i < input.length(); i++) {
  //                  char ch = input.charAt(i);
  //                  if ((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z') || (ch >= '0' && ch <= '9') || ch == '_' || ch == '-' || ch == '~' || ch == '.') {
  //                      result.append(ch);
  //                  } else if (ch == '/') {
  //                      result.append(encodeSlash ? "%2F" : ch);
  //                  } else {
  //                      result.append(toHexUTF8(ch));
  //                  }
  //            }
  //            return result.toString();
  //
  //@example : 
  //
  // ASSERT(HTTP_urlEncode("")="")
  // ASSERT(HTTP_urlEncode(" ")="%20")
  // ASSERT(HTTP_urlEncode("/")="%2F")
  // ASSERT(HTTP_urlEncode("/";True)="%2F")
  // ASSERT(HTTP_urlEncode("/";False)="/")
  // ASSERT(HTTP_urlEncode("é")="%C3%A9")
  // ASSERT(HTTP_urlEncode ("été")="%C3%A9t%C3%A9")
  //
  //@see : https://www.ietf.org/rfc/rfc3986.txt
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 17/04/2016, 08:44:10 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_uriEncoded)
C_TEXT:C284($1;$vt_uri)
C_BOOLEAN:C305($2;$vb_encodeSlash)
C_BOOLEAN:C305($3;$vb_rawUrlEncoding)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_uriEncoded:=""
C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>0)
	$vt_uri:=$1
	
	Case of 
		: ($vl_nbParam=1)
			$vb_encodeSlash:=True:C214
			$vb_rawUrlEncoding:=True:C214
			
		: ($vl_nbParam=2)
			$vb_encodeSlash:=$2
			$vb_rawUrlEncoding:=True:C214
			
		Else 
			$vb_encodeSlash:=$2
			$vb_rawUrlEncoding:=$3
	End case 
	
	If (Length:C16($vt_uri)>0)
		
		C_LONGINT:C283($i;$vl_unicode)
		For ($i;1;Length:C16($vt_uri))
			$vl_unicode:=Character code:C91($vt_uri[[$i]])
			
			Case of 
				: ((($vl_unicode>=0x0041) & ($vl_unicode<=0x005A)) | \
					(($vl_unicode>=0x0061) & ($vl_unicode<=0x007A)) | \
					(($vl_unicode>=0x0030) & ($vl_unicode<=0x0039)) | \
					($vl_unicode=0x005F) | \
					($vl_unicode=0x002D) | \
					($vl_unicode=0x007E) | \
					($vl_unicode=0x002E))
					
					$vt_uriEncoded:=$vt_uriEncoded+$vt_uri[[$i]]
					  //  "A" 65 0x41
					  //  "Z" 90 0x5A
					  //  "a" 97 0x61
					  //  "z" 122 0x7A
					  //  "0" 48 0x30
					  //  "9" 57 0x39
					  //  "_" 95 0x5F
					  //  "-" 45 0x2D
					  //  "~" 126 0x7E
					  //  "." 46 0x2E
					
				: ($vl_unicode=0x002F)
					  //  "/" 47 0x2F
					$vt_uriEncoded:=$vt_uriEncoded+Choose:C955($vb_encodeSlash;"%2F";"/")
					
				: ($vl_unicode=0x0020)
					  //  " " 32 0x20
					$vt_uriEncoded:=$vt_uriEncoded+Choose:C955($vb_rawUrlEncoding;"%20";"+")
					
				Else 
					$vt_uriEncoded:=$vt_uriEncoded+HTTP__urlEscapeUnicode ($vl_unicode)
			End case 
		End for 
		
	End if 
End if 
$0:=$vt_uriEncoded
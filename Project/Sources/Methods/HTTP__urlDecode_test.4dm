//%attributes = {"invisible":true}


ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%2f");"/"))
ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("/");"/"))
ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("+");" "))
ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%21%23%24%26%27%28%29%2a%2b%2c%2f%3a%3b%3d%3f%40%5b%5d");"!#$&'()*+,/:;=?@[]"))
ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%21%23%24%26%27%28%29%2A%2B%2C%2F%3A%3B%3D%3F%40%5B%5D");"!#$&'()*+,/:;=?@[]"))

ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%%2f%");"%/%"))

ASSERT:C1129(HTTP_urlEncode ("/")="%2F")
ASSERT:C1129(HTTP_urlEncode ("KW Photo.jpg")="KW%20Photo.jpg")
ASSERT:C1129(HTTP_urlEncode ("KW Photo.jpg";True:C214;False:C215)="KW+Photo.jpg")
ASSERT:C1129(HTTP_urlEncode ("/KW Photo.jpg";True:C214;False:C215)="%2FKW+Photo.jpg")
ASSERT:C1129(HTTP_urlEncode ("/KW Photo.jpg";False:C215;False:C215)="/KW+Photo.jpg")
ASSERT:C1129(HTTP_urlEncode ("/é")="%2F%C3%A9")  // unicode 
ASSERT:C1129(HTTP_urlEncode (" ")="%20")  // unicode 
ASSERT:C1129(HTTP_urlEncode ("+")="%2B")  // unicode 

If (True:C214)  //1..127
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%01");Char:C90(0x0001)))  //1
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%02");Char:C90(0x0002)))  //2
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%03");Char:C90(0x0003)))  //3
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%04");Char:C90(0x0004)))  //4
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%05");Char:C90(0x0005)))  //5
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%06");Char:C90(0x0006)))  //6
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%07");Char:C90(0x0007)))  //7
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%08");Char:C90(0x0008)))  //8
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%09");Char:C90(0x0009)))  //9
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%0A");"\n"))  //10"
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%0B");Char:C90(0x000B)))  //11
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%0C");Char:C90(0x000C)))  //12
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%0D");"\r"))  //13"
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%0E");Char:C90(0x000E)))  //14
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%0F");Char:C90(0x000F)))  //15
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%10");Char:C90(0x0010)))  //16
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%11");Char:C90(0x0011)))  //17
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%12");Char:C90(0x0012)))  //18
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%13");Char:C90(0x0013)))  //19
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%14");Char:C90(0x0014)))  //20
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%15");Char:C90(0x0015)))  //21
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%16");Char:C90(0x0016)))  //22
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%17");Char:C90(0x0017)))  //23
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%18");Char:C90(0x0018)))  //24
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%19");Char:C90(0x0019)))  //25
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%1A");Char:C90(0x001A)))  //26
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%1B");Char:C90(0x001B)))  //27
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%1C");Char:C90(0x001C)))  //28
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%1D");Char:C90(0x001D)))  //29
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%1E");Char:C90(0x001E)))  //30
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%1F");Char:C90(0x001F)))  //31
	
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%20");" "))  //32
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("+");" "))  //32
	
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%21");"!"))  //33
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%22");"\""))  //34
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%23");"#"))  //35
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%24");"$"))  //36
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%25");"%"))  //37
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%26");"&"))  //38
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%27");"'"))  //39
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%28");"("))  //40
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%29");")"))  //41
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%2A");"*"))  //42
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%2B");"+"))  //43
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%2C");","))  //44
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("-");"-"))  //45
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode (".");"."))  //46
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%2F");"/"))  //47
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("0");"0"))  //48
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("1");"1"))  //49
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("2");"2"))  //50
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("3");"3"))  //51
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("4");"4"))  //52
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("5");"5"))  //53
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("6");"6"))  //54
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("7");"7"))  //55
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("8");"8"))  //56
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("9");"9"))  //57
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%3A");":"))  //58
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%3B");";"))  //59
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%3C");"<"))  //60
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%3D");"="))  //61
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%3E");">"))  //62
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%3F");"?"))  //63
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%40");"@"))  //64
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("A");"A"))  //65
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("B");"B"))  //66
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("C");"C"))  //67
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("D");"D"))  //68
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("E");"E"))  //69
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("F");"F"))  //70
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("G");"G"))  //71
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("H");"H"))  //72
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("I");"I"))  //73
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("J");"J"))  //74
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("K");"K"))  //75
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("L");"L"))  //76
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("M");"M"))  //77
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("N");"N"))  //78
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("O");"O"))  //79
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("P");"P"))  //80
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("Q");"Q"))  //81
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("R");"R"))  //82
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("S");"S"))  //83
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("T");"T"))  //84
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("U");"U"))  //85
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("V");"V"))  //86
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("W");"W"))  //87
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("X");"X"))  //88
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("Y");"Y"))  //89
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("Z");"Z"))  //90
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%5B");"["))  //91
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%5C");"\\"))  //92"
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%5D");"]"))  //93
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%5E");"^"))  //94
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("_");"_"))  //95
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%60");"`"))  //96
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("a");"a"))  //97
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("b");"b"))  //98
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("c");"c"))  //99
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("d");"d"))  //100
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("e");"e"))  //101
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("f");"f"))  //102
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("g");"g"))  //103
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("h");"h"))  //104
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("i");"i"))  //105
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("j");"j"))  //106
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("k");"k"))  //107
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("l");"l"))  //108
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("m");"m"))  //109
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("n");"n"))  //110
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("o");"o"))  //111
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("p");"p"))  //112
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("q");"q"))  //113
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("r");"r"))  //114
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("s");"s"))  //115
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("t");"t"))  //116
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("u");"u"))  //117
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("v");"v"))  //118
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("w");"w"))  //119
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("x");"x"))  //120
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("y");"y"))  //121
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("z");"z"))  //122
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%7B");"{"))  //123
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%7C");"|"))  //124
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%7D");"}"))  //125
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("~");"~"))  //126
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%7F");""))  //127
End if 

If (True:C214)
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%a0");Char:C90(160)))  // " " NO-BREAK SPACE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%a1");Char:C90(161)))  // "¡" INVERTED EXCLAMATION MARK
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%a2");Char:C90(162)))  // "¢" CENT SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%a3");Char:C90(163)))  // "£" POUND SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%a4");Char:C90(164)))  // "?" CURRENCY SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%a5");Char:C90(165)))  // "¥" YEN SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%a6");Char:C90(166)))  // "?" BROKEN BAR
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%a7");Char:C90(167)))  // "§" SECTION SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%a8");Char:C90(168)))  // "¨" DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%a9");Char:C90(169)))  // "©" COPYRIGHT SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%aa");Char:C90(170)))  // "ª" FEMININE ORDINAL INDICATOR
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%ab");Char:C90(171)))  // "«" LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%ac");Char:C90(172)))  // "¬" NOT SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%ad");Char:C90(173)))  // "-" SOFT HYPHEN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%ae");Char:C90(174)))  // "®" REGISTERED SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%af");Char:C90(175)))  // "¯" MACRON
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%b0");Char:C90(176)))  // "°" DEGREE SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%b1");Char:C90(177)))  // "±" PLUS-MINUS SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%b2");Char:C90(178)))  // "?" SUPERSCRIPT TWO
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%b3");Char:C90(179)))  // "?" SUPERSCRIPT THREE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%b4");Char:C90(180)))  // "´" ACUTE ACCENT
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%b5");Char:C90(181)))  // "µ" MICRO SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%b6");Char:C90(182)))  // "¶" PILCROW SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%b7");Char:C90(183)))  // "·" MIDDLE DOT
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%b8");Char:C90(184)))  // "¸" CEDILLA
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%b9");Char:C90(185)))  // "?" SUPERSCRIPT ONE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%ba");Char:C90(186)))  // "º" MASCULINE ORDINAL INDICATOR
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%bb");Char:C90(187)))  // "»" RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%bc");Char:C90(188)))  // "?" VULGAR FRACTION ONE QUARTER
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%bd");Char:C90(189)))  // "½" VULGAR FRACTION ONE HALF
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%be");Char:C90(190)))  // "?" VULGAR FRACTION THREE QUARTERS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c2%bf");Char:C90(191)))  // "¿" INVERTED QUESTION MARK
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%80");Char:C90(192)))  // "À" LATIN CAPITAL LETTER A WITH GRAVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%81");Char:C90(193)))  // "Á" LATIN CAPITAL LETTER A WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%82");Char:C90(194)))  // "Â" LATIN CAPITAL LETTER A WITH CIRCUMFLEX
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%83");Char:C90(195)))  // "Ã" LATIN CAPITAL LETTER A WITH TILDE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%84");Char:C90(196)))  // "Ä" LATIN CAPITAL LETTER A WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%85");Char:C90(197)))  // "Å" LATIN CAPITAL LETTER A WITH RING ABOVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%86");Char:C90(198)))  // "Æ" LATIN CAPITAL LETTER AE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%87");Char:C90(199)))  // "Ç" LATIN CAPITAL LETTER C WITH CEDILLA
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%88");Char:C90(200)))  // "È" LATIN CAPITAL LETTER E WITH GRAVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%89");Char:C90(201)))  // "É" LATIN CAPITAL LETTER E WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%8a");Char:C90(202)))  // "Ê" LATIN CAPITAL LETTER E WITH CIRCUMFLEX
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%8b");Char:C90(203)))  // "Ë" LATIN CAPITAL LETTER E WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%8c");Char:C90(204)))  // "Ì" LATIN CAPITAL LETTER I WITH GRAVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%8d");Char:C90(205)))  // "Í" LATIN CAPITAL LETTER I WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%8e");Char:C90(206)))  // "Î" LATIN CAPITAL LETTER I WITH CIRCUMFLEX
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%8f");Char:C90(207)))  // "Ï" LATIN CAPITAL LETTER I WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%90");Char:C90(208)))  // "?" LATIN CAPITAL LETTER ETH
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%91");Char:C90(209)))  // "Ñ" LATIN CAPITAL LETTER N WITH TILDE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%92");Char:C90(210)))  // "Ò" LATIN CAPITAL LETTER O WITH GRAVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%93");Char:C90(211)))  // "Ó" LATIN CAPITAL LETTER O WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%94");Char:C90(212)))  // "Ô" LATIN CAPITAL LETTER O WITH CIRCUMFLEX
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%95");Char:C90(213)))  // "Õ" LATIN CAPITAL LETTER O WITH TILDE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%96");Char:C90(214)))  // "Ö" LATIN CAPITAL LETTER O WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%97");Char:C90(215)))  // "?" MULTIPLICATION SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%98");Char:C90(216)))  // "Ø" LATIN CAPITAL LETTER O WITH STROKE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%99");Char:C90(217)))  // "Ù" LATIN CAPITAL LETTER U WITH GRAVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%9a");Char:C90(218)))  // "Ú" LATIN CAPITAL LETTER U WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%9b");Char:C90(219)))  // "Û" LATIN CAPITAL LETTER U WITH CIRCUMFLEX
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%9c");Char:C90(220)))  // "Ü" LATIN CAPITAL LETTER U WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%9d");Char:C90(221)))  // "?" LATIN CAPITAL LETTER Y WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%9e");Char:C90(222)))  // "?" LATIN CAPITAL LETTER THORN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%9f");Char:C90(223)))  // "ß" LATIN SMALL LETTER SHARP S
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%a0");Char:C90(224)))  // "à" LATIN SMALL LETTER A WITH GRAVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%a1");Char:C90(225)))  // "á" LATIN SMALL LETTER A WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%a2");Char:C90(226)))  // "â" LATIN SMALL LETTER A WITH CIRCUMFLEX
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%a3");Char:C90(227)))  // "ã" LATIN SMALL LETTER A WITH TILDE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%a4");Char:C90(228)))  // "ä" LATIN SMALL LETTER A WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%a5");Char:C90(229)))  // "å" LATIN SMALL LETTER A WITH RING ABOVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%a6");Char:C90(230)))  // "æ" LATIN SMALL LETTER AE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%a7");Char:C90(231)))  // "ç" LATIN SMALL LETTER C WITH CEDILLA
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%a8");Char:C90(232)))  // "è" LATIN SMALL LETTER E WITH GRAVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%a9");Char:C90(233)))  // "é" LATIN SMALL LETTER E WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%aa");Char:C90(234)))  // "ê" LATIN SMALL LETTER E WITH CIRCUMFLEX
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%ab");Char:C90(235)))  // "ë" LATIN SMALL LETTER E WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%ac");Char:C90(236)))  // "ì" LATIN SMALL LETTER I WITH GRAVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%ad");Char:C90(237)))  // "í" LATIN SMALL LETTER I WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%ae");Char:C90(238)))  // "î" LATIN SMALL LETTER I WITH CIRCUMFLEX
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%af");Char:C90(239)))  // "ï" LATIN SMALL LETTER I WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%b0");Char:C90(240)))  // "?" LATIN SMALL LETTER ETH
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%b1");Char:C90(241)))  // "ñ" LATIN SMALL LETTER N WITH TILDE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%b2");Char:C90(242)))  // "ò" LATIN SMALL LETTER O WITH GRAVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%b3");Char:C90(243)))  // "ó" LATIN SMALL LETTER O WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%b4");Char:C90(244)))  // "ô" LATIN SMALL LETTER O WITH CIRCUMFLEX
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%b5");Char:C90(245)))  // "õ" LATIN SMALL LETTER O WITH TILDE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%b6");Char:C90(246)))  // "ö" LATIN SMALL LETTER O WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%b7");Char:C90(247)))  // "÷" DIVISION SIGN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%b8");Char:C90(248)))  // "ø" LATIN SMALL LETTER O WITH STROKE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%b9");Char:C90(249)))  // "ù" LATIN SMALL LETTER U WITH GRAVE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%ba");Char:C90(250)))  // "ú" LATIN SMALL LETTER U WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%bb");Char:C90(251)))  // "û" LATIN SMALL LETTER U WITH CIRCUMFLEX
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%bc");Char:C90(252)))  // "ü" LATIN SMALL LETTER U WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%bd");Char:C90(253)))  // "?" LATIN SMALL LETTER Y WITH ACUTE
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%be");Char:C90(254)))  // "?" LATIN SMALL LETTER THORN
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%c3%bf");Char:C90(255)))  // "ÿ" LATIN SMALL LETTER Y WITH DIAERESIS
	ASSERT:C1129(TXT_isEqualStrict (HTTP_urlDecode ("%e2%82%ac");Char:C90(8364)))  // "€" EURO SIGN
End if 
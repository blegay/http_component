//%attributes = {}
ARRAY LONGINT:C221($tl_HTTP_ascii;0)
ARRAY TEXT:C222($tt_HTTP_escaped;0)

HTTP__httpEscapeLoad (->$tl_HTTP_ascii;->$tt_HTTP_escaped)

C_COLLECTION:C1488($vo_httpEscapeLookup)
$vo_httpEscapeLookup:=New shared collection:C1527

ARRAY TO COLLECTION:C1563($vo_httpEscapeLookup;\
$tl_HTTP_ascii;"ascii";\
$tt_HTTP_escaped;"httpEscaped")

  //HTTP__moduleDebugDateTimeLine (4;Current method name;"http escape codes loaded ("+String(Size of array($tl_HTTP_ascii))+" elements)")

ARRAY LONGINT:C221($tl_HTTP_urlUnicode;0)
ARRAY TEXT:C222($tt_HTTP_urlUnicodeEscaped;0)

HTTP__urlUnicodeEscapeLoad (->$tl_HTTP_urlUnicode;->$tt_HTTP_urlUnicodeEscaped)

ARRAY TEXT:C222($tt_HTTP_mimeTypes;0)
ARRAY BOOLEAN:C223($tb_HTTP_mimeTypesCompress;0)

HTTP__loadMimeTypes (->$tt_HTTP_mimeTypes;->$tb_HTTP_mimeTypesCompress)

ARRAY TEXT:C222($tt_HTTP_extMimeLookupExt;0)
ARRAY TEXT:C222($tt_HTTP_extMimeLookupMime;0)

HTTP__loadExtMimeLookup (->$tt_HTTP_extMimeLookupExt;->$tt_HTTP_extMimeLookupMime)


ARRAY INTEGER:C220($te_HTTP_statusCode;0)
ARRAY TEXT:C222($tt_HTTP_statusMessage;0)

HTTP__loadStatusCodeLookup (->$te_HTTP_statusCode;->$tt_HTTP_statusMessage)

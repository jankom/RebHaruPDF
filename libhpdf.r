REBOL [ 

]
;; lib: load/library %libhpdf.dll
lib: load/library switch/default fourth system/version [
		2	[%/usr/lib/libhpdf.dylib]
		3	[%libhpdf.dll]
	] [%libhpdf.so]


; document

hpdf-new: make routine! [ 
	err-h [ integer! ]
	user-data [ string! ]
	return: [ integer! ]
] lib "HPDF_New"

hpdf-free: make routine! [ 
	doc [ integer! ]
	return: [ integer! ]
] lib "HPDF_Free"

hpdf-add-page: make routine! [ 
	doc [ integer! ]
	return: [ integer! ]
] lib "HPDF_AddPage"

hpdf-save-to-file: make routine! [ 
	doc [ integer! ]
	file-name [ string! ]
	return: [ integer! ]
] lib "HPDF_SaveToFile"

hpdf-get-font: make routine! [ 
	doc [ integer! ]
	font-name [ string! ]
	encoding-name [ string! ]
	return: [ integer! ]
] lib "HPDF_GetFont"


; image

hpdf-load-jpeg-image-from-file: make routine! [
	doc [ integer! ]
    file [ string! ]
	return: [ integer! ]
] lib "HPDF_LoadJpegImageFromFile"

hpdf-load-png-image-from-file: make routine! [
	doc [ integer! ]
    file [ string! ]
	return: [ integer! ]
] lib "HPDF_LoadPngImageFromFile"


hpdf-image-get-width: make routine! [
	image [ integer! ]
	return: [ integer! ]
] lib "HPDF_Image_GetWidth"

hpdf-image-get-height: make routine! [
	image [ integer! ]
	return: [ integer! ]
] lib "HPDF_Image_GetHeight"

hpdf-page-draw-image: make routine! [
	page [ integer! ]
	image [ integer! ]
	x [ float ]
	y [ float ]
	w [ float ]
	h [ float ]
	return: [ integer! ] "status"
] lib "HPDF_Page_DrawImage"


; page

hpdf-page-set-size: make routine! [ 
	page [ integer! ]
	size [ integer! ]
	direction [ integer! ]
	return: [ integer! ] 
] lib "HPDF_Page_SetSize"

hpdf-page-get-with: make routine! [ 
	page [ integer! ]
	return: [ decimal! ] 
] lib "HPDF_Page_GetWidth"

hpdf-page-get-height: make routine! [ 
	page [ integer! ]
	return: [ decimal! ] 
] lib "HPDF_Page_GetHeight"

hpdf-page-text-width: make routine! [ 
	page [ integer! ]
	text [ string! ]
	return: [ decimal! ] 
] lib "HPDF_Page_TextWidth"


; page graphics

hpdf-page-set-font-and-size: make routine! [ 
	page [ integer! ]
	font [ integer! ]
	size [ float ]
	return: [ integer! ] 
] lib "HPDF_Page_SetFontAndSize"

hpdf-page-begin-text: make routine! [ 
	page [ integer! ]
	return: [ integer! ] "status"
] lib "HPDF_Page_BeginText"

hpdf-page-end-text: make routine! [ 
	page [ integer! ]
	return: [ integer! ] "status"
] lib "HPDF_Page_EndText"

hpdf-page-text-out: make routine! [ 
	page [ integer! ]
	tx [ decimal! ]
	ty [ decimal! ]
	text [ string! ]
	return: [ integer! ] "status"
] lib "HPDF_Page_TextOut"

hpdf-page-move-text-pos: make routine! [
	page [ integer! ]
	tx [ float ]
	ty [ float ]
	return: [ integer! ] "status"
] lib "HPDF_Page_MoveTextPos"

hpdf-page-show-text: make routine! [
	page [ integer! ]
	text [ string! ]
	return: [ integer! ] "status"
] lib "HPDF_Page_ShowText"

hpdf-page-show-text-next-line: make routine! [
	page [ integer! ]
	text [ string! ]
	return: [ integer! ] "status"
] lib "HPDF_Page_ShowTextNextLine"

hpdf-page-move-to: make routine! [
	page [ integer! ]
	x [ float ]
	y [ float ]
	return: [ integer! ] "status"
] lib "HPDF_Page_MoveTo"

hpdf-page-line-to: make routine! [
	page [ integer! ]
	x [ float ]
	y [ float ]
	return: [ integer! ] "status"
] lib "HPDF_Page_LineTo"

pos-struct: make struct! [x [float] y [float]] none
pos-dec: make struct! [x [decimal!]] none

hpdf-page-get-curr-text-pos-old-doesnt-work: make routine! [
	page [ integer! ]
	return: [ struct! [ x [ int ] y [ int ]] ]
] lib "HPDF_Page_GetCurrentTextPos"
	; return: [ integer! ]
	; return: [ struct! [ x [ float ] y [ float ]]  ]
	; return: [ struct! [ x [ int ] y [ int ]]  ]

hpdf-page-get-curr-text-pos: make routine! [
	page [ integer! ]
    pos [ struct! [ x [ float ] y [ float ]]  ]
	return: [ integer! ]
] lib "HPDF_Page_GetCurrentTextPos2"


; constants

HPDF-A4: 3

HPDF-PORTRAIT: 0

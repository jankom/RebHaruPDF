REBOL [ 

]
;; lib: load/library %libhpdf.dll
lib: load/library switch/default fourth system/version [
		2	[%/usr/lib/libhpdf.dylib]
		3	[%libhpdf.dll]
	] [%libhpdf.so]


; document

hpdf-new: make routine! [ 
	err-h [ string! ]
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


pdf-doc: make object! [
	doc: none
	new: does [ P: make self []  P/doc: hpdf-new "" ""  P ]
	add-page: does [ pdf-page/new (hpdf-add-page doc) self ]
	get-font: func [ font encod ] [ pdf-font/new hpdf-get-font doc font encod ]
	save-to-file: func [ file ] [ hpdf-save-to-file doc to-string file ]
	free: does [ hpdf-free doc ]
]

pdf-page: make object! [ 
	page: none
	docobj: none
	fontobj: none	
	font-size: 0
	new: func [ page- docobj- ] [ P: make self []  P/page: page-  P/docobj: docobj- P ]
	set-size: func [ size dir ] [ hpdf-page-set-size page size dir ]
	get-width: does [ hpdf-page-get-with page ]
	get-height: does [ hpdf-page-get-height page ]
	set-font: func [ font size ] [ 
		hpdf-page-set-font-and-size page font/font size 
		fontobj: font 
		font-size: size 
	]
	begin-text: does [ hpdf-page-begin-text page ]
	end-text: does [ hpdf-page-end-text page ]	
	move-text-pos: func [ x y ] [ hpdf-page-move-text-pos page x y ]
	text-width: func [ text ] [ hpdf-page-text-width page text ] 
	show-text: func [ text ] [ hpdf-page-show-text page text ]
	show-text-nl: func [ text ] [ hpdf-page-show-text-next-line page text ]
	get-text-pos: func [ /local pos-struct ] [
		pos-struct: make struct! [x [float] y [float]] none
		hpdf-page-get-curr-text-pos page pos-struct
		pos-struct
	]
	move-to: func [ x y ] [ hpdf-page-move-to page x y ]
	line-to: func [ x y ] [ hpdf-page-line-to page x y ]
]

pdf-font: make object! [ 
	font: none
	new: func [ font- ] [ P: make self []  P/font: font- P ]
]

pdf-pen: make object! [
	page: none
	doc: none
	w: 0 h: 0 padding: 0 line-h: 30
	
	new: func [ page padding ] [
		P: make self []  P/page: page
		P/w: page/get-width   P/h: page/get-height  P/padding: padding
		P 
	]
	to-offset: func [ x y ] [ page/move-text-pos (padding + x) (h - padding + y) ]
	break: func [ line-h ] [
		page/move-text-pos 0 (- line-h)
		pos: page/get-text-pos
		if lesser? pos/y 50 [
			pdf-util/break-page page padding
		]
	]
	move: func [ x y ] [ page/move-text-pos x y ]
]

pdf-util: make object! [

	break-page: func [ page padding- /local new-page ] [
		page/end-text
		new-page: page/docobj/add-page
		page/page: new-page/page
		page/set-size HPDF-A4 HPDF-PORTRAIT  		;;; fix this 
		page/set-font page/fontobj page/font-size 	;;; make it better structured !!!!!!!!!!!!!!!!!!!!
		page/begin-text
		pen/to-offset 0 (- padding-)	
	]

]

pdf-table: make object! [
	page: none  cols: none  row-h: 0   breaks-pages: true
	
	new: func [ page cols row-h ] [ 		
		P: make self []  P/page: page   P/cols: cols   P/row-h: row-h
		P 
	]
	show-row: func [ vals props /local w fwd i rows ] [ 
		rows: 1
		repeat i ((length? cols) - 1) [ 
			switch props/:i [
				l [
					page/move-text-pos cols/:i 0
					page/show-text vals/:i
				] 
				r [
					w: page/text-width vals/:i
					page/move-text-pos (cols/:i + ( fwd: (cols/(i + 1) - w) )) 0
					page/show-text vals/:i
					page/move-text-pos (- fwd) 0
				]
				c [
					w: page/text-width vals/:i
					c: ((cols/(i + 1)) - cols/:i) / 2
					page/move-text-pos (cols/:i + ( fwd: c - (w / 2)) ) 0
					page/show-text vals/:i
					page/move-text-pos (- fwd) 0				
				]
				lw [
					page/move-text-pos cols/:i 0 ; move to this cell
					cw: cols/(i + 1) - cols/:i ; cell width
					lines: get-wraped-lines vals/:i cw
					backup: 0 cellrows: 0
					foreach line lines [ 
						page/show-text line
						page/move-text-pos 0 (- row-h )
						backup: backup + row-h
						cellrows: cellrows + 1
					]
					page/move-text-pos 0 backup
					if greater? cellrows rows [ rows: cellrows ]
				]
				cw [
					page/move-text-pos cols/:i 0 ; move to this cell
					cw: cols/(i + 1) - cols/:i ; cell width
					lines: get-wraped-lines vals/:i cw
					backup: 0 cellrows: 0
					foreach line lines [ 
						w: page/text-width line
						c: ((cols/(i + 1)) - cols/:i) / 2
						page/move-text-pos (cols/:i + ( fwd: c - (w / 2)) ) 0
						page/show-text line
						page/move-text-pos (- fwd) 0				

						; page/show-text line
						page/move-text-pos 0 (- row-h )
						backup: backup + row-h
						cellrows: cellrows + 1
					]
					page/move-text-pos 0 backup
					if greater? cellrows rows [ rows: cellrows ]
				]
			]
		]
		page/move-text-pos (- sum-cols) (- row-h * rows)
		
		pos: page/get-text-pos
		if all [ breaks-pages  lesser? pos/y 120 ] [
			pdf-util/break-page page 80 	;; LATER make it so that line height for all cells in current row is precalculated and page
		]									;; break is determined on that
	]
	show-line: func [ /local posit ] [  	;; just ugly hack until get-text-pos works
		page/move-text-pos 0 ( row-h * 0.75 )
		page/show-text "____________________________________________________________________________________" 
		page/move-text-pos 0 (- (row-h * 0.9 ))
	] 
	get-pos: func [ local /posit ] [ posit: page/get-text-pos ] ; pos: page/get-text-pos  ?? pos ] ;page/move-to pos/x pos/y  page/line-to (pos/x + 100) pos/y ]
	sum-cols: func [ /local a i ] [ a: 0   repeat i ((length? cols) - 1) [ a: a + cols/:i ] a ]
	get-wraped-lines: func [ text width /local res pointer previous tpart] [ 
		res: copy []
		pointer: text
		previous: pointer
		forall pointer [
			if find/match pointer " " [
				if (greater? (page/text-width tpart: (copy/part text pointer)) width) [
					append res copy/part text previous
					text: next previous
				]
				previous: pointer
			]
		]
		append res copy text
		res
    ]
]
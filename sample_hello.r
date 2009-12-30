REBOL [ 

]

do %haru-pdf.r

doc: pdf-doc/new
page: doc/add-page
page/set-size HPDF-A4 HPDF-PORTRAIT
page/set-font (doc/get-font "Helvetica" "CP1250") 30
page/begin-text
page/move-text-pos (page/get-width * 0.1) (page/get-height * 0.5)
page/show-text "Hello World From RebHaruPDF!!"
page/end-text
doc/save-to-file "sample_hello.pdf"
doc/free

ask ".."
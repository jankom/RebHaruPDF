REBOL [ 

]

do %haru-pdf.r

doc: hpdf-new "" "" 
page: hpdf-add-page doc
hpdf-page-set-size page HPDF-A4 HPDF-PORTRAIT

w: hpdf-page-get-with page
h: hpdf-page-get-height page

font: hpdf-get-font doc "Helvetica" "CP1250"
font2: hpdf-get-font doc "Times-Roman" "CP1250"

text: "Hello from rebHaru!!!"

hpdf-page-set-font-and-size page font 30.2

?? doc ?? page ?? w ?? h ?? font 

probe hpdf-page-begin-text page

tw: hpdf-page-text-width page "text"

?? tw

print "pos pos"

pos-struct: make struct! [x [float] y [float]] none

hpdf-page-get-curr-text-pos page pos-struct

?? page 
?? pos-struct


probe hpdf-page-move-text-pos page ((w - tw) / 2) (h / 2)

pos-struct: make struct! [x [float] y [float]] none

hpdf-page-get-curr-text-pos page pos-struct

?? page 
?? pos-struct


probe hpdf-page-show-text page text

hpdf-page-set-font-and-size page font2 20.2

probe hpdf-page-move-text-pos page -150 100
probe hpdf-page-show-text page "rebHaru PDF likes Šlaviè Èarakterž, mamièku tatièku :)"

pos-struct: make struct! [x [float] y [float]] none

hpdf-page-get-curr-text-pos page pos-struct

?? page 
?? pos-struct


probe hpdf-page-end-text page

hpdf-save-to-file doc "sample_encoding.pdf"
hpdf-free doc

ask ".."
REBOL [ 

]

do %haru-pdf.r

doc: hpdf-new 0 "" 
page: hpdf-add-page doc
hpdf-page-set-size page HPDF-A4 HPDF-PORTRAIT

w: hpdf-page-get-with page
h: hpdf-page-get-height page

font: hpdf-get-font doc "Times-Roman" "CP1250"

hpdf-page-set-font-and-size page font 30.2

probe hpdf-page-begin-text page

probe hpdf-page-move-text-pos page (new-x: w * 0.2) (h * 0.8)
probe hpdf-page-show-text page text: "image sample (jpg and png):"

pos-struct: make struct! [x [float] y [float]] none

hpdf-page-get-curr-text-pos page pos-struct

print "position:"

?? pos-struct

hpdf-page-end-text page

image: hpdf-load-jpeg-image-from-file doc "sample_images.jpg"

probe imw: hpdf-image-get-width image
probe imh: hpdf-image-get-height image

print "draw jpg"
probe hpdf-page-draw-image page image 
	(pos-struct/x - (imw / 3)) 
	(new-y: pos-struct/y - (imh / 3) - 10) 
	(imw / 3) (imh / 3) 
print "drawn jpg"


image2: hpdf-load-png-image-from-file doc "sample_images.png"

probe imw2: hpdf-image-get-width image2
probe imh2: hpdf-image-get-height image2

print "draw png"
probe hpdf-page-draw-image page image2 new-x new-y imw2 imh2 
print "drawn png"

hpdf-save-to-file doc "sample_images.pdf"
hpdf-free doc

ask ".."
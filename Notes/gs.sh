
# GhostScript

Combine PDFs:
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sPAPERSIZE=letter -dPDFFitPage -sOutputFile=Remibursement_Mason_3.5.26.pdf *

Shorten PDFs:
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dFirstPage=1 -dLastPage=1 -sOutputFile=4-1.pdf 4.pdf
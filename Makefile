pdf: room-squares.pdf

clean:
	rm -f room-squares.pdf

room-squares.pdf: room-squares.Rmd
	Rscript -e "Sys.setenv(RSTUDIO_PANDOC='/usr/lib/rstudio/bin/pandoc');rmarkdown::render('$<')"


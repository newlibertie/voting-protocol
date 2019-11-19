.SUFFIXES : .ps .tex .dvi

TARGET=vp
SRCS=intro.tex protocol.tex vp.tex vp.bib Makefile

vp.dvi:$(SRCS) 
	latex vp.tex || xmessage -timeout 3 Failed to compile vp.tex 
	bibtex $(TARGET) || xmessage -timeout 3 Failed to compile bibliography for vp.tex
	latex $(TARGET)
	latex $(TARGET)


ps : vp.dvi
	dvips -D 6000 -Z -Ppdf -G0 -j0 -o $(TARGET).ps $(TARGET).dvi


vp.pdf:$(SRCS)
	pdflatex vp.tex || xmessage -timeout 3 Failed to compile vp.tex
	bibtex $(TARGET) || xmessage -timeout 3 Failed to compile bibliography for vp.tex
	pdflatex $(TARGET)
	pdflatex $(TARGET)


view : vp.dvi
	xdvi -fg rgb:1/0/8 -bg rgb:d/c/9 $(TARGET).dvi \
			-watchfile 3 -gamma 0.9 -s 7  -expertmode 3 2>/dev/null >/dev/null &

clean : 
	rm -f *.dvi *.aux *.log *.bak *bbl *.blg 
	rm -f *ps
	rm -f *.tex~
	rm -f *.lot
	rm -f *.lof
	rm -f *.ps *.pdf *.prj  *.ps.gz *~ *.out

MKDN = $(wildcard *.md)
HTML = $(MKDN:.md=.html)
#HTML = grassmann.html
PDF = $(MKDN:.md=.pdf)
FLAGS = -s # smart quotes
#FLAGS += --katex
FLAGS += --mathjax
FLAGS += --css ftap.css
FLAGS += --section-divs
FLAGS += -H header.html
#FLAGS += -A footer.html
FLAGS += -f markdown+tex_math_single_backslash+auto_identifiers

cme:
	rcp kal@web626.webfaction.com:cme/stleqt/stleqt.20171109.tgz .

$(HTML): %.html: %.md
	pandoc $(FLAGS) $< -o $@

$(PDF): %.pdf: %.md
	pandoc -H header.tex $< -o $@

rsync: $(HTML)
	rsync $(HTML) ftap.css kal@web626.webfaction.com:webapps/kalx/html

lsync:
	rsync kal@web626.webfaction.com:webapps/kalx/ftapirl.html ftapi.html

resume:
	rsync resume.md kal@web626.webfaction.com:webapps/kalx/resume.html

clean:
	rm -f $(HTML)

FTAP = ftap.md ftap.css header.html footer.html view.js ftap.pdf

ftap.html: ftap.md ftap.css header.html footer.html view.js

copy: $(FTAP)
	cp $(FTAP) ftap.html ftapi.html /e/

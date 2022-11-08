DESTDIR ?= dist
OUTDIR := js

$(OUTDIR)/app.js: $(shell find src -type f)
	tsc --project .

clean:
	-rm -r $(OUTDIR)

install: $(DESTDIR) $(DESTDIR)/index.html $(DESTDIR)/main.js $(DESTDIR)/preview.png $(DESTDIR)/ui.css $(addprefix $(DESTDIR)/,$(wildcard *.mp3))

$(DESTDIR):
	mkdir -p $@

$(DESTDIR)/index.html: FORCE
	sed 's/src="js\/app.js"/src="main.js"/' <index.html >$@

$(DESTDIR)/main.js: $(OUTDIR)/app.js
	webpack $< --entry $(@F) --output-path $(@D) --mode production

$(DESTDIR)/preview.png: preview.png
	cp $< $@

$(DESTDIR)/ui.css: ui.css
	cp $< $@

$(DESTDIR)/%.mp3: %.mp3
	cp $< $@

FORCE:


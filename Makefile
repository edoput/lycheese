default:
	valac src/*.vala --pkg gstreamer-1.0 --pkg gtk+-3.0
doc: notes.md
	pandoc $< -s --highlight-style pygments -o  notes.html
run: main
	./main

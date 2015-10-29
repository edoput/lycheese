default:
	valac src/*.vala --pkg gstreamer-1.0 --pkg gtk+-3.0
doc: gstreamer_notes.md
	pandoc $< --standalone  -o  gstreamer_notes.html
run: application
	./application

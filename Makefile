default:
	valac src/*.vala --pkg gstreamer-1.0 --pkg gtk+-3.0 -o lycheese
doc:
	valadoc src/*.vala --pkg gstreamer-1.0 --pkg gtk+-3.0 --directory=doc --private --internal
notes: gstreamer_notes.md
	pandoc $< --standalone  -o  gstreamer_notes.html
run: lycheese
	./lycheese

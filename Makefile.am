bin_PROGRAMS = lycheese

lycheese_SOURCES = \
		   src/main.vala \
                   src/application.vala \
                   src/streaming.vala \
                   src/cookies.vala \
                   src/dialog.vala\
                   src/window.vala

lycheese_VALAFLAGS = \
		     --pkg gtk+-3.0 \
		     --pkg gstreamer-1.0

CFLAGS = \
	 $(gtk_CFLAGS) \
         $(gstreamer_CFLAGS)
LDADD = \
         $(gtk_LIBS) \
         $(gstreamer_LIBS)

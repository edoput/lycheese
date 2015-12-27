# AC_INIT (package, version, [bug-report], [tarname], [url])
AC_INIT([Lycheese],
        [0.1],
        [https://github.com/EdoPut/lycheese/issues],
        [lycheese],
        [https://github.com/EdoPut/lycheese])

AM_INIT_AUTOMAKE(
                 [1.10 no-define foreign dist-xz no-dist-gzip subdir-objects]
                 )
# check for programs
AC_PROG_CC
AM_PROG_VALAC([0.26])

# check for deps, gtk and gstreamer
PKG_CHECK_MODULES(gtk, gtk+-3.0)
PKG_CHECK_MODULES(gstreamer, gstreamer-1.0)

AC_CONFIG_FILES([
                 Makefile
                 it.edoput.Lycheese.desktop
                 ])


AC_OUTPUT

# AC_INIT (package, version, [bug-report], [tarname], [url])
AC_INIT([Lycheese],
        [1.1],
        [https://github.com/EdoPut/lycheese/issues],
        [lycheese],
        [https://github.com/EdoPut/lycheese])

# AM_INIT_AUTOMAKE ([options])
# run the macro on the makefile
# 1.10 : minimum version required to build the project
# no-define : prevent the PACKAGE and VERSION variables
#             from being AC_DEFINEd
# foreign : less strict structure of project folder
#           https://autotools.io/automake/options.html#automake.options.flavors
# dist-xz : distribute tar release with xz compression
# no-dist-gzip : do no create a gzip compressed tar release
# subdir-objects : place object files with the source file
#                  src/main.o is places in src/, where src/main.vala is
AM_INIT_AUTOMAKE(
                 [1.10 no-define foreign dist-xz no-dist-gzip subdir-objects]
                 )
# check for build deps; gcc and Valac
AC_PROG_CC
AM_PROG_VALAC([0.26])

# check for deps, gtk and gstreamer
PKG_CHECK_MODULES(gtk, gtk+-3.0)
PKG_CHECK_MODULES(gstreamer, gstreamer-1.0)

# the files to be created from their .in template
AC_CONFIG_FILES([
                 Makefile
                 it.edoput.Lycheese.desktop
                 ])

AC_OUTPUT

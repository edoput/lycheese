project(
	'lycheese',
	'vala',
	'c',
	license: 'GPL3',
	version: '1.3'
)

gtkdeps = dependency('gtk+-3.0')
gstreamerdeps = dependency('gstreamer-1.0')

source = files(
	'src/main.vala',
	'src/application.vala',
	'src/streaming.vala',
	'src/cookies.vala',
	'src/assistant.vala',
	'src/window.vala'
)
	

executable(
	'lycheese', 
	source,
	dependencies: [gtkdeps, gstreamerdeps]
)

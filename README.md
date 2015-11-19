Lycheese
========

![Lycheese running](/img/lycheese_screenshot.png)

Lycheese is an application to stream live events from your device to services like Youtube Live, Twich, Ustream etc.

# What's working?

It compiles and can stream to a server whose address is hardcoded.

# What's missing?

Getting user input for the service url.

Dynamic soure switching.

# Why The Name?

A bad pun of mine based on "Live Cheese" where cheese is one of the Gnome project apps, and imho one of the best piece of software you can get your hands on to record your funny faces :P

And yes it is a [delicious fruit][lychee_on_wikipedia]

# Structure

- main.vala
	here lies the callee of the Gtk.Application
- application.vala
	the subclass of Gtk.Application, where you can find the code that deals with the interactions
- window.vala
	the subclass of Gtk.WindowApplication, where you can find the code related to UI
- streaming.vala
	the subclass of Gst.Pipeline, where you can find the code related to the task of audio/video processing

# Build

Install libgstreamer1.0-dev, libgtk3-dev

```bash
sudo apt-get install libgstreamer1.0-dev libgtk3-dev
```
and then

```bash
make
```

# Run

```
make run
```

or 

```bash
./lycheese
```

# Install

Geez, it's not even alpha!

# Why Vala?

Don't know, seemed pretty


# Interesting branches

 - webm: I saw somewhere that we could do a live stream with WebM instead of Flash, seemed interesting; don't know the feasibility or if there really are live WebM server out there

 - x264_threaded_slice: [sliced threads][sliced_thread] can lower the latency but are inefficient

# How can I test the streaming?

Install the [simple rmtp server][srs], you can download binaries for [Ubuntu 14.04][srs_binaries], and there is a INSTALL file, just run it with `sudo ./INSTALL`.

SRS is provided with default configurations and an init script to use it.

Edit the file _/etc/init.d/srs_, replace `.CONFIG="./conf/srs.conf"` with `.CONFIG="./conf/demo.srs"`, restart the server with the command `sudo /etc/init.d/srs restart` .

Now there is a rtmp server running on your machine, it will listen to incoming streams on the url `rtmp://0.0.0.0:1935/live/livestream` and you can see them on the same url using media players live VLC.

To start the server `sudo  /etc/init.d/srs start` .
To stop the server `sudo  /etc/init.d/srs stop` .
To add it to the startup processes `sudo /etc/init.d/srs enable` .
To remove it from the startup processes `sudo  /etc/init.d/srs disable` .

Changing the init file will require a restart `sudo /etc/init.d/srs restart` .

[lychee_on_wikipedia]: https://en.wikipedia.org/wiki/Lychee
[sliced_thread]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-ugly-plugins/html/gst-plugins-ugly-plugins-x264enc.html#GstX264Enc--sliced-threads
[srs]: https://github.com/simple-rtmp-server/srs
[srs_binaries]: http://winlinvip.github.io/srs.release/releases/

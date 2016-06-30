Lycheese
========

![Lycheese running](https://cloud.githubusercontent.com/assets/4076473/16036222/36533494-321b-11e6-9be5-6b6b166de4cc.png)

Lycheese is an application to stream live events from your device to services like Youtube Live, Twich, Ustream etc.

Lycheese is Free and Open Source Software and is licensed under the GLP3 license ([what does this mean][gpl3])


# What's working?

It compiles and can stream to a server whose address is ~~hardcoded~~ provided by the user (tried with Youtube).

# How to stream

Run **Lycheese** and click on "Record and stream", the app will prompt you for the rtmp url and stream key.

# What's missing?

- [x] ~~Getting user input for the service url.~~
- [ ] Enable different video sources (screen is the only available ATM) 
- [x] Provide a mute button.
- [ ] Dynamic source switching.
- [ ] Input validation
- [x] feedback from Gstreamer to the user

# How can I contribute?

See [CONTRIBUTING.MD]()

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
- assistant.vala
        Interact with user, retrieve url, key pair
- streaming.vala
	the subclass of Gst.Pipeline, where you can find the code related to the task of audio/video processing
- cookies.vala
        the struct where are stored the inhibition cookies 

# Install from packages

Just head to the [release page](https://github.com/EdoPut/lycheese/releases) and download the **deb** package.

You can install the package with `apt-get`, `dpkg` or the Software Manager.

# Build from sources

Install `libgstreamer1.0-dev`, `libgtk-3-dev`

```bash
sudo apt-get install libgstreamer1.0-dev libgtk-3-dev gstreamer1.0-plugins-good gstreamer1.0-plugins-base gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly
```
and then

```bash
./autogen.sh
make
```

# Install from sources

Build it and then 

```bash
sudo make install
```

# Why Vala?

Don't know, seemed pretty

# Interesting branches

 - webm: I saw somewhere that we could do a live stream with WebM instead of Flash, seemed interesting; don't know the feasibility or if there really are live WebM server out there

 - `x264_threaded_slice`: [sliced threads][sliced_thread] can lower the latency but are inefficient

# How can I test the streaming?

There are two easy way, install a local rtmp server or use one like Youtube Live.

## local server

Install the [simple rmtp server][srs], you can download binaries for [Ubuntu 14.04][srs_binaries], and there is a INSTALL file, just run it with `sudo ./INSTALL`.

SRS is provided with default configurations and an init script to use it.

Edit the file _/etc/init.d/srs_, replace `.CONFIG="./conf/srs.conf"` with `.CONFIG="./conf/demo.srs"`, restart the server with the command `sudo /etc/init.d/srs restart` .

Now there is a rtmp server running on your machine, it will listen to incoming streams on the url `rtmp://0.0.0.0:1935/live/livestream` and you can see them on the same url using media players live VLC.

To start the server `sudo  /etc/init.d/srs start` .

To stop the server `sudo  /etc/init.d/srs stop` .

To add it to the startup processes `sudo /etc/init.d/srs enable` .

To remove it from the startup processes `sudo  /etc/init.d/srs disable` .

Changing the init file will require a restart `sudo /etc/init.d/srs restart` .

## youtube

Log in Youtube and go to the "Live streaming" section, scroll down till the config card, there are both the rtmp url and stream key.

[lychee_on_wikipedia]: https://en.wikipedia.org/wiki/Lychee
[gpl3]: http://www.gnu.org/licenses/gpl-faq.en.html
[sliced_thread]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-ugly-plugins/html/gst-plugins-ugly-plugins-x264enc.html#GstX264Enc--sliced-threads
[srs]: https://github.com/simple-rtmp-server/srs
[srs_binaries]: http://winlinvip.github.io/srs.release/releases/
[contributing_file]: https://github.com/EdoPut/lycheese/blob/master/CONTRIBUTING.md

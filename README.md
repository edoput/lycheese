Lycheese
========

![Lycheese running](https://cloud.githubusercontent.com/assets/4076473/21958658/c631ec9a-dab3-11e6-80e9-aded23f6ea03.png)

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

# Build from sources

Install `libgstreamer1.0-dev`, `libgtk-3-dev`, `valac`

lycheese uses the meson build system so building is as simple as running three commands

```bash
meson build
cd build
ninja
```

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

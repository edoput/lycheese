Lycheese
========

![Lycheese running](/img/lycheese_screenshot.png)

Lycheese is an application to stream live events from your device to services like Youtube Live, Twich, Ustream etc.

# Why The Name?

A bad pun of mine based on "Live Cheese" where cheese is one of the Gnome project apps, and imho one of the best piece of software you can get your hands on to record your funny faces :P

# Structure

- main.vala
	here lies the calle of the application
- application.vala
	the subclass of Gtk.Application, where you can find the code that deals with the streaming
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
./application
```

# Install

Geez, it's not even alpha!

# Why Vala?

Don't know, seemed pretty


# Interesting branches

 - webm: I saw somewhere that we could do a live stream with WebM instead of Flash, seemed interesting; don't know the feasibility or if there really are live WebM server out there

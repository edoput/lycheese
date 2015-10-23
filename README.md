Lycheese
========

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

```
make
```

# Run

```
make run
```

# Install

Geez, it's not even alpha!

// Copyright (C) 2016 Edoardo Putti
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>


using Gtk;

class Lycheese.MainWindow : Gtk.ApplicationWindow
{
	private GLib.Settings settings;

	/**
	 *  the variables we are using to build the interface
	 */
	private Gtk.ButtonBox button_box;

        private Gtk.HeaderBar header_bar;

	private Gtk.ToggleButton webcam_button;

	private Gtk.ToggleButton screen_button;


	private Gtk.Button record_button;

	private bool recording;

        private Gtk.VolumeButton volume_button;

	/**
	 * a signal on which the application can listen to start streaming
	 */
	public signal void start_streaming ();

	/**
	 * a signal on which the application can listen to stop streaming
	 */
	public signal void end_streaming ();

	/**
	 * signal to switch streaming source to default source
	 */
	public signal void switch_to_default ();

	/**
	 * signal to switch streaming source to screen
	 */
	public signal void switch_to_screen ();

	/**
	 * signal to switch streaming source to webcam
	 */
	public signal void switch_to_webcam ();
	
	/**
	 * signal to switch streaming source to both screen and webcam
	 */
	public signal void switch_to_both ();
        
        /**
         * signal to change the audio source volume
         */
        public signal void change_volume (double volume_val);

	private const GLib.ActionEntry ations[] = {
		{"settings", show_settings}
	};

	public MainWindow (Gtk.Application application)
	{
		GLib.Object (application: application);

		Gtk.Settings settings = Gtk.Settings.get_default ();

		this.init_gui();
		this.register_callback();
	}
	
	private void init_gui () {
		this.title = "Lycheese";

		this.window_position = WindowPosition.CENTER;

		this.destroy.connect (Gtk.main_quit);

                // header
                header_bar = new Gtk.HeaderBar ();

                header_bar.set_title ("Lycheese");
                header_bar.set_show_close_button (true);
                // end header

		button_box = new Gtk.ButtonBox (
	        	Gtk.Orientation.VERTICAL
		);

                // same width buttons
		//button_box.homogeneous = true;
                // fill the container
                button_box.set_layout (Gtk.ButtonBoxStyle.EXPAND);


		webcam_button = new Gtk.ToggleButton.with_label ("Webcam");
		screen_button = new Gtk.ToggleButton.with_label ("Screen");

		record_button = new Gtk.Button.from_icon_name ("media-record", Gtk.IconSize.BUTTON);
		recording = false;

                volume_button = new Gtk.VolumeButton ();

                // set default value
                volume_button.set_value (1.0);

                // place buttons inside container

		button_box.add (webcam_button);

		button_box.add (screen_button);

                // fill header
                header_bar.pack_end (volume_button);
                header_bar.pack_end (record_button);

                this.set_titlebar (header_bar);
		this.add (button_box);

		this.show_all ();

		
	}

	/**
	 * connect the toggle on/off events from buttons
	 * to the correct handler
	 */
	private void register_callback ()
	{

		record_button.clicked.connect (
			on_record_button_press_event
			);


		webcam_button.toggled.connect (
			on_webcam_button_press_event
			);

		screen_button.toggled.connect (
			on_screen_button_press_event
			);

                volume_button.value_changed.connect (
                        on_volume_change_event
                        );
	}

	public void on_record_button_press_event ()
	{
		if (recording) {
			// trigger signal to stop streaming
			end_streaming ();
			recording = false;
			var record_image = new Gtk.Image.from_icon_name("media-record", Gtk.IconSize.BUTTON);
			record_button.set_image (record_image);
		} else {
			// trigger signal to start streaming
			start_streaming ();
			recording = true;
			var stop_image = new Gtk.Image.from_icon_name("media-playback-stop", Gtk.IconSize.BUTTON);
			record_button.set_image (stop_image);
		}
		record_button.show_now ();
		return;
	}

	public void on_webcam_button_press_event ()
	{
		if (webcam_button.active)
		{
			// trigger signal to switch video
			// source to webcam
			switch_to_webcam ();

			// untoggle the other buttons
			screen_button.set_active (false);
			both_button.set_active (false);
		} else
		{
			// trigger signal to switch video
			// source to default
			switch_to_default ();
		}
		return;
	}

	public void on_screen_button_press_event ()
	{
		if (screen_button.active)
		{
			// trigger signal to switch video
			// source to screen
			switch_to_screen ();
			webcam_button.set_active (false);
		} else
		{
			// trigger signal to switch video
			// source to default
			switch_to_default ();
		}
		return;
	}

		} else
		{
			// trigger signal to switch video
			// source to default
			switch_to_default ();
		}
		return;
	}

        public void on_volume_change_event (double val)
        {
                change_volume (val); 
                return;
        }

	public void show_settings ()
	{
		return;
	}

	public void lock_source ()
	{
			screen_button.set_sensitive (false);
			webcam_button.set_sensitive (false);
	}

	public void unlock_source ()
	{
			screen_button.set_sensitive (true);
			webcam_button.set_sensitive (true);
	}
}

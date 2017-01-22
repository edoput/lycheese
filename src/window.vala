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
using Streaming;

class Lycheese.MainWindow : Gtk.ApplicationWindow
{
	private GLib.Settings settings;

	/**
	 *  the variables we are using to build the interface
	 */
	private Gtk.Grid button_box;

        private Gtk.HeaderBar header_bar;

	private Gtk.Switch webcam_button;

	private Gtk.Switch screen_button;

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
         * signal to update pipeline definition
         */
        public signal void update_pipeline (Pipeline updated_pipeline);

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
		this.resizable = false;

		this.window_position = WindowPosition.CENTER;

		this.destroy.connect (Gtk.main_quit);

                // header
                header_bar = new Gtk.HeaderBar ();

                header_bar.set_title ("Lycheese");
                header_bar.set_show_close_button (true);
                // end header

		button_box = new Gtk.Grid ();

		// same with colums
		button_box.set_column_homogeneous (true);

		var screen_label = new Gtk.Label ("Screen");

		screen_label.margin = 12;
		screen_button = new Gtk.Switch ();
		screen_button.set_halign (Gtk.Align.CENTER);
		screen_button.set_valign (Gtk.Align.CENTER);

		var webcam_label = new Gtk.Label ("Webcam");
		webcam_label.margin = 12;

		webcam_button = new Gtk.Switch ();
		webcam_button.set_halign (Gtk.Align.CENTER);
		webcam_button.set_valign (Gtk.Align.CENTER);

		button_box.attach (screen_label , 0, 0, 1, 1);
		button_box.attach (screen_button, 1, 0, 1, 1);
		button_box.attach (webcam_label , 0, 1, 1, 1);
		button_box.attach (webcam_button, 1, 1, 1, 1);

		record_button = new Gtk.Button.from_icon_name ("media-record", Gtk.IconSize.BUTTON);
		recording = false;

                volume_button = new Gtk.VolumeButton ();

                // set default value
                volume_button.set_value (1.0);

                // fill header
                header_bar.pack_end (volume_button);
                header_bar.pack_end (record_button);

                this.set_titlebar (header_bar);
                this.add (button_box);

                this.show_all ();
        }


        public void on_volume_change_event (double val)
        {
                change_volume (val); 
                return;
        }

        public void make_updated_pipeline ()
        {
                var updated_pipeline = Pipeline () {
                        volume = volume_button.get_value (),
                        screen = screen_button.get_state (),
                        webcam = webcam_button.get_state ()
                };

                update_pipeline (updated_pipeline);
                return;
        }

}

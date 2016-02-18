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

using Gst;
using GLib;
using Streaming;

/**
 * The application that has a //event loop// (required for Gstreamer
 * to function)
 */
public class Lycheese.Application : Gtk.Application
{
	/**
	 * where we store the result from the inhibition
	 * of idling, suspension, log out and switch user
	 */
	private CookieCollector cookie_collector;

	private GLib.Settings settings;

	/**
	 * the window associated to the application
	 */
	static	MainWindow main_window;
	// static  PreferencesWindow preferences_window;

	/**
	 * dialog: prompt user for rtmp url
	 */
	static RtmpUrlDialog rtmp_url_dialog;

	/**
	 * the GStreamer pipeline we use to process and
	 * stream the audio/video sources
	 */
	static  Streaming.StreamPipeline streaming_pipeline;
	

	/*
	 * Actions to be presented to the user from the
	 * application menu
	 */
	private const GLib.ActionEntry action_entries[] = {
		{ "preferences", on_preferences },
		{ "help", on_help },
		{ "about", on_about},
		{ "quit", on_quit }
	};

	/**
	 * Constructor of the Lycheese.Application class
	 */
	public Application ()
	{
		GLib.Object(
				application_id: "it.edoput.Lycheese",
				flags: ApplicationFlags.FLAGS_NONE
			   );
	}


	/**
	 * Called from the method activate to bootstrap the application
	 * and its components
	 *
	 * 1. create the main_window
	 * 2. create the streaming pipeline
	 * 3. add main_window to the application windows list
	 */
	private void common_init ()
	{
		if (this.get_windows () == null)
		{
			// var gtk_settings = Gtk.Settings.get_default ();

			// if (gtk_settings != null)
			// {
			// 	gtk_settings.Gtk_application_prefer_dark_theme = true;
			// }

			main_window = new Lycheese.MainWindow (this);

			rtmp_url_dialog = new Lycheese.RtmpUrlDialog (main_window);

			streaming_pipeline = new Streaming.StreamPipeline ();
			// Lycheese's name get displayed even without this
			// Environment.set_application_name ("Lycheese");

			this.add_window (main_window);

		}
	}


	/**
	 * main window should be a singleton
	 *
	 * called when the main application wants to run
	 * in graphic mode
	 *
	 * 1. create the main_window and present it to the user
	 * 2. create the streaming_pipeline
	 * 3. inhibit every action the device could take that
	 * would interfer with the application streaming
	 * 4. listen for signal to start/end streaming
	 */
	protected override void activate ()
	{
		if (this.get_windows () != null)
		{
			// main_window is binded to the application;
			// if it has already been created just present
			// it to the user
			main_window.present ();
		} else
		{
			common_init ();
			common_inhibit ();
			listen_for_streaming_events ();
		}
	}

	/**
	 *
	 */
	// protected override void startup ()
	// {
	// 	add_action_entries (action_entries, this);
	// 	base.startup ();
	// }

	/**
	 * Show the preferences dialog
	 */
	private void on_preferences ()
	{
	// 	if (preferences_window == null)
	// 	{
	// 		preferences_window = new SettingsWindow();
	// 		preferences_window.destroy.connect (
	// 			()=> {
	// 				preferences_window = null;
	// 			}
	// 		);
	// 		preferences_window.show_all ();
	// 	} else {
	// 		preferences_window.present ();
	// 	}
	}
	/**
	 * Display a brief help
	 */
	private void on_help ()
	{
	}
	/**
	 * Display a window with info about Lycheese
	 */
	private void on_about ()
	{
	}
	/** 
	 * Destroy the main window, close application
	 */
	private void on_quit ()
	{
		main_window.destroy ();
	}

	/**
	 * Ideally the user shouldn't be able to logout or switch,
	 * and the computer shouldn't go into suspension or idling
	 *
	 * Every inhibit action returns a different inhibit cookie
	 * that we should store to uninhibit later
	 */
	private void common_inhibit ()
	{
		cookie_collector.logout_cookie = this.inhibit (
			main_window,
			Gtk.ApplicationInhibitFlags.LOGOUT,
			"Streaming your session inhibit logout"
		);

		if (cookie_collector.logout_cookie == 0)
		{
			stderr.puts ("Could not inhibit logout");
		}

		cookie_collector.switch_user_cookie = this.inhibit (
			main_window,
			Gtk.ApplicationInhibitFlags.SWITCH,
			"Streaming your session inhibit switch"
		);

		if (cookie_collector.switch_user_cookie == 0)
		{
			stderr.puts ("Could not inhibit switching user");
		}

		cookie_collector.suspend_cookie = this.inhibit (
			main_window,
			Gtk.ApplicationInhibitFlags.SUSPEND,
			"Streaming your session inhibit suspension"
		);

		if (cookie_collector.suspend_cookie == 0)
		{
			stderr.puts ("Could not inhibit suspension");
		}

		cookie_collector.idle_cookie = this.inhibit (
			main_window,
			Gtk.ApplicationInhibitFlags.IDLE,
			"Streaming your session inhibit idle"
		);
		
		if (cookie_collector.idle_cookie == 0)
		{
			stderr.puts ("Could not inhibit idling");
		}

	}

	/**
	 * Introduced to listen for signals from the main_window.
	 *
	 * Application listen for these signals from main_window
	 *
	 * - start_streaming
	 * - end_streaming
	 * - switch_to_default
	 * - switch_to_screen
	 * - switch_to_webcam
	 * - switch_to_both
         *
         * Application listen for these signals from the rtmp_url_dialog
         *
         * - url_entered
         *
	 * 
	 * [[https://wiki.gnome.org/Projects/Vala/SignalsAndCallbacks|signal in vala]]
	 * [[http://valadoc.org/#!api=gobject-2.0/GLib.Signal|signals in GLib]]
	 */
	private void listen_for_streaming_events ()
	{
		// when start_streaming is recieved
		// display the dialog asking the url
		main_window.start_streaming.connect (
			request_url
			);

		// when end_streaming is recieved
		// stop the pipeline
		main_window.end_streaming.connect (
			stop_streaming
			);
			
		// when switch_to_default is recieved
		// set the source of the pipeline to
		// the default one
		main_window.switch_to_default.connect (
			switch_to_default_source
			);

		// when switch_to_screen is recieved
		// set the source of the pipeline to
		// the screen
		main_window.switch_to_screen.connect (
			switch_to_screen_source
			);

		// when switch_to_webcam is recieved
		// set the source of the pipeline to
		// the webcam
		main_window.switch_to_webcam.connect (
			switch_to_webcam_source
			);

		// when switch_to_both is recieved
		// set the source of the pipeline to
		// both screen and webcam
		main_window.switch_to_both.connect (
			switch_to_both_source
			);

		// when the user enter the url and key
		// pair pass it to the pipeline and
		// start streaming
		rtmp_url_dialog.url_entered.connect (
			start_streaming
		);
	}

	/**
	 * show the dialog asking the url, key pair
	 */
	public void request_url ()
	{
		rtmp_url_dialog.show_all ();
	}

	/**
	 * start the streaming_pipeline
	 */
	private void start_streaming (string url, string key)
	{
		streaming_pipeline.set_rtmp (url, key);
		streaming_pipeline.stream ();
	}

	/**
	 * stop the streaming_pipeline
	 */
	private void stop_streaming ()
	{
		streaming_pipeline.end_stream ();
	}

	/**
	 * switch the streaming_pipeline to the default
	 * source
	 */
	private void switch_to_default_source ()
	{
		streaming_pipeline.stream_default ();
	}

	/**
	 * set the streaming_pipeline source to screen
	 */
	private void switch_to_screen_source ()
	{
		streaming_pipeline.stream_screen ();
	}

	/**
	 * set the streaming_pipeline source to screen
	 */
	private void switch_to_webcam_source ()
	{
		streaming_pipeline.stream_webcam ();
	}

	/**
	 * set the streaming_pipeline source to screen
	 */
	private void switch_to_both_source ()
	{
		streaming_pipeline.stream_both ();
	}
}

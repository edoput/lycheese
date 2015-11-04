using Gst;
using GLib;
using Streaming;

/**
 * The application that has a event_loop, required for Gstreamer
 * to function
 */
public class Lycheese.Application : Gtk.Application
{

	private CookieCollector cookie_collector;
	private GLib.Settings settings;
	static	MainWindow main_window;
	// static  PreferencesWindow preferences_window;
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
	 * 
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

			streaming_pipeline = new Streaming.StreamPipeline ();
			// Lycheese's name get displayed even without this
			// Environment.set_application_name ("Lycheese");

			this.add_window (main_window);

		}
	}


	/**
	 * main window should be a singleton
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
			main_window.present ();
		}
		else
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
	 * MainWindow has to signals:
	 * - start_streaming
	 * - end_streaming
	 * 
	 * triggered when the user want to start or end the streaming
	 *
	 * signals in vala https://wiki.gnome.org/Projects/Vala/SignalsAndCallbacks
	 * signals in GLib http://valadoc.org/#!api=gobject-2.0/GLib.Signal
	 */
	private void listen_for_streaming_events ()
	{
		// when start_streaming is recieved
		// start the pipeline
		main_window.start_streaming.connect (
			start_streaming
			);
		// when end_streaming is recieved
		// stop the pipeline
		main_window.end_streaming.connect (
			stop_streaming
			);
	}

	/**
	 * start the streaming_pipeline
	 */
	private void start_streaming ()
	{
		streaming_pipeline.stream ();
	}

	/**
	 * stop the streaming_pipeline
	 */
	private void stop_streaming ()
	{
		streaming_pipeline.end_stream ();
	}

}

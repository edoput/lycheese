using Gst;
using GLib;
using Streaming;

public class Lycheese.Application : Gtk.Application
{

	private CookieCollector cookie_collector;
	private GLib.Settings settings;
	static	MainWindow main_window;
	static  Streaming.StreamPipeline streaming_pipeline;
	

	private const GLib.ActionEntry action_entries[] = {
		{ "quit", on_quit }
	};

	public Application ()
	{
		GLib.Object(
				application_id: "it.edoput.Lycheese",
				flags: ApplicationFlags.FLAGS_NONE
			   );
	}

	// protected override void startup ()
	// {
	// 	settings = new GLib.Settings ("it.edoput.Lycheese");

	// 	add_action_entries (action_entries, this);

	// }

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
	 * Destroy the main window, close application
	 */
	private void on_quit ()
	{
		main_window.destroy ();
	}

	/**
	 * Ideally the user shouldn't be able to logout or switch,
	 * and the computer shouldn't go into suspension or idling
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


	private void listen_for_streaming_events ()
	{
		main_window.start_streaming.connect (
			start_streaming
			);

		main_window.end_streaming.connect (
			stop_streaming
			);
	}
	/**
	 * start/stop the pipeline
	 */
	private void start_streaming ()
	{
		streaming_pipeline.stream ();
	}


	private void stop_streaming ()
	{
		streaming_pipeline.end_stream ();
	}

}

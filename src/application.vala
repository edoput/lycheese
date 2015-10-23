using Gst;
using GLib;
using Streaming;

public class Lycheese.Application : Gtk.Application
{

	private GLib.Settings settings;
	static	MainWindow main_window;
	static  Streaming.StreamPipeline streaming_pipeline;
	static  GLib.Notification on_air_notification;

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

			streaming_pipeline.stream ();
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
	 *
	 */
	// private bool on_screen_key_pressed (Gdk.EventKey event)
	//	{
	//		if (event.state != 0
	//			&& (
	//				(
	//					event.state & Gdk.ModifierType.CONTROL_MASK != 0
	//				)
	//
	//				||
	//
	//				(
	//					event.state & 
	//	}
}

using Gst;
using GLib;

public class Lycheese.Application : Gtk.Application
{

	private GLib.Settings settings;
	static	MainWindow main_window;
	
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

			this.add_window (main_window);
			
		}
	}

	public Application ()
	{
		GLib.Object(
			application_id: "it.edoput.Lycheese",
			flags: ApplicationFlags.FLAGS_NONE
			);
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
}


using Gtk;

class Lycheese.MainWindow : Gtk.ApplicationWindow
{
	private GLib.Settings settings;

	/**
	 *  the variables we are using to build the interface
	 */
	private Gtk.ButtonBox button_box;

	private Gtk.ToggleButton record_button;

	private Gtk.ToggleButton webcam_button;

	private Gtk.ToggleButton screen_button;

	private Gtk.ToggleButton both_button;

	/**
	 * a signal on which the application can listen to start streaming
	 */
	public signal void start_streaming ();

	/**
	 * a signal on which the application can listen to stop streaming
	 */
	public signal void end_streaming ();

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

		button_box = new Gtk.ButtonBox (
	        	Gtk.Orientation.VERTICAL
		);

		button_box.homogeneous = true;

		record_button = new Gtk.ToggleButton.with_label ("Record and stream");

		webcam_button = new Gtk.ToggleButton.with_label ("Webcam");
		screen_button = new Gtk.ToggleButton.with_label ("Screen");
		both_button = new Gtk.ToggleButton.with_label ("Both");

		button_box.add (record_button);

		button_box.add (webcam_button);

		button_box.add (screen_button);

		button_box.add (both_button);

		this.add (button_box);

		this.show_all ();

		
	}

	private void register_callback ()
	{
		record_button.toggled.connect (
			on_record_button_press_event
			);
	}

	public void on_record_button_press_event ()
	{
		if (record_button.active)
		{
			// trigger signal to start streaming
			start_streaming ();
		} else
		{
			// trigger signal to stop streaming
			end_streaming ();
		}
		return;
	}

	public void on_webcam_button_press_event ()
	{
		return;
	}

	public void on_screen_button_press_event ()
	{
		return;
	}

	public void on_both_button_press_event ()
	{
		return;
	}

	public void show_settings ()
	{
		return;
	}
}

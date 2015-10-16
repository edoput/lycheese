
// int main (string[] args)
// {
// 	Gtk.init(ref args);
// 	
// 	var window = new Window();
// 	window.title = "Lycheese - a streaming solution";
// 	window.window_position = WindowPosition.CENTER;
// 	window.destroy.connect (Gtk.main_quit);
// 
// 	var top_widget = new Gtk.Grid();
// 	var webcam_button = new Gtk.ToggleButton.with_label ("Webcam");
// 	var screen_button = new Gtk.ToggleButton.with_label ("Screen");
// 	var both_button = new Gtk.ToggleButton.with_label ("Both");
// 
// 	top_widget.attach (webcam_button, 0, 0);
// 	top_widget.attach (screen_button, 1, 0);
// 	top_widget.attach (both_button, 2, 0);
// 
// 	window.add (top_widget);
// 
// 	window.show_all ();
// 	Gtk.main();
// 	return 0;
// }

using Gtk;

class Lycheese.MainWindow : Gtk.ApplicationWindow
{
	private GLib.Settings settings;

//	private Cheese.Camera camera;

	private const GLib.ActionEntry ations[] = {
		{"settings", show_settings}
	};

	public MainWindow (Gtk.Application application)
	{
		GLib.Object (application: application);

		Gtk.Settings settings = Gtk.Settings.get_default ();
		this.init_gui();
	}
	
	private void init_gui () {
		this.title = "Lycheese";
		this.window_position = WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		var top_widget = new Gtk.Grid ();

		var webcam_button = new Gtk.ToggleButton.with_label ("Webcam");
		var screen_button = new Gtk.ToggleButton.with_label ("Screen");
		var both_button = new Gtk.ToggleButton.with_label ("Both");
		top_widget.attach (webcam_button, 0, 0);
		top_widget.attach (screen_button, 1, 0);
		top_widget.attach (both_button, 2, 0);

		this.add (top_widget);

		this.show_all ();
	}

	public void on_webcam_button_press_event ()
	{
		return;
	}

	public void show_settings ()
	{
		return;
	}
}

using GLib;
using Gtk;

/**
 * A dialog with two text entry
 */
class Lycheese.RtmpUrlDialog : Gtk.Dialog
{
	/**
	 * Variable to hold Dialog flags
	 */
	private Gtk.DialogFlags dialog_flags;

	/**
	 * Variable to hold the rtmp url provided by the user
	 */
	static Gtk.Entry url_entry;

	/**
	 *  Variable to hold the rtmp key provided by the user
	 */
	static Gtk.Entry key_entry;

	/**
	 * Signal to change rtmp url to listening application
	 */
	public signal void change_rtmp_url ();

	/**
	 * Signal to change rtmp key to listening application
	 */
	public signal void change_stream_key ();

	/**
	 * RtmpUrlDialog constructor
	 */
	public RtmpUrlDialog (Gtk.Window main_window)
	{
		init ();
		create_widget (main_window);
	}

	private void init ()
	{
//		dialog_flags = Gtk.DialogFlags
	}

	/**
	 * Create the widget
	 *
	 * set_transient_for is 
	 */
	private void create_widget (Gtk.Window main_window)
	{
		this.title = "Lycheese";
		url_entry = new Gtk.Entry();
		var url_label = new Gtk.Label.with_mnemonic ("_url");
		url_label.mnemonic_widget = url_entry;

		key_entry = new Gtk.Entry();
		var key_label = new Gtk.Label.with_mnemonic ("_key");
		key_label.mnemonic_widget = key_entry;

		var hbox = new Gtk.Box (
			Gtk.Orientation.HORIZONTAL,
			20
		);

		hbox.pack_start (url_label);
		hbox.pack_start (url_entry);

		hbox.pack_start (key_label);
		hbox.pack_start (key_entry);
		
		var content = get_content_area () as Box;

		content.pack_start (hbox);


		add_button (Stock.HELP, ResponseType.HELP);
		add_button (Stock.CONNECT, ResponseType.APPLY);

		this.set_transient_for (main_window);

		// show_all ();
	}

	private void register_callback ()
	{
		url_entry.changed.connect(
			on_url_changed
		);

		key_entry.changed.connect(
			on_key_changed
		);
	}

	private void on_url_changed ()
	{
		stdout.puts (url_entry.text);
		change_rtmp_url ();
	}

	private void on_key_changed ()
	{
		stdout.puts (key_entry.text);
		change_stream_key ();
	}

	private void on_response (Gtk.Dialog source, int response_id)
	{
		switch (response_id)
		{
			case (ResponseType.HELP):
				break;
			case (ResponseType.APPLY):
				break;
		}
	}
}

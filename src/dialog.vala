using GLib;
using Gtk;

class Lycheese.RtmpUrlDialog : Gtk.Dialog
{
	private Gtk.DialogFlags dialog_flags;

	static Gtk.Entry url_entry;
	static Gtk.Entry key_entry;

	public RtmpUrlDialog ()
	{
		init ();
		create_widget ();
	}

	private void init ()
	{
//		dialog_flags = Gtk.DialogFlags
	}

	private void create_widget ()
	{
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

		show_all ();
	}
}

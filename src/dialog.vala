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
	 * Signal to pass the server url
	 */
	public signal void url_entered (string url, string key);

	/**
	 * RtmpUrlDialog constructor
	 */
	public RtmpUrlDialog (Gtk.Window main_window)
	{
		init ();
		create_widget (main_window);
		this.response.connect (on_response);
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

	}

	private void on_response (Gtk.Dialog source, int response_id)
	{
		switch (response_id)
		{
			case (ResponseType.HELP):
				break;
			case (ResponseType.APPLY):
				// signal the listener that we have a
				// new url, key pair
				url_entered (
					url_entry.text,
					key_entry.text
					);
				// hide the dialog without destroying it
				hide ();
				break;
		}
	}
}

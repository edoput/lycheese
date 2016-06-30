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
class Lycheese.Assistant : Gtk.Assistant
{
	/**
	 * Variable to hold the rtmp url provided by the user
	 */
	static Gtk.Entry url_entry;

	/**
	 *  Variable to hold the rtmp key provided by the user
	 */
	static Gtk.Entry key_entry;

        /**
         * Variables to hold the assistant pages
         */
        Gtk.Label introduction;
        Gtk.Grid  credentials;

        Gtk.Label url_label;
        Gtk.Label key_label;

        /**
         * Signal to pass the server url
         */
        public signal void url_entered (string url, string key);

        /**
         * Signal; the assistant has been canceled
         */
        public signal void assistant_cancel ();

        public Assistant ()
        {

                this.apply.connect (complete);
                this.cancel.connect (hide_on_cancel);

                introduction = new Gtk.Label ("Complete this procedure to begin streaming");
                int page_num = this.append_page (introduction);
                this.set_page_title (introduction, "Introduction");
                this.set_page_type (introduction, Gtk.AssistantPageType.INTRO);
                this.set_page_complete (introduction, true);


                url_label = new Gtk.Label ("url");
                url_entry = new Gtk.Entry ();
                url_entry.set_input_purpose (Gtk.InputPurpose.URL);

                key_label = new Gtk.Label ("key");
                key_entry = new Gtk.Entry ();
                key_entry.set_visibility (false);
                key_entry.set_input_purpose (Gtk.InputPurpose.PASSWORD);

                credentials = new Gtk.Grid ();
                credentials.set_row_homogeneous (true);
                credentials.set_column_homogeneous (true);

                credentials.attach (url_label, 0, 0, 1, 1);
                credentials.attach (url_entry, 1, 0, 1, 1);

                credentials.attach (key_label, 0, 1, 1, 1);
                credentials.attach (key_entry, 1, 1, 1, 1);

                page_num = this.append_page (credentials);
                this.set_page_title (credentials, "Enter credentials");
                this.set_page_type (credentials, Gtk.AssistantPageType.CONFIRM);
                this.set_page_complete (credentials, true);
        }

        void complete ()
        {
                url_entered (url_entry.get_text (), key_entry.get_text ());
                url_entry.set_text ("");
                key_entry.set_text ("");

                hide ();
        }

        void hide_on_cancel ()
        {
                assistant_cancel ();
                hide ();
        }
}

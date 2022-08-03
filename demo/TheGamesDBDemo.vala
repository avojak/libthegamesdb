/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com> (https://avojak.com)
 */

public class TheGamesDB.Demo : Gtk.Application {

    private static GLib.Once<TheGamesDB.Demo> instance;
    public static unowned TheGamesDB.Demo get_instance () {
        return instance.once (() => { return new TheGamesDB.Demo (); });
    }

    public string api_key { get; set; default = ""; }

    construct {
        application_id = "com.github.avojak.thegamesdb.demo";
        flags = ApplicationFlags.FLAGS_NONE;
    }

    public override void activate () {
        var api_key_entry = new Gtk.Entry () {
            placeholder_text = "API Key",
            max_width_chars = 64 // API keys are 64 chars long
        };
        api_key_entry.changed.connect (() => {
            api_key = api_key_entry.text.strip ();
        });

        var header_bar = new Gtk.HeaderBar () {
            show_close_button = true,
            has_subtitle = false,
            custom_title = api_key_entry
        };
        var window = new Gtk.ApplicationWindow (this);
        window.set_titlebar (header_bar);

        var main_stack = new Gtk.Stack ();
        main_stack.add_titled (new GamesView (), "games", "Games");

        var stack_sidebar = new Gtk.StackSidebar ();
        stack_sidebar.stack = main_stack;

        var paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL) {
            position = 120
        };
        paned.pack1 (stack_sidebar, false, false);
        paned.pack2 (main_stack, true, false);

        window.add (paned);
        window.set_default_size (600, 400);
        window.set_size_request (600, 400);
        window.title = "TheGamesDB Demo";

        add_window (window);
        window.show_all ();
    }

    public static int main (string[] args) {
        return get_instance ().run (args);
    }

}

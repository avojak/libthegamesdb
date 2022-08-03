/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com> (https://avojak.com)
 */

public class GamesView : Gtk.Grid {

    public GamesView () {
        Object (
            expand: true
        );
    }

    construct {
        var games_stack = new Gtk.Stack ();
        games_stack.add_titled (new GamesByName (), "games-by-name", "Games by Name");

        var stack_sidebar = new Gtk.StackSidebar ();
        stack_sidebar.stack = games_stack;

        var paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL) {
            position = 120
        };
        paned.pack1 (stack_sidebar, false, false);
        paned.pack2 (games_stack, true, false);

        add (paned);
    }

}

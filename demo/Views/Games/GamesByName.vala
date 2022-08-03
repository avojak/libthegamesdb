/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com> (https://avojak.com)
 */

public class GamesByName : Gtk.Grid {

    private Gtk.Entry name_entry;
    private Gtk.Button search_button;

    private Gee.Map<TheGamesDB.GameFieldFlags, Gtk.CheckButton> fields_mapping;

    private TheGamesDB.Client client;

    public GamesByName () {
        Object (
            row_spacing: 10,
            column_spacing: 10,
            margin: 20,
            expand: true
        );
    }

    construct {
        var name_label = new Gtk.Label ("Name:") {
            halign = Gtk.Align.END
        };
        name_entry = new Gtk.Entry () {
            halign = Gtk.Align.FILL,
            hexpand = true
        };

        var fields_label = new Gtk.Label ("Fields:") {
            valign = Gtk.Align.START,
            halign = Gtk.Align.END
        };
        var fields_box = new Gtk.FlowBox () {
            row_spacing = 4,
            column_spacing = 4
        };

        fields_mapping = new Gee.HashMap<TheGamesDB.GameFieldFlags, Gtk.CheckButton> ();
        foreach (var field_flag in TheGamesDB.Utils.EnumUtils.get_values<TheGamesDB.GameFieldFlags> ()) {
            if (field_flag == TheGamesDB.GameFieldFlags.NONE) {
                continue;
            }
            var button = new Gtk.CheckButton.with_label (TheGamesDB.Utils.EnumUtils.get_nick (field_flag));
            fields_mapping.set (field_flag, button);
            fields_box.add (button);
        }

        search_button = new Gtk.Button.with_label ("Search") {
            halign = Gtk.Align.START,
            sensitive = false,
            hexpand = false
        };
        search_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

        attach (name_label, 0, 0);
        attach (name_entry, 1, 0);
        attach (fields_label, 0, 1);
        attach (fields_box, 1, 1);
        attach (search_button, 1, 2);

        //  api_key_entry.changed.connect (update_search_button_sensitivity);
        TheGamesDB.Demo.get_instance ().notify["api-key"].connect (update_search_button_sensitivity);
        name_entry.changed.connect (update_search_button_sensitivity);
        search_button.clicked.connect (() => {
            client = new TheGamesDB.Client (TheGamesDB.Demo.get_instance ().api_key);
            //  var request = new TheGamesDB.GamesByNameRequest (name_entry.text, null, TheGamesDB.GameFieldFlags.RATING, TheGamesDB.GameIncludeFlags.BOXART);
            //  client.request (request);
            //  client.search_games (name_entry.text);
            var fields = TheGamesDB.GameFieldFlags.NONE;
            foreach (var entry in fields_mapping.entries) {
                if (entry.value.get_active ()) {
                    fields |= entry.key;
                }
            }
            var request = new TheGamesDB.GamesByNameRequest (name_entry.text) {
                fields = fields,
                include = TheGamesDB.GameIncludeFlags.BOXART
            };
            client.request_async.begin<Gee.List<TheGamesDB.Game>> (request, (obj, res) => {
                try {
                    var games = client.request_async.end<Gee.List<TheGamesDB.Game>> (res);
                    foreach (var game in games) {
                        print (game.to_string ());
                    }
                } catch (GLib.Error e) {
                    printerr ("%s\n", e.message);
                }
            });
        });
    }

    private void update_search_button_sensitivity () {
        search_button.sensitive = (TheGamesDB.Demo.get_instance ().api_key.length > 0)
            && (name_entry.text.strip ().length > 0);
    }

}

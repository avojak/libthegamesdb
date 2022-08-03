/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

/**
 * Models a game retrieved from the API.
 */
public class TheGamesDB.Game : GLib.Object {

    public int id { get; set; }
    public string? game_title { get; set; }
    public string? release_date { get; set; }
    public int platform_id { get; set; }
    public int players { get; set; }
    public string? overview { get; set; }
    public string? last_updated { get; set; }
    public string? rating { get; set; }
    public string? coop { get; set; }
    public string? youtube { get; set; }
    public string? os { get; set; }
    public string? processor { get; set; }
    public string? ram { get; set; }
    public string? hdd { get; set; }
    public string? video { get; set; }
    public string? sound { get; set; }
    public Gee.List<int> developer_ids { get; set; default = new Gee.ArrayList<int> (); }
    public Gee.List<int> genre_ids { get; set; default = new Gee.ArrayList<int> (); }
    public Gee.List<int> publisher_ids { get; set; default = new Gee.ArrayList<int> (); }
    public Gee.List<string> alternative_ids { get; set; default = new Gee.ArrayList<string> (); }
    public Gee.List<TheGamesDB.GameImage> boxart { get; set; default = new Gee.ArrayList<TheGamesDB.GameImage> (); }

    public Game.from_json (Json.Object json_object) {
        Object (
            id: (int) json_object.get_int_member ("id"),
            game_title: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "game_title"),
            release_date: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "release_date"),
            platform_id: TheGamesDB.Utils.JsonUtils.int_or (json_object, "platform", -1),
            players: TheGamesDB.Utils.JsonUtils.int_or (json_object, "players", -1),
            overview: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "overview"),
            last_updated: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "last_updated"),
            rating: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "rating"),
            coop: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "coop"),
            youtube: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "youtube"),
            os: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "os"),
            processor: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "processor"),
            ram: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "ram"),
            hdd: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "hdd"),
            video: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "video"),
            sound: TheGamesDB.Utils.JsonUtils.string_or_null (json_object, "sound"),
            developer_ids: TheGamesDB.Utils.JsonUtils.int_list_or_empty (json_object, "developers"),
            genre_ids: TheGamesDB.Utils.JsonUtils.int_list_or_empty (json_object, "genres"),
            publisher_ids: TheGamesDB.Utils.JsonUtils.int_list_or_empty (json_object, "publishers"),
            alternative_ids: TheGamesDB.Utils.JsonUtils.string_list_or_empty (json_object, "alternatives")
        );
    }

    public string to_string () {
        var sb = new GLib.StringBuilder ();
        sb.append_printf ("> id: %d\n", id);
        sb.append_printf ("  game_title: %s\n", game_title);
        sb.append_printf ("  release_date: %s\n", release_date);
        sb.append_printf ("  platform: %d\n", platform_id);
        sb.append_printf ("  players: %d\n", players);
        sb.append_printf ("  overview: %s\n", overview);
        sb.append_printf ("  last_updated: %s\n", last_updated);
        sb.append_printf ("  rating: %s\n", rating);
        sb.append_printf ("  coop: %s\n", coop);
        sb.append_printf ("  youtube: %s\n", youtube);
        sb.append_printf ("  os: %s\n", os);
        sb.append_printf ("  processor: %s\n", processor);
        sb.append_printf ("  ram: %s\n", ram);
        sb.append_printf ("  hdd: %s\n", hdd);
        sb.append_printf ("  video: %s\n", video);
        sb.append_printf ("  sound: %s\n", sound);
        sb.append ("  developer_ids:\n");
        foreach (var developer in developer_ids) {
            sb.append_printf ("    %d\n", developer);
        }
        sb.append ("  genre_ids:\n");
        foreach (var genre in genre_ids) {
            sb.append_printf ("    %d\n", genre);
        }
        sb.append ("  publisher_ids:\n");
        foreach (var publisher in publisher_ids) {
            sb.append_printf ("    %d\n", publisher);
        }
        sb.append ("  alternative_ids:\n");
        foreach (var alternative in alternative_ids) {
            sb.append_printf ("    %s\n", alternative);
        }
        return (owned) sb.str;
    }

}

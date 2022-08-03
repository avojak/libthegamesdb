/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

/**
 * Models a platform retrieved from the API.
 */
 public class TheGamesDB.Platform : GLib.Object {

    public int id { get; set; }
    public string? name { get; set; }
    public string? alias { get; set; }
    public string? icon { get; set; }
    public string? console { get; set; }
    public string? controller { get; set; }
    public string? developer { get; set; }
    public string? overview { get; set; }

}

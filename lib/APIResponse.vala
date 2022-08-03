/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

/**
 * Models a generic response from the API.
 */
internal class TheGamesDB.APIResponse : GLib.Object {

    /**
     * Models the section of the response for paged data if the endpoint supports paged responses.
     */
    internal class Pages : GLib.Object {

        internal string? previous { get; set; }
        internal string? current { get; set; }
        internal string? next { get; set; }

    }

    internal uint code { get; set; }
    internal string status { get; set; }
    internal uint remaining_monthly_allowance { get; set; }
    internal uint extra_allowance { get; set; }
    internal uint allowance_refresh_timer { get; set; }
    internal GLib.Object? data { get; set; }
    internal GLib.Object? include { get; set; }
    internal Pages? pages { get; set; }

    internal bool has_next () {
        return pages != null && pages.next != null;
    }

}

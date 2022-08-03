/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com> (https://avojak.com)
 */

public class TheGamesDB.ClientTest {

    private static void test_client () {
        var json_file = TheGamesDB.TestUtils.get_test_data ("games-by-name-request.json");
    }

    public static void main (string[] args) {
        GLib.Test.init (ref args);
        GLib.Test.add_func ("/client", test_client);
        GLib.Test.run ();
    }

}

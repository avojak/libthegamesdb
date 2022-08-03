/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com> (https://avojak.com)
 */

public class TheGamesDB.TestUtils {

    public static GLib.File get_test_data (string filename) {
        return GLib.File.new_for_path (GLib.Test.get_filename (GLib.Test.FileType.DIST, "data", filename));
    }

}

/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

 public enum TheGamesDB.GameIncludeFlags {

    NONE = 0,
    BOXART = (1u << 0),
    PLATFORM = (1u << 1);

    public string get_parameter_name () {
        switch (this) {
            case BOXART:
                return "boxart";
            case PLATFORM:
                return "platform";
            default:
                assert_not_reached ();
        }
    }

    public static string[] get_masked_parameters (int flags) {
        Gee.List<string> values = new Gee.ArrayList<string> ();
        foreach (var flag in TheGamesDB.Utils.EnumUtils.get_values<GameIncludeFlags> ()) {
            if (flag == GameIncludeFlags.NONE) {
                continue;
            }
            if ((flags & flag) == flag) {
                values.add (flag.get_parameter_name ());
            }
        }
        return values.to_array ();
    }

}

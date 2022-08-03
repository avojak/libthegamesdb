/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

public enum TheGamesDB.GameFieldFlags {

    NONE = 0,
    PLAYERS = (1u << 0),
    PUBLISHERS = (1u << 1),
    GENRES = (1u << 2),
    OVERVIEW = (1u << 3),
    LAST_UPDATED = (1u << 4),
    RATING = (1u << 5),
    PLATFORM = (1u << 6),
    COOP = (1u << 7),
    YOUTUBE = (1u << 8),
    OS = (1u << 9),
    PROCESSOR = (1u << 10),
    RAM = (1u << 11),
    HDD = (1u << 12),
    VIDEO = (1u << 13),
    SOUND = (1u << 14),
    ALTERNATIVES = (1u << 15);

    private string get_parameter_name () {
        switch (this) {
            case PLAYERS:
                return "players";
            case PUBLISHERS:
                return "publishers";
            case GENRES:
                return "genres";
            case OVERVIEW:
                return "overview";
            case LAST_UPDATED:
                return "last_updated";
            case RATING:
                return "rating";
            case PLATFORM:
                return "platform";
            case COOP:
                return "coop";
            case YOUTUBE:
                return "youtube";
            case OS:
                return "os";
            case PROCESSOR:
                return "processor";
            case RAM:
                return "ram";
            case HDD:
                return "hdd";
            case VIDEO:
                return "video";
            case SOUND:
                return "sound";
            case ALTERNATIVES:
                return "alternatives";
            default:
                assert_not_reached ();
        }
    }

    public static string[] get_masked_parameters (int flags) {
        Gee.List<string> values = new Gee.ArrayList<string> ();
        foreach (var flag in TheGamesDB.Utils.EnumUtils.get_values<GameFieldFlags> ()) {
            if (flag == GameFieldFlags.NONE) {
                continue;
            }
            if ((flags & flag) == flag) {
                values.add (flag.get_parameter_name ());
            }
        }
        return values.to_array ();
    }

}

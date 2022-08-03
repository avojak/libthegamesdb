/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

public class TheGamesDB.GameImage : GLib.Object {

    public enum Type {
        FANART,
        BANNER,
        BOXART,
        SCREENSHOT,
        CLEARLOGO,
        TITLESCREEN;
    }

    public enum Side {
        FRONT,
        BACK;
    }

    public enum Scale {
        ORIGINAL,
        SMALL,
        THUMB,
        CROPPED_CENTER_THUMB,
        MEDIUM,
        LARGE;
    }

    public int id { get; private set; }
    public Type image_type { get; private set; }
    public Side? side { get; private set; }
    public string? resolution { get; private set; }
    public Gee.Map<Scale, string> urls { get; private set; }

}

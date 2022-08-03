/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

/**
 * Contains a collection of enum utility functions.
 */
namespace TheGamesDB.Utils.EnumUtils {

    /**
     * Retrieves all the values in the enum as an array.
     *
     * @return A new array containing all the values contained in the enum.
     */
    internal static T[] get_values<T> () {
        assert (typeof (T).is_enum ());
        EnumClass enumc = (EnumClass) typeof (T).class_ref ();
        int[] values = new int[enumc.n_values];
        int i = 0;
        foreach (unowned EnumValue enum_value in enumc.values) {
            values[i] = enum_value.@value;
            i++;
        }
        return (T[]) values;
    }

    /**
     * Get the enum nick.
     */
    internal static string get_nick<T> (T val) {
        EnumClass enumc = (EnumClass) typeof (T).class_ref ();
        unowned EnumValue? eval = enumc.get_value ((int) val);
        return_val_if_fail (eval != null, null);
        return eval.value_nick;
    }

}

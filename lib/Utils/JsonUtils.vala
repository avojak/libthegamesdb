/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

/**
 * Contains a collection of JSON utility functions.
 */
namespace TheGamesDB.Utils.JsonUtils {

    /**
     * Returns the integer member with the given name, or the default value if not present.
     *
     * @param json_object the {@link Json.Object} from which to search for the member
     * @param member_name the name of the integer member
     * @param default_value the default value to return if the member is not present
     * @return the integer value of the member if present, otherwise the default value
     */
    internal static int int_or (Json.Object json_object, string member_name, int default_value) {
        if (!json_object.has_member (member_name)) {
            return default_value;
        }
        return (int) json_object.get_int_member (member_name);
    }

    /**
     * Returns the string member with the given name, or the default value if not present.
     *
     * @param json_object the {@link Json.Object} from which to search for the member
     * @param member_name the name of the string member
     * @param default_value the default value to return if the member is not present
     * @return the string value of the member if present, otherwise the default value
     */
    //  internal static string string_or (Json.Object json_object, string member_name, string default_value) {
    //      if (!json_object.has_member (member_name)) {
    //          return default_value;
    //      }
    //      return json_object.get_string_member (member_name);
    //  }

    /**
     * Returns the string member with the given name, or null if not present.
     *
     * @param json_object the {@link Json.Object} from which to search for the member
     * @param member_name the name of the string member
     * @return the string value of the member if present, otherwise null
     */
    internal static string? string_or_null (Json.Object json_object, string member_name) {
        if (!json_object.has_member (member_name)) {
            return null;
        }
        return json_object.get_string_member (member_name);
    }

    /**
     * Returns the integer list member with the given name, or an empty list value if not present.
     *
     * @param json_object the {@link Json.Object} from which to search for the member
     * @param member_name the name of the integer list member
     * @return the integer list value of the member if present, otherwise an empty list
     */
    internal static Gee.List<int> int_list_or_empty (Json.Object json_object, string member_name) {
        var values = new Gee.ArrayList<int> ();
        if (!json_object.has_member (member_name)) {
            return values;
        }
        json_object.get_array_member (member_name).foreach_element ((array, index, element_node) => {
            values.add ((int) element_node.get_int ());
        });
        return values;
    }

    /**
     * Returns the string list member with the given name, or an empty list value if not present.
     *
     * @param json_object the {@link Json.Object} from which to search for the member
     * @param member_name the name of the string list member
     * @return the string list value of the member if present, otherwise an empty list
     */
    internal static Gee.List<string> string_list_or_empty (Json.Object json_object, string member_name) {
        var values = new Gee.ArrayList<string> ();
        if (!json_object.has_member (member_name)) {
            return values;
        }
        json_object.get_array_member (member_name).foreach_element ((array, index, element_node) => {
            values.add (element_node.get_string ());
        });
        return values;
    }

}

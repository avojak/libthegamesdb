/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

namespace TheGamesDB {

    /**
     * Base class for requests to paged API endpoints.
     */
    protected abstract class AbstractPagedRequest<T> : AbstractRequest<Gee.List<T>> {

        private const string PARAM_PAGE = "page";

        internal uint page { get; set; default = 1; }

        protected new Gee.List<T> execute (Rest.Proxy proxy, string api_key) throws GLib.Error {
            Gee.List<T> results = new Gee.ArrayList<T> ();
            APIResponse api_response = null;
            do {
                // Build the request
                var call = create_proxy_call (proxy, api_key);
                call.add_param (PARAM_PAGE, page.to_string ());

                // Execute the request
                call.sync ();

                // Parse the response and return the deserialized object
                var json_parser = new Json.Parser ();
                json_parser.load_from_data (call.get_payload ());
                //  print ("%s\n", call.get_payload ());
                api_response = Json.gobject_deserialize (typeof (APIResponse), json_parser.get_root ()) as APIResponse;
                var root_object = json_parser.get_root ().get_object ();
                var data_object = root_object.get_object_member (DATA_OBJECT);
                var include_object = root_object.has_member (INCLUDE_OBJECT)
                    ? root_object.get_object_member (INCLUDE_OBJECT)
                    : null;
                results.add_all (deserialize_response (data_object, include_object));
                page++;
            } while (api_response.has_next ());
            return results;
        }

    }

}

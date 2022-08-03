/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

/**
 * The base class for modeling a request to the REST API.
 */
protected abstract class TheGamesDB.AbstractRequest<T> : TheGamesDB.Request<T>, GLib.Object {

    private const string HTTP_GET = "GET";
    private const string HEADER_ACCEPT = "accept";
    private const string CONTENT_TYPE_APPLICATION_JSON = "application/json";
    private const string PARAM_API_KEY = "apikey";

    internal const string DATA_OBJECT = "data";
    internal const string INCLUDE_OBJECT = "include";

    protected T execute (Rest.Proxy proxy, string api_key) throws GLib.Error {
        // Build the request
        var call = create_proxy_call (proxy, api_key);

        // Execute the request
        call.sync ();

        // Parse the response and return the deserialized object
        var json_parser = new Json.Parser ();
        json_parser.load_from_data (call.get_payload ());
        var root_object = json_parser.get_root ().get_object ();
        var data_object = root_object.get_object_member (DATA_OBJECT);
        var include_object = root_object.has_member (INCLUDE_OBJECT)
            ? root_object.get_object_member (INCLUDE_OBJECT)
            : null;
        return deserialize_response (data_object, include_object);
    }

    /**
     * Creates a new {@link Rest.ProxyCall}. This allows the request object to
     * be re-used, while ensuring a new {@link Rest.ProxyCall} is created for
     * each execution.
     * 
     * @param proxy the {@link Rest.Proxy} to use to execute the request
     * @param api_key the API key to provide in the request
     * 
     * @return The {@link Rest.ProxyCall}
     */
    internal Rest.ProxyCall create_proxy_call (Rest.Proxy proxy, string api_key) {
        Rest.ProxyCall call = proxy.new_call ();
        call.set_function (get_function ());
        call.set_method (HTTP_GET); // All endpoints only accept GET requests
        call.add_header (HEADER_ACCEPT, CONTENT_TYPE_APPLICATION_JSON); // All endpoints produce JSON
        call.add_param (PARAM_API_KEY, api_key);
        foreach (var header in get_headers ().entries) {
            call.add_header (header.key, header.value);
        }
        foreach (var param in get_params ().entries) {
            call.add_param (param.key, param.value);
        }
        return call;
    }

    internal virtual Gee.HashMap<string, string> get_headers () {
        return new Gee.HashMap<string, string> ();
    }

    internal virtual Gee.HashMap<string, string> get_params () {
        return new Gee.HashMap<string, string> ();
    }

    internal abstract string get_function ();
    internal abstract T deserialize_response (Json.Object data_object, Json.Object? include_object = null);

}

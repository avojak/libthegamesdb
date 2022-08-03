/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

public interface TheGamesDB.Request<T> : GLib.Object {

    /**
     * Execute the request against the proxy with the given API key.
     * 
     * @param proxy the {@link Rest.Proxy} to use to execute the request
     * @param api_key the API key to provide in the request
     * 
     * @return The deserialized response object
     * 
     * @throws GLib.Error if an error occurs while executing the request
     */
    public abstract T execute (Rest.Proxy proxy, string api_key) throws GLib.Error;

}

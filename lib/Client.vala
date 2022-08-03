/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

/**
 * Client object used to sending requests to the REST API.
 *
 * ''Example''<<BR>>
 * {{{
 * var client = new Client ("MY_API_KEY");
 * var request = new GamesByNameRequest ("Pokemon - FireRed Version") {
 *     fields = GameFieldFlags.RATING,
 *     include = GameIncludeFlags.BOXART
 * };
 * client.request_async.begin<Gee.List<Models.Game> (request, (obj, res) => {
 *     var games = client.request_async.end<Gee.List<Models.Game> (res);
 *     foreach (var game in games) {
 *         print ("%s\n", game.game_title);
 *     }
 * });
 * }}}
 */
public class TheGamesDB.Client : GLib.Object {

    public const string DEFAULT_BASE_URL = "https://api.thegamesdb.net";

    public string base_url { get; construct; }
    public string api_key { get; construct; }

    private Rest.Proxy proxy;

    /**
     * Constructs a new client with the given API key.
     */
    public Client (string api_key) {
        Object (
            api_key: api_key,
            base_url: DEFAULT_BASE_URL
        );
    }

    /**
     * Constructs a new client which will send all requests to the given proxy_url instead
     * of the URL defined by {@link DEFAULT_BASE_URL}.
     */
    public Client.with_proxy (string api_key, string proxy_url) {
        Object (
            api_key: api_key,
            base_url: proxy_url
        );
    }

    construct {
        proxy = new Rest.Proxy (base_url, false);
    }

    /**
     * Sends the given request to the REST API.
     *
     * @param request the {@link TheGamesDB.Request}
     * @return the deserialized response object
     * @throws GLib.Error if an error occurs while executing the request
     */
    public T request<T> (TheGamesDB.Request<T> request) throws GLib.Error {
        return request.execute (proxy, api_key);
    }

    /**
     * Sends the given request asynchronously to the REST API.
     *
     * @param request the {@link TheGamesDB.Request}
     * @return the deserialized response object
     * @throws GLib.Error if an error occurs while executing the request
     */
    public async T request_async<T> (TheGamesDB.Request<T> request) throws GLib.Error {
        GLib.SourceFunc callback = request_async.callback;

        T result = null;
        GLib.Error? error = null;
        new GLib.Thread<void> ("request", () => {
            try {
                result = this.request (request);
            } catch (GLib.Error e) {
                error = e;
            }
            Idle.add ((owned) callback);
        });
        yield;

        if (error != null) {
            throw error;
        }

        return result;
    }

}

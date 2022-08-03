/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

namespace TheGamesDB {

    /**
     * Search for game(s) by name.
     */
    public class GamesByNameRequest : AbstractPagedRequest<Game> {

        private const string ENDPOINT = "/v1.1/Games/ByGameName";

        private const string PARAM_NAME = "name";
        private const string PARAM_PLATFORM_FILTER = "filter[platform]";
        private const string PARAM_FIELDS = "fields";
        private const string PARAM_INCLUDE = "include";

        private const string GAMES_OBJECT = "games";

        //  public uint limit { get; set; default = 20; }
        public string search_term { get; set; }
        public string? platform_id { get; set; default = null; }
        public GameFieldFlags fields { get; set; default = GameFieldFlags.NONE; }
        public GameIncludeFlags include { get; set; default = GameIncludeFlags.NONE; }

        public GamesByNameRequest (string search_term) {
            Object (search_term: search_term);
        }

        internal override string get_function () {
            return ENDPOINT;
        }

        internal override Gee.HashMap<string, string> get_params () {
            var params = new Gee.HashMap<string, string> ();
            params.set (PARAM_NAME, search_term);
            if (platform_id != null) {
                params.set (PARAM_PLATFORM_FILTER, platform_id);
            }
            if (fields != GameFieldFlags.NONE) {
                params.set (PARAM_FIELDS, string.joinv (",", GameFieldFlags.get_masked_parameters (fields)));
            }
            if (include != GameIncludeFlags.NONE) {
                params.set (PARAM_INCLUDE, string.joinv (",", GameIncludeFlags.get_masked_parameters (include)));
            }
            return params;
        }

        internal override Gee.List<Game> deserialize_response (Json.Object data_object,
                Json.Object? include_object = null) {
            var games = new Gee.ArrayList<Game> ();
            foreach (var node in data_object.get_array_member (GAMES_OBJECT).get_elements ()) {
                games.add (new TheGamesDB.Game.from_json (node.get_object ()));
                //  games.add (Json.gobject_deserialize (typeof (Game), node) as Game);
            }
            return games;
        }

    }

}

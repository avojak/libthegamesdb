/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

namespace TheGamesDB {

    public errordomain ProxyError {
        /**
         * Failed to execute the request.
         */
        REQUEST_FAILED;
    }

    public errordomain ParseError {
        /**
         * The response object is not in the expected format.
         */
        INVALID_FORMAT;
    }

    public errordomain RequestError {
        /**
         * Bad request parameter.
         */
        BAD_PARAMETER,
        /**
         * Bad API key, or rate-limit cap has been reached.
         */
        BAD_API_KEY;
    }

}

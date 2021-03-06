var conn;
conn = new ab.Session('ws://localhost:8080',
    function () {
        conn.subscribe('lobby_full', function (topic, data) {
            var current_user_id = document.getElementById('topbar-avatar').getAttribute('steam_id');
            if (current_user_id == data.lobby.owner_id) {
                var message = $("<div class=\"dialog\" title='Your party is complete!'><p>Head into the game to start!</p></div>");
                message.dialog();
                return;
            }
            data.lobby.users.forEach(function (lobby_user) {
                if (lobby_user.steam_id == current_user_id) {
                    if (data.lobby.teamspeak_req) {
                        var ts3link = 'ts3server://' + data.lobby.teamspeak_ip;
                        var message = $("<div class=\"dialog\" title='Your party is complete!'><a class='radius button small' href=" + data.lobby.url + ">Join Lobby</a><a class='radius button small' href=" + ts3link + ">Join Teamspeak</a></div>");
                    } else {
                        var message = $("<div class=\"dialog\" title='Your party is complete!'><a class='radius button small' href=" + data.lobby.url + ">Join Lobby</a></div>");
                    }
                    message.dialog();
                } else {
                    return;
                }
            });
        });
        conn.subscribe('lobby_join', function (topic, data) {
            // auch you lobby updaten
            var current_user_id = document.getElementById('topbar-avatar').getAttribute('steam_id');
            if (current_user_id.length == 0) console.log('Element not found!');
            var your_lobby = false;
            data['lobby'].users.forEach(function (lobby_user) {
                if (lobby_user.steam_id == current_user_id) {
                    your_lobby = true;
                }
            });

            var lobby_user_column = document.createElement("div");
            lobby_user_column.setAttribute("steam_id", data['joined_user'].steam_id);
            lobby_user_column.setAttribute("class", 'lobby-user-column column medium-2');

            var avatar_row = document.createElement("div");
            avatar_row.setAttribute("class", 'row');

            var joined_user_avatar = document.createElement("img");
            joined_user_avatar.setAttribute("alt", "steam avatar");
            joined_user_avatar.setAttribute("src", data['joined_user'].avatar);
            joined_user_avatar.setAttribute("url", data['joined_user'].profileurl);// profileurl

            var flag__row = document.createElement("div");
            flag__row.setAttribute("class", 'row');

            var joined_user_flag = document.createElement("img");
            joined_user_flag.setAttribute("alt", data['joined_user_loccountrycode']);
            joined_user_flag.setAttribute("src", 'webroot/img/flags/' + data['joined_user'].loccountrycode + '.png');

            avatar_row.appendChild(joined_user_avatar);
            lobby_user_column.appendChild(avatar_row);
            flag__row.appendChild(joined_user_flag);
            lobby_user_column.appendChild(flag__row);

            if ($('#lobbies-list #' + data['lobby'].lobby_id + ' .lobby-users-column').length == 0) console.log('Element not found!');
            $('#lobbies-list #' + data['lobby'].lobby_id + ' .lobby-users-column').append(lobby_user_column);

            if (your_lobby) {
                var kick_row = document.createElement("div");
                kick_row.setAttribute("class", "row kick-row");
                var kick_link = document.createElement("a");
                kick_link.setAttribute("href", '/cs-community/lobbies/kick/' + data['joined_user'].steam_id);
                var kick_button = document.createElement("span");
                kick_button.setAttribute("class", 'ui-icon-close ui-icon');
                kick_link.appendChild(kick_button);
                var your_lobby_user_column = lobby_user_column.cloneNode(true);
                kick_row.appendChild(kick_link);
                your_lobby_user_column.appendChild(kick_row);
                $('.your-lobby .row .row .lobby-users-column').append(your_lobby_user_column);
            }
        });
        conn.subscribe('lobby_new', function (topic, data) {
            if ($('#lobbies-list').attr('filter-active') == '' ||
                ($('#lobbies-list').attr('filter-active') == 1
                && data.lobby.rank_from <= $('#filter-user-rank').val()
                && data.lobby.rank_to >= $('#filter-user-rank').val()
                && data.lobby.language == $('#filter-language').val()
                && data.lobby.prime_req == document.getElementById('filter-prime-req').checked
                && data.lobby.teamspeak_req == document.getElementById('filter-teamspeak-req').checked
                && data.lobby.microphone_req == document.getElementById('filter-microphone-req').checked
                && data.lobby.min_age <= $('#filter-min-age').val()
                && data.lobby.min_playtime <= $('#topbar-avatar').attr('playtime')
                && data.lobby.region == $('#topbar-avatar').attr('user_region'))
            ) {
                $('.no-lobbies').remove();

                var lobby_item = document.createElement("div");
                lobby_item.setAttribute("class", "lobby-item row");
                lobby_item.setAttribute("id", data.lobby.lobby_id);

                var firstRow = document.createElement("div");
                firstRow.setAttribute("class", "row");

                var lang_col = document.createElement("div");
                lang_col.setAttribute("class", "column medium-1");
                var lang_img = document.createElement("img");
                lang_img.setAttribute("src", "/cs-community/img/flags/" + data.lobby.language + ".png");
                lang_img.setAttribute("alt", data.lobby.language);
                lang_col.appendChild(lang_img);
                firstRow.appendChild(lang_col);

                var users_col = document.createElement("div");
                users_col.setAttribute("class", "lobby-users-column column medium-3");
                var user_col = document.createElement("div");
                user_col.setAttribute("steam_id", data.lobby.owner.steam_id);
                user_col.setAttribute("class", "lobby-user-column column medium-2");
                var user_avatar_row = document.createElement("div");
                user_avatar_row.setAttribute("class", "row");
                var user_avatar = document.createElement("img");
                user_avatar.setAttribute("src", data.lobby.owner.avatar);
                user_avatar.setAttribute("alt", "steam avatar");
                user_avatar.setAttribute("url", data.lobby.owner.profileurl);
                user_avatar.setAttribute("class", "lobby_owner");
                user_avatar_row.appendChild(user_avatar);
                user_col.appendChild(user_avatar_row);

                var user_flag_row = document.createElement("div");
                user_flag_row.setAttribute("class", "row");
                var user_flag = document.createElement("img");
                user_flag.setAttribute("src", "/cs-community/webroot/img/flags/" + data.lobby.owner.loccountrycode + ".png");
                user_flag.setAttribute("alt", data.lobby.owner.loccountrycode);
                user_flag.setAttribute("class", "flag");
                user_flag_row.appendChild(user_flag);
                user_col.appendChild(user_flag_row);
                users_col.appendChild(user_col);
                firstRow.appendChild(users_col);

                var rank_col = document.createElement("div");
                rank_col.setAttribute("class", "column medium-4");
                var rank_row = document.createElement("div");
                rank_row.setAttribute("class", "row");

                var rank_from_col = document.createElement("div");
                rank_from_col.setAttribute("class", "column medium-5");
                var rank_from = document.createElement("img");
                rank_from.setAttribute("src", "/cs-community/img/ranks/" + data.lobby.RankFrom.name + ".png");
                rank_from.setAttribute("alt", data.lobby.rank_from);
                rank_from.setAttribute("class", "rank-icon");
                var rank_conn_container = document.createElement("div");
                rank_conn_container.setAttribute("class", "medium-2 columns");
                var rank_connector = document.createElement("span");
                rank_connector.setAttribute("class", "stretch");
                rank_conn_container.appendChild(rank_connector);
                rank_connector.innerHTML = "-";
                var rank_to_col = document.createElement("div");
                rank_to_col.setAttribute("class", "column medium-5");
                var rank_to = document.createElement("img");
                rank_to.setAttribute("src", "/cs-community/img/ranks/" + data.lobby.RankTo.name + ".png");
                rank_to.setAttribute("alt", data.lobby.rank_to);
                rank_to.setAttribute("class", "rank-icon");

                rank_from_col.appendChild(rank_from);
                rank_to_col.appendChild(rank_to);
                rank_row.appendChild(rank_from_col);
                rank_row.appendChild(rank_conn_container);
                rank_row.appendChild(rank_to_col);
                rank_col.appendChild(rank_row);
                firstRow.appendChild(rank_col);

                var action_col = document.createElement("div");
                action_col.setAttribute("class", "column medium-2");
                var join_button = document.createElement("a");
                join_button.setAttribute("href", "/cs-community/lobbies/join/" + data.lobby.lobby_id);
                join_button.setAttribute("class", "button small radius");
                join_button.setAttribute("lobby-url", data.lobby.url);
                join_button.textContent = "Join";
                action_col.appendChild(join_button);
                firstRow.appendChild(action_col);

                var created_col = document.createElement("div");
                created_col.setAttribute("class", "column medium-2");
                created_col.innerHTML = "Just now";
                firstRow.appendChild(created_col);

                lobby_item.appendChild(firstRow);

                var bottom_row = document.createElement("div");
                bottom_row.setAttribute("class", "row");

                var prime_col = document.createElement("div");
                prime_col.setAttribute("class", "column medium-1");
                var prime_icon = document.createElement("img");
                prime_icon.setAttribute("src", "/cs-community/img/prime.png");
                prime_icon.setAttribute("alt", "prime");
                prime_icon.setAttribute("heigth", "20");
                prime_icon.setAttribute("width", "20");
                prime_col.appendChild(prime_icon);
                bottom_row.appendChild(prime_col);
                if (data.lobby.prime_req == 1) {
                    prime_icon.parentNode.insertBefore(document.createTextNode(" Yes"), prime_icon.nextSibling);
                } else {
                    prime_icon.parentNode.insertBefore(document.createTextNode(" No"), prime_icon.nextSibling);
                }


                var mic_col = document.createElement("div");
                mic_col.setAttribute("class", "column medium-1");
                var mic_icon = document.createElement("img");
                mic_icon.setAttribute("src", "/cs-community/img/microphone.png");
                mic_icon.setAttribute("alt", "microphone");
                mic_icon.setAttribute("heigth", "20");
                mic_icon.setAttribute("width", "20");
                mic_col.appendChild(mic_icon);
                bottom_row.appendChild(mic_col);
                if (data.lobby.microphone_req == 1) {
                    mic_icon.parentNode.insertBefore(document.createTextNode(" Yes"), mic_icon.nextSibling);
                } else {
                    mic_icon.parentNode.insertBefore(document.createTextNode(" No"), mic_icon.nextSibling);
                }

                var ts_col = document.createElement("div");
                ts_col.setAttribute("class", "column medium-1");
                var ts_icon = document.createElement("img");
                ts_icon.setAttribute("src", "/cs-community/img/teamspeak.png");
                ts_icon.setAttribute("alt", "Teamspeak");
                ts_icon.setAttribute("heigth", "20");
                ts_icon.setAttribute("width", "20");
                ts_col.appendChild(ts_icon);
                bottom_row.appendChild(ts_col);
                if (data.lobby.teamspeak_req == 1) {
                    ts_icon.parentNode.insertBefore(document.createTextNode(" Yes"), ts_icon.nextSibling);
                } else {
                    ts_icon.parentNode.insertBefore(document.createTextNode(" No"), ts_icon.nextSibling);
                }

                var playtime_col = document.createElement("div");
                playtime_col.setAttribute("class", "column medium-2");
                playtime_col.textContent = 'Min. Playtime: ' + data.lobby.min_playtime;
                var min_age_col = document.createElement("div");
                min_age_col.setAttribute("class", "column medium-2 left");
                min_age_col.textContent = 'Min. Age: ' + data.lobby.min_age;

                bottom_row.appendChild(playtime_col);
                bottom_row.appendChild(min_age_col);
                lobby_item.appendChild(bottom_row);

                document.getElementById('lobbies-list').prepend(lobby_item);
            }
        });
        conn.subscribe('lobby_leave', function (topic, data) {
                var user_div = $("div[steam_id='" + data['user_left'].steam_id + "']");
                var current_user_id = document.getElementById('topbar-avatar').getAttribute('steam_id');
                if (data['user_left'].steam_id == current_user_id && data['kicked']) {
                    location.reload();
                    var message = $("<div class=\"dialog\" title='Hint'><p>You got kicked!</p></div>");
                    message.dialog();
                }
                    if (user_div.length !== 0) {
                        $("div[steam_id='" + data['user_left'].steam_id + "']").remove();
                    } else {
                        console.log('Element not found!');
                    }
            }
        );
        conn.subscribe('lobby_delete', function (topic, data) {
            var current_user_id = document.getElementById('topbar-avatar').getAttribute('steam_id');
            if (data.lobby.owner_id == current_user_id) {
                return;
            }
            data['lobby'].users.forEach(function (lobby_user) {
                if (lobby_user.steam_id == current_user_id) {
                    location.reload();
                    var message = $("<div class=\"dialog\" title='Hint'><p>Your Lobby has been deleted!</p></div>");
                    message.dialog();
                    return;
                } else {
                    $("div[class='lobby-item row'][id='" + data['lobby'].lobby_id + "']").remove();
                }
            });
        });
        conn.subscribe('new_chat_message', function (topic, data) {
            var colors = ["#234567", "#CF142B", "#C5AC6A", "#5E9FB8", "#4CAF50", "#234567", "#CF142B", "#C5AC6A", "#5E9FB8", "#4CAF50"];
            var chat_message_row = document.createElement("div");
            chat_message_row.setAttribute("class", "row");
            var chat_message = document.createElement("div");
            chat_message.setAttribute('style', 'color:' + colors[Math.floor((Math.random() * 10) + 1)]);
            chat_message.setAttribute("class", "columns medium-12");
            chat_message.textContent = data['personaname'] + ': ' + data['message'];
            chat_message_row.appendChild(chat_message);
            document.getElementById("chat-message-container").append(chat_message_row);
            $('#chat-message-container').stop().animate({
                scrollTop: $('#chat-message-container')[0].scrollHeight
            }, 800);
        });
    },
    function () {
        console.warn('WebSocket connection closed');
    }
    ,
    {
        'skipSubprotocolCheck': true
    }
)
;
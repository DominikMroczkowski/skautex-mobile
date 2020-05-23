import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'dart:async';

import 'repository.dart';
import '../helpers/credentials.dart';

import '../models/jwt.dart';
import '../models/player.dart';
import '../models/user.dart';
import '../models/permissions.dart';

final _root = 'skautex.azurewebsites.net';
const _API_KEY = 'wLGT1Js1.z17BjKPWsTlTB8Mqxdu5E82xYXLtyG5a';

class SkautexApiProvider implements Source {
	Client client = Client();

	Future<JWT> fetchJWT(Credentials creds) async {
		final response = await client.post(
			Uri.https(_root,  'api/v1/jwt/'),
			body: json.encode(<String, String> {
				"username" : creds.user,
				"password" : creds.password
			}),
			headers: {
				"api-key" : _API_KEY,
				"accept" : "application/json",
				"content-type" : "application/json"
			},
		);

		if (json.decode(response.body).toString().contains('detail')) {
			return Future<JWT>.error('Logowanie nie powiodło się');
		}

		final parsedJson = json.decode(response.body);
		return JWT.fromJson(parsedJson);
	}

	Future<JWT> fetchJWT2(Future<JWT> jwt, String code) async {
		JWT jwtC = await jwt;
		String access = jwtC.access;

		final response = await client.post(
			Uri.https(_root, '/api/v1/otp/verify/$code/'),
			body: json.encode(<String, String> {
			}),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		if (json.decode(response.body).toString().contains('detail')) {
			return Future<JWT>.error('Logowanie nie powiodło się');
		}

		final parsedJson = json.decode(response.body);
		return JWT.fromJson(parsedJson);
	}

	Future<JWT> refetchJWT2(Future<JWT> jwt) async {
		JWT jwtC = await jwt;
		String access = jwtC.access;


		final response = await client.post(
			Uri.https(_root, '/api/v1/jwt/refresh/'),
			body: json.encode(<String, String> {
				"refresh": "${jwtC.refresh}"
			}),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		print(response.body);

		if (json.decode(response.body).toString().contains('detail')) {
			return Future<JWT>.error('Odświeżenie nie powiodło się');
		}

		final parsedJson = json.decode(response.body);
		var newJwt = JWT.fromJson(parsedJson);
		newJwt.refresh = jwtC.refresh;
		return newJwt;
	}


	Future<List<String>> fetchTopPlayersUris(Future<JWT> jwt) async {
		String access = (await jwt).access;
		final response = await client.get(
			Uri.https(_root, '/api/v1/players/'),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		print(response.body);
		if (json.decode(response.body).toString().contains('detail')) {
			return Future<List<String>>.error('Pobranie identyfikatorów zawodników nie powiodło się');
		}

		final parsedJson = json.decode(response.body);

		// Quick fix becouse api isn't in any means stable
		List<String> uris = List<String>();

		parsedJson['results'].forEach(
			(playersJson) {
				return uris.add(Player.fromJson(playersJson).uri);
			}
		);

		return uris;
	}

	Future<Player> fetchPlayer(Future<JWT> jwt, String uri) async {
		String access = (await jwt).access;
		var response = await client.get(
			uri,
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json; charset=utf-8',
				"authorization" : 'Bearer $access',
			},
		);

		if (json.decode(response.body).toString().contains('detail')) {
			return Future<Player>.error('Pobranie danych zawodnika nie powiodło się');
		}

		final parsedJson = json.decode(Utf8Decoder().convert(response.bodyBytes));

		final team = parsedJson['team'];
		parsedJson['team'] = await fetchName(access, team);

		final league = parsedJson['league'];
		parsedJson['league'] = await fetchName(access, league);

		return Player.fromJson(parsedJson);
	}

	Future<String> fetchName(String access, String uri) async {
		if (uri == null) {
			return "Brak";
		}
		final response = await client.get(
			uri,
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		if (json.decode(response.body).toString().contains('detail')) {
			return Future<String>.value('$uri');
		}

		final parsedJson = json.decode(response.body);
		return parsedJson['name'];
	}

	void sendCodeOnEmail(Future<JWT> jwt) async {
		var j = await jwt;
		await client.get(
			Uri.https(_root,  '/api/v1/otp/email/send/'),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer ${j.access}'
			},
		);
	}

	Future<User> fetchUser(Future<JWT> jwt, String uri) async {
		String access = (await jwt).access;
		final response = await client.get(
			Uri.https(_root,  '/api/v1/users/me/'),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		final parsedJson = json.decode(response.body);
		return User.fromJson(parsedJson);
	}

	Future<Permissions> fetchPermissions(Future<JWT> jwt, String uri) async {
		String access = (await jwt).access;
		final response = await client.get(
			Uri.https(_root,  '/api/v1/users/me/all_permissions/', {"limit" : "none"}),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		final parsedJson = json.decode(response.body);
		return Permissions.fromJson(parsedJson);
	}

	Future<List<String>> fetchGroups(Future<JWT> jwt, String uri) async {
		String access = (await jwt).access;
		final response = await client.get(
			Uri.https(_root,  '/api/v1/users/me/groups/'),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		final Map<String, dynamic> parsedJson = json.decode(response.body);
		List<String> toRet = [];
		parsedJson['results'].forEach((i) { toRet.add(i['name']); });
		return toRet;
	}

}

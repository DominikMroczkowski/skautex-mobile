import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/jwt.dart';
import 'dart:async';
import 'repository.dart';
import '../helpers/credentials.dart';
import '../models/player.dart';

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
			Uri.https(_root, '/jwt/refresh/'),
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
			return Future<JWT>.error('Odświeżenie nie powiodło się');
		}

		final parsedJson = json.decode(response.body);
		return JWT.fromJson(parsedJson);
	}


	Future<List<String>> fetchTopPlayersUris(String access) async {
		final response = await client.get(
			Uri.https(_root, '/api/v1/players/'),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

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

		print('uris');
		return uris;
	}

	Future<Player> fetchPlayer(String access, String uri) async {
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
			Uri.https(_root,  'otp/email/send/'),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer ${j.access}'
			},
		);
	}
}

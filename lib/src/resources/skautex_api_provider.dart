import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/jwt.dart';
import 'dart:async';
import 'repository.dart';
import '../helpers/credentials.dart';

final _root = 'skautex.azurewebsites.net';
final _api_key = 'iyJey6vU.wJcLiDkHrHDRhNQ24KIlaY3mCFR1IucG';

class SkautexApiProvider implements Source {
	Client client = Client();

	Future<JWT> fetchJWT(Credentials creds) async {
		final response = await client.post(
			Uri.https(_root, 'jwt/'),
			body: json.encode(<String, String> {
				"username" : creds.user,
				"password" : creds.password
			}),
			headers: {
				"api-key" : _api_key,
				"accept" : "application/json",
				"content-type" : "application/json"
			},
		);

		print('${response.body}');

		final parsedJson = json.decode(response.body);
		return JWT.fromJson(parsedJson);
	}
}

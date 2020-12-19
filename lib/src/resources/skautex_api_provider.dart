import 'dart:convert';
import 'dart:async';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client, ByteStream;
import 'package:skautex_mobile/src/models/booking_blacklist.dart';
import 'package:skautex_mobile/src/models/code_on_mail.dart';
import 'package:skautex_mobile/src/models/player_report.dart';
import 'package:skautex_mobile/src/models/response_list.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

import 'repository.dart';
import '../helpers/credentials.dart';

import '../models/jwt.dart';
import '../models/player.dart';
import '../models/user.dart';
import '../models/report.dart';
import '../models/permissions.dart';
import '../models/cost.dart';
import '../models/booking.dart';
import '../models/booking_type.dart';
import '../models/booking_reservation.dart';
import '../models/event.dart';
import '../models/event_type.dart';
import '../models/file.dart';

final _root = 'skautex-development.azurewebsites.net';
const _API_KEY = 'XaQI1rON.0lMFeVgWRc7Ocb61urTzsaPWCl5bEAx1';

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


		if (json.decode(response.body).toString().contains('detail')) {
			return Future<JWT>.error('Odświeżenie nie powiodło się');
		}

		final parsedJson = json.decode(response.body);
		print(parsedJson['access']);
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

		if (json.decode(response.body).toString().contains('detail')) {
			return Future<List<String>>.error('Pobranie identyfikatorów zawodników nie powiodło się');
		}

		final parsedJson = json.decode(response.body);

		// Quick fix becouse api isn't in any means stable
		List<String> uris = List<String>();

		parsedJson['results'].forEach(
			(playersJson) {
				return uris.add(playersJson['url']);
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

		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<Player>.error('Pobranie danych zawodnika nie powiodło się');
		}

		String stringJson = Utf8Decoder().convert(response.bodyBytes);
		final parsedJson = json.decode(stringJson);
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

	Future<Object> sendCodeOnEmail(Future<JWT> jwt) async {
		String access = (await jwt).access;

		final response = await client.post(
			Uri.https(_root,  '/api/v1/otp/email/send/'),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<Object>.error('Wysłanie kodu na email nie powiodło się');
		}

		return Future<Object>.value(Object());
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
		print(response.body.toString());

		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<Permissions>.error("Couldn't fetch Permissions");
		}


		final parsedJson = json.decode(response.body);
		return Permissions.fromJson(parsedJson);
	}

	Future<List<String>> fetchGroups(Future<JWT> jwt, String uri) async {
		String access = (await jwt).access;
		final response = await client.get(
			Uri.https(_root, '/api/v1/users/me/groups/'),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<List<String>>.value(['']);
		}


		final Map<String, dynamic> parsedJson = json.decode(response.body);
		List<String> toRet = [];
		parsedJson['results'].forEach((i) { toRet.add(i['name']); });
		return toRet;
	}

	Future<Player> addPlayer(Future<JWT> jwt, Player player) async {

		String access = (await jwt).access;

		final response = await client.post(
			Uri.https(_root,  '/api/v1/players/'),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
			body: json.encode(player.toJson())
		);
		print(response.body);

		if (response.statusCode < 200 || response.statusCode > 299)
			return Future<Player>.error('Niepowodzenie');

		return Player.fromJson(json.decode(response.body));
	}

	Future<List<List<String>>> fetchTeams(Future<JWT> jwt) async {
		String access = (await jwt).access;

		final response = await client.get(
			Uri.https(_root,  '/api/v1/teams/', {"limit" : "none"}),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			}
		);

		final parsedJson = json.decode(response.body);
		List<List<String>> names = List<List<String>>();

		parsedJson['results'].forEach(
			(playersJson) {
				return names.add([playersJson['name'], playersJson['url']]);
			}
		);
		return names;

	}

	Future<List<List<String>>> fetchLeagues(Future<JWT> jwt) async {
		String access = (await jwt).access;

		final response = await client.get(
			Uri.https(_root,  '/api/v1/leagues/', {"limit" : "none"}),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			}
		);

		final parsedJson = json.decode(response.body);

		List<List<String>> names = List<List<String>>();

		parsedJson['results'].forEach(
			(playersJson) {
				return names.add([playersJson['name'], playersJson['url']]);
			}
		);
		return names;
	}


	Future<Player> updatePlayer(Future<JWT> jwt, Player player) async {
		String access = (await jwt).access;

		final response = await client.put(
			player.uri,
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
			body: json.encode(
				player.toJson()
			)
		);

		final parsedJson = json.decode(response.body);

		return Player.fromJson(parsedJson);
	}

	String _getSubURL<T>() {
		final _uris = <Type, String>{
			User: '/api/v1/users/',
			Report: '/api/v1/reports/',
			Player: '/api/v1/players/',
			Cost: '/api/v1/users/me/cost_recording/',
			Booking: '/api/v1/booking/objects/',
			BookingType: '/api/v1/booking/objects_types/',
			BookingReservation: '/api/v1/booking/reservations/',
			BookingBlacklist: '/api/v1/booking/blacklist/',
			Event: '/api/v1/calendars/events/',
			EventType: '/api/v1/calendars/events_types/',
			CodeOnMail: '/api/v1/otp/email/send'

		};

	  return _uris[T];
	}

	Future<List<String>> fetchUris<T>(Future<JWT> jwt, {Map<String, String> where}) async {
		String access = (await jwt).access;

		where ??= {};
		where["limit"] = "none";
		print(where.toString());

		String uri = _getSubURL<T>();

		final response = await client.get(
			Uri.https(_root, uri,  where),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<List<String>>.error('Pobranie adressów url dla uri: $uri nie powiodło się');
		}

		final parsedJson = json.decode(response.body);

		// Quick fix becouse api isn't in any means stable
		List<String> uris = List<String>();

		parsedJson['results'].forEach(
			(i) {
				return uris.add(i['url']);
			}
		);

		return uris;
	}

	T _fromJson<T>(Map<String, dynamic> parsedJson) {
		final _objects = <Type, Function>{
			User         : (Map<String, dynamic> parsedJson) => User.fromJson(parsedJson),
			Report       : (Map<String, dynamic> parsedJson) => Report.fromJson(parsedJson),
			Player       : (Map<String, dynamic> parsedJson) => Player.fromJson(parsedJson),
			PlayerReport : (Map<String, dynamic> parsedJson) => PlayerReport.fromJson(parsedJson),
			Cost         : (Map<String, dynamic> parsedJson) => Cost.fromJson(parsedJson),
			Booking      : (Map<String, dynamic> parsedJson) => Booking.fromJson(parsedJson),
			BookingType  : (Map<String, dynamic> parsedJson) => BookingType.fromJson(parsedJson),
			BookingBlacklist : (Map<String, dynamic> parsedJson) => BookingBlacklist.fromJson(parsedJson),
			BookingReservation : (Map<String, dynamic> parsedJson) => BookingReservation.fromJson(parsedJson),
			Event: (Map<String, dynamic> parsedJson) => Event.fromJson(parsedJson),
			EventType: (Map<String, dynamic> parsedJson) => EventType.fromJson(parsedJson),
			File: (Map<String, dynamic> parsedJson) => File.fromJson(parsedJson),
			CodeOnMail: (_) => CodeOnMail()
		};

	  return _objects[T](parsedJson);
	}

	Future<T> fetchItem<T>(Future<JWT> jwt, String uri) async {
		String access = (await jwt).access;

		final response = await client.get(
			uri,
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access',
			}
		);

		print(response.body);
		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<T>.error('Zapytanie GET dla URL: $uri nie powiodło się');
		}
		String stringJson = Utf8Decoder().convert(response.bodyBytes);
		final parsedJson = json.decode(stringJson);

		return _fromJson<T>(parsedJson);
	}


	_toJson<T>(T item) {
		final _objects = <Type, Function>{
			User : (User user) => user.toJson(),
			PlayerReport : (PlayerReport report) => report.toJson(),
			Cost : (Cost cost) => cost.toJson(),
			Event : (Event event) => event.toJson(),
		};

	  return _objects[T](item);
	}

	Future<T> updateItem<T>(Future<JWT> jwt, T item) async {
		String access = (await jwt).access;

		var jsonToEncode = _toJson(item);
		print(jsonToEncode['url']);
		final response = await client.put(
			jsonToEncode['url'],
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
			body: json.encode(
				jsonToEncode
			)
		);

		print('Update response ' + response.body.toString());

		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<T>.error('Zapytanie PUT dla URL: ${jsonToEncode['uri']} nie powiodło się');
		}

		String stringJson = Utf8Decoder().convert(response.bodyBytes);
		final parsedJson = json.decode(stringJson);
		return _fromJson<T>(parsedJson);
	}

	_toPost<T>(T item) {
		final _objects = <Type, Function>{
			User : (User user) => user.toPost(),
			Report: (Report report) => report.toPost(),
			Cost: (Cost cost) => cost.toPost(),
			Booking: (Booking booking) => booking.toPost(),
			BookingBlacklist: (BookingBlacklist blacklist) => blacklist.toPost(),
			BookingReservation: (BookingReservation reservation) => reservation.toPost(),
			Event: (Event event) => event.toPost(),
			CodeOnMail: (_) => null
		};

	  return _objects[T](item);
	}

	Future<T> addItem<T>(Future<JWT> jwt, T item) async {
		String access = (await jwt).access;

		print(
			Uri.https(_root, _getSubURL<T>(), {}),
		);
		final response = await client.post(
			Uri.https(_root, _getSubURL<T>(), null),
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
			body: _toPost(item) != null ? json.encode(_toPost(item)) : null
		);

		print(response.body);

		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<T>.error('Zapytanie POST dla URL: ${_getSubURL<T>()} nie powiodło się');
		}

		String stringJson = Utf8Decoder().convert(response.bodyBytes);
		final parsedJson = json.decode(stringJson);
		return _fromJson<T>(parsedJson);
	}

	Future<Object> deleteItem(Future<JWT> jwt, String url) async {
		String access = (await jwt).access;

		if (url == null) {
			return Future<Object>.error('Zapytanie DELETE nie powiodło się: url == null');
		}

		final response = await client.delete(
			url,
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			}
		);

		print(response.body);

		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<Object>.error('Zapytanie DELETE dla URL: $url nie powiodło się');
		}

		return Future<Object>.value(Object());
	}

	Future<ResponseList<T>> fetchItems<T>(Future<JWT> jwt, {String uriOpt, Map<String, String> where}) async {
		String access = (await jwt).access;

		if (uriOpt == null || uriOpt == '')
			uriOpt = Uri.https(_root, _getSubURL<T>(), where).toString();

		final response = await client.get(
			uriOpt,
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		debugPrint(response.body);

		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<ResponseList<T>>
				.error('Pobranie adressów url dla uri: ${Uri.https(_root, _getSubURL<T>(), where)} nie powiodło się');
		}

		String stringJson = Utf8Decoder().convert(response.bodyBytes);
		final parsedJson = json.decode(stringJson);

		var list = ResponseList<T>.fromJson(parsedJson);

		parsedJson['results'].forEach(
			(i) {
				list.results.add(_fromJson<T>(i));
			}
		);

		return list;
	}


	Future<String> downloadItem(Future<JWT> jwt, String uri) async {
		String access = (await jwt).access;
		WidgetsFlutterBinding.ensureInitialized();
		await FlutterDownloader.initialize(
  		debug: true
		);
		final directory = await getExternalStorageDirectory();

    bool hasExisted = await directory.exists();
    if (!hasExisted) {
      directory.create();
    }

		print(directory.toString());
		FlutterDownloader.enqueue(
 		 	url: uri,
  		savedDir: directory.path,
  		showNotification: true,
  		openFileFromNotification: true,
			headers: {
				"api-key" : _API_KEY,
				"accept" : 'application/json',
				"content-type" : 'application/json',
				"authorization" : 'Bearer $access'
			},
		);

		return Future.value('Dodano plik do kolejki pobierań');
	}

	Future<String> uploadItem(Future<JWT> jwt, String uri, File file) async {
		String access = (await jwt).access;

		print(file.file);
		io.File f = io.File(file.file);
		var stream = ByteStream(DelegatingStream(f.openRead()));
    var length = await f.length();

		Map<String, String> headers = {
			"api-key" : _API_KEY,
			"accept" : 'application/json',
			"content-type" : 'multipart/form-data',
			"authorization" : 'Bearer $access'
		};

    var u = Uri.parse(uri);
    var request = new http.MultipartRequest("POST", u);
    var sing = http.MultipartFile('file', stream, length,
        filename: basename(f.path));

    request.files.add(sing);
    request.headers.addAll(headers);

    var response = await request.send();

		// Debug
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

		if (response.statusCode < 200 || response.statusCode > 299) {
			return Future<String>
				.error('Dodawanie pliku $file.file nie powiodło się');
		}

		return Future.value('Plik $file.file został wysłany');
	}

}

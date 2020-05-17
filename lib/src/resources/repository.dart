import 'dart:async';
import 'skautex_api_provider.dart';
import '../models/jwt.dart';
import '../models/player.dart';
import '../helpers/credentials.dart';

class Repository {
	List<Source> sources = <Source>[
		SkautexApiProvider()
	];

	List<Cache> caches = <Cache>[
	];

	Future<JWT> fetchJWT(Credentials creds) {
		return sources[0].fetchJWT(creds);
	}

	Future<JWT> fetchJWT2(Future<JWT> j, String code) {
		return sources[0].fetchJWT2(j, code);
	}

	Future<List<String>> fetchTopPlayersUris(String access) {
		return sources[0].fetchTopPlayersUris(access);
	}

	Future<Player> fetchPlayer(String access, String uri) {
		return sources[0].fetchPlayer(access, uri);
	}

	void sendCodeOnEmail(Future<JWT> jwt) {
		return sources[0].sendCodeOnEmail(jwt);
	}

	Future<JWT> refetchJWT2(Future<JWT> jwt) {
		return sources[0].refetchJWT2(jwt);
	}

	clearCache() async {
		for (var cache in caches) {
			await cache.clear();
		}
	}
}

abstract class Source {
	Future<JWT> fetchJWT(Credentials creds);
	Future<JWT> fetchJWT2(Future<JWT> jwt, String code);
	Future<JWT> refetchJWT2(Future<JWT> jwt);
	Future<Player> fetchPlayer(String access, String uri);
	Future<List<String>> fetchTopPlayersUris(String access);
	void sendCodeOnEmail(Future<JWT> jwt);
}

abstract class Cache {
	Future<int> addJWT(JWT j);
	Future<int> clear();
}

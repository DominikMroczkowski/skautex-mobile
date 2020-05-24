import 'dart:async';
import 'package:skautex_mobile/src/models/permissions.dart';

import 'skautex_api_provider.dart';
import 'skautex_db_provider.dart';

import '../models/jwt.dart';
import '../models/player.dart';
import '../models/user.dart';
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

	Future<JWT> fetchJWT2(Future<JWT> jwt, String code) async {
		Future<JWT> jwt2 = sources[0].fetchJWT2(jwt, code);
		skautexDbProvider.setRefresh(jwt2);
		return jwt2;
	}

	Future<JWT> refetchJWT2(Future<JWT> jwt) async {
		// Async magic - leave as it is
		await jwt;
		String refresh = await skautexDbProvider.getRefresh();
		JWT readyJwt =  JWT(refresh, "noNeed");

		return sources[0].refetchJWT2(Future.value(readyJwt));
	}

	void sendCodeOnEmail(Future<JWT> jwt) {
		return sources[0].sendCodeOnEmail(jwt);
	}




	Future<List<String>> fetchTopPlayersUris(Future<JWT> access) {
		return sources[0].fetchTopPlayersUris(access);
	}

	Future<Player> fetchPlayer(Future<JWT> access, String uri) {
		return sources[0].fetchPlayer(access, uri);
	}



	Future<User> fetchUser(Future<JWT> access, String uri) {
		return sources[0].fetchUser(access, uri);
	}

	Future<Permissions> fetchPermissions(Future<JWT> access, String uri) {
		return sources[0].fetchPermissions(access, uri);
	}

	Future<List<String>> fetchGroups(Future<JWT> access, String uri) {
		return sources[0].fetchGroups(access, uri);
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
	void sendCodeOnEmail(Future<JWT> jwt);

	Future<Player> fetchPlayer(Future<JWT> access, String uri);
	Future<List<String>> fetchTopPlayersUris(Future<JWT> access);

	Future<User> fetchUser(Future<JWT> access, String uri);
	Future<Permissions> fetchPermissions(Future<JWT> access, String uri);
	Future<List<String>> fetchGroups(Future<JWT> access, String uri);
}

abstract class Cache {
	String getRefresh();
	setRefresh(Future jwt);
	Future<int> clear();
}

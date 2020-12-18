import 'dart:async';
import 'package:skautex_mobile/src/models/file.dart';
import 'package:skautex_mobile/src/models/permissions.dart';
import 'package:skautex_mobile/src/models/response_list.dart';

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
		await jwt;
		String refresh = await skautexDbProvider.getRefresh();
		JWT readyJwt =  JWT(refresh, "noNeed");

		return sources[0].refetchJWT2(Future.value(readyJwt));
	}

	Future<int> clear() async {
		return skautexDbProvider.clear();
	}

	Future<Object> sendCodeOnEmail(Future<JWT> jwt) {
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

	Future<Player> addPlayer(Future<JWT> access, Player player) {
		return sources[0].addPlayer(access, player);
	}



	Future<List<List<String>>> fetchTeams(Future<JWT> jwt) {
		return sources[0].fetchTeams(jwt);
	}

	Future<List<List<String>>> fetchLeagues(Future<JWT> jwt) {
		return sources[0].fetchLeagues(jwt);
	}



	Future<Player> updatePlayer(Future<JWT> jwt, Player player) {
		return sources[0].updatePlayer(jwt, player);
	}


	Future<List<String>> fetchUris<T>(Future<JWT> jwt, {Map<String, String> where}) {
		return sources[0].fetchUris<T>(jwt, where: where);
	}

	Future<T> fetchItem<T>(Future<JWT> jwt, String uri) {
		return sources[0].fetchItem<T>(jwt, uri);
	}

	Future<T> updateItem<T>(Future<JWT> jwt, T item) {
		return sources[0].updateItem<T>(jwt, item);
	}

	Future<T> addItem<T>(Future<JWT> jwt, T item) {
		return sources[0].addItem<T>(jwt, item);
	}

	Future<Object> deleteItem(Future<JWT> jwt, String url) {
		return sources[0].deleteItem(jwt, url);
	}

	Future<String> downloadItem(Future<JWT> jwt, String url) {
		return sources[0].downloadItem(jwt, url);
	}

	Future<String> uploadItem(Future<JWT> jwt, String url, File file) {
		return sources[0].uploadItem(jwt, url, file);
	}

	Future<ResponseList<T>> fetchItems<T>(Future<JWT> jwt, {String uri, Map<String, String> where}) {
		return sources[0].fetchItems<T>(jwt, where: where, uriOpt: uri);
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
	Future<Object> sendCodeOnEmail(Future<JWT> jwt);

	Future<Player> fetchPlayer(Future<JWT> access, String uri);
	Future<List<String>> fetchTopPlayersUris(Future<JWT> access);

	Future<User> fetchUser(Future<JWT> access, String uri);
	Future<Permissions> fetchPermissions(Future<JWT> access, String uri);
	Future<List<String>> fetchGroups(Future<JWT> access, String uri);

	Future<Player> addPlayer(Future<JWT> access, Player player);

	Future<List<List<String>>> fetchTeams(Future<JWT> jwt);
	Future<List<List<String>>> fetchLeagues(Future<JWT> jwt);

	Future<List<String>> fetchUris<T>(Future<JWT> jwt, {Map<String, String> where});
	Future<T> fetchItem<T>(Future<JWT> jwt, String uri);
	Future<T> updateItem<T>(Future<JWT> jwt, T item);
	Future<T> addItem<T>(Future<JWT> jwt, T item);
	Future<Object> deleteItem(Future<JWT> jwt, String url);
	Future<String> downloadItem(Future<JWT> jwt, String url);
	Future<String> uploadItem(Future<JWT> jwt, String url, File file);

	Future<ResponseList<T>> fetchItems<T>(Future<JWT> jwt, {Map<String, String> where, String uriOpt});
	Future<Player> updatePlayer(Future<JWT> jwt, Player player);
}

abstract class Cache {
	String getRefresh();
	setRefresh(Future jwt);
	Future<int> clear();
}

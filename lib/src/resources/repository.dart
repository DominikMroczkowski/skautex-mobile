import 'dart:async';
import 'skautex_api_provider.dart';
import '../models/jwt.dart';
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

	clearCache() async {
		for (var cache in caches) {
			await cache.clear();
		}
	}
}

abstract class Source {
	Future<JWT> fetchJWT(Credentials creds);
}

abstract class Cache {
	Future<int> addJWT(JWT j);
	Future<int> clear();
}

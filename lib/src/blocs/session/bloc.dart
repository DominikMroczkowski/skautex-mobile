import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'provider.dart';
import '../../helpers/credentials.dart';
export 'provider.dart';

import '../../resources/repository.dart';
import '../../models/jwt.dart';

class Bloc {
	final _repository = Repository();
	final _JWTOutup   = BehaviorSubject<Future<JWT>>();
	final _JWTFetcher = BehaviorSubject<Credentials>();

	Stream<Future<JWT>> get jwt => _JWTOutup.stream;

	Function(Credentials) get fetchJWT => _JWTFetcher.sink.add;

	Bloc() {
		_JWTFetcher.stream.transform(_JWTTransformer()).pipe(_JWTOutup);
	}


	_JWTTransformer() {
		return StreamTransformer<Credentials, Future<JWT>>.fromHandlers(
			handleData: (creds, sink) {
				sink.add(_repository.fetchJWT(creds));
			}
		);
	}

	dispose() {
		_JWTOutup.close();
		_JWTFetcher.close();
	}
}

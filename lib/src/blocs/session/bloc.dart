import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'provider.dart';
export 'provider.dart';

class Bloc {
	final api_key_prefix = 'PRJhfzgk';
	final api_key = 'pbkdf2_sha256\$180000\$qACDXzjGAqdZ\$6hwRYlx9H0StI1tttwVF8JwwLTAJQhEFdNzw/z0udow=';
	final _token = BehaviorSubject<String>();

	Function(String) get changeToken => _token.sink.add;

	dispose() {
		_token.close();
	}
}

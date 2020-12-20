import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final _player = BehaviorSubject<Player>();

	get player => _player.stream;

	Bloc({Player player}) {
		_player.sink.add(player);
	}

	dispose() {
		_player.close();
	}
}

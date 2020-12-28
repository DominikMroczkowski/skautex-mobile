import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc {
	final Function reloadUpperPage;

	final _player = BehaviorSubject<Player>();
	final _tab = BehaviorSubject<int>();
	get tab => _tab.stream;
	get changeTab => _tab.sink.add;

	get player => _player.stream;

	final _reloadInvitations = BehaviorSubject<bool>();
	reloadInvitations() {
		_reloadInvitations.sink.add(true);
	}


	Bloc({@required Player player, @required this.reloadUpperPage}) {
		_player.sink.add(player);
	}

	dispose() {
		_player.close();
		_tab.close();
	}
}

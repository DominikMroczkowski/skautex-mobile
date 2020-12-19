import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/widgets/dialog_info.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/models/report.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/helpers/blocs/validate.dart';
import 'players.dart';
import 'package:skautex_mobile/src/routes/home/routes/reports/bloc/bloc.dart' as reportsBloc;

import 'provider.dart';
export 'provider.dart';

class Bloc extends Add<Report> with Validate {
	final _title        = BehaviorSubject<String>();
	final _description  = BehaviorSubject<String>();
	final _players      = BehaviorSubject<List<Player>>();
	final _playerAdd    = BehaviorSubject<Player>();
	final _playerDelete = BehaviorSubject<Player>();
	final _event        = BehaviorSubject<String>();
	final _type         = BehaviorSubject<String>();
	final reportsBloc.Bloc _reportsBloc;
	final Players players;

	Stream<String> get title => _title.stream.transform(hasOneSymbol);
	Stream<String> get description => _description.stream.transform(hasOneSymbol);
	Stream<List<Player>> get choosenPlayers => _players.stream;
	Stream<String> get event => _event.stream;
	Stream<String> get type => _type.stream;

	Function(String) get changeTitle       => _title.sink.add;
	Function(String) get changeDescription => _description.sink.add;
	Function(Player) get addPlayer         => _playerAdd.sink.add;
	Function(Player) get deletePlayer      => _playerDelete.sink.add;
	Function(String) get changeEvent       => _event.sink.add;
	Stream<bool>     get submitValid       => Rx.combineLatest2(title, description, (t, d) => true);
	Function(String) get changeType => _type.sink.add;

	Bloc(BuildContext context) :
		players  = Players(context: context),
		_reportsBloc = reportsBloc.Provider.of(context) {
		otp = context;
		players.otp = context;
		setContext(context);

		MergeStream<StreamedPlayer>([
			_playerAdd.transform(_toStreamedPlayer(false)),
			_playerDelete.transform(_toStreamedPlayer(true))
		]).transform(_toPlayer()).pipe(_players);
		item.listen(
			(i) {
				showDialog(
					context: context,
					builder: (_) {
						return DialogInfo(
							future: i,
							title: 'Dodawanie Raportu',
							runAfter: _popAndUpdate,
						);
					}
				);
			}
		);
	}

	_popAndUpdate() async {
		_reportsBloc.reloadReports();
		_reportsBloc.navigator.currentState.pop();
	}

	_toStreamedPlayer(bool delete) {
		return StreamTransformer<Player, StreamedPlayer>.fromHandlers(
			handleData: (player, sink) {
				StreamedPlayer p = StreamedPlayer();
				p.player = player;
				p.toDelete = delete;
				sink.add(p);
			},
		);
	}

	_toPlayer() {
		return ScanStreamTransformer<StreamedPlayer, List<Player>>(
			(List<Player> list, StreamedPlayer player, _) {
				if (player.toDelete)
					list.removeWhere((i) => (i.uri == player.player.uri));
				else if (!list.any((i) => (i.uri == player.player.uri)))
					list.add(player.player);
				return list;
			},
			<Player> []
		);
	}

	add() {
		Report report = Report(
			title: _title.value,
			description: _description.value,
			players: _players.value,
			event: _event.value,
			type: _type.value
		);

		addItem(report);
	}

	dispose() {
		_title.close();
		_description.close();
		_players.close();
		_playerDelete.close();
		_playerAdd.close();
		_event.close();
		_type.close();
	}
}

class StreamedPlayer {
	Player player;
	bool toDelete = false;
}

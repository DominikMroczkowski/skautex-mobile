import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/delete.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/routes/home/routes/players/bloc/bloc.dart' as playersBloc;

import 'provider.dart';
export 'provider.dart';

class Bloc extends Delete {
	final Player player;

	Bloc(BuildContext context, {@required this.player}) {
		otp = context;
		item.listen(
			(i) {
				i.then((i) {
					final bloc = playersBloc.Provider.of(context);
					bloc.reloadPlayers();
					bloc.navigator.currentState.pop();
				});
			}
		);
	}
}

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/models/invitation.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'package:skautex_mobile/src/models/player.dart';
import 'package:skautex_mobile/src/models/user.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Add<Invitation> {
	final Player player;
	final update;

	final _startDate = BehaviorSubject<String>();
	final _endDate = BehaviorSubject<String>();
	final _template = BehaviorSubject<String>();
	final _trainer = BehaviorSubject<String>();

	Stream<bool> get submitValid  =>
		Rx.combineLatest([template, trainer, startDate, endDate], (_) { return true;});

	Stream get startDate => _startDate.stream;
	Stream get endDate => _endDate.stream;
	Stream get template => _template.stream;
	Stream get trainer => _trainer.stream;

	get changeStartDate => _startDate.sink.add;
	get changeEndDate => _endDate.sink.add;
	get changeTemplate => _template.sink.add;
	get changeTrainer => _trainer.sink.add;

	addInvitation() {
		addItem(
			Invitation(
				trainer: User(uri: _trainer.value),
				template: InvitationTemplate(uri: _template.value),
				player: player,
				startDate: _startDate.value.split(' ').first,
				endDate: _endDate.value.split(' ').first
			)
		);
	}

	Bloc(BuildContext context, {this.player, @required this.update}) {
		otp = context;
		item.listen((i) => i.then((i) {
			update();
			Navigator.of(context).pop();
		}));
	}

	dispose() {
		_startDate.close();
		_endDate.close();
		_template.close();
		_trainer.close();
		super.dispose();
	}
}

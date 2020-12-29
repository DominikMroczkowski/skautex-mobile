import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/helpers/blocs/add.dart';
import 'package:skautex_mobile/src/models/contact_detail.dart';
import 'package:skautex_mobile/src/models/player.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends Add<ContactDetail> {
	final Function update;
	final _type = BehaviorSubject<String>();
	final _value = BehaviorSubject<String>();

	Stream get type => _type.stream;
	Stream get value => _value.stream;

	get changeType => _type.sink.add;
	get changeValue => _value.sink.add;

	Bloc(BuildContext context, {this.update, Player player}) : super(uri: player.uri + 'contact_details/') {
		otp = context;
		item.listen(
			(i) {
				i.then(
					(i) {
						update();
						Navigator.of(context).pop();
					}
				);
			}
		);
	}

	addContact() {
		addItem(
			ContactDetail(
				type: _type.value,
				value: _value.value
			)
		);
	}

	Stream<bool> get submitValid  =>
		Rx.combineLatest([type, value], (_) { return true;});

	dispose() {
		_type.close();
		_value.close();
		super.dispose();
	}
}

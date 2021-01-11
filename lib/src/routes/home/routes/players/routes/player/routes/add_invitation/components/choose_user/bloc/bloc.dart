import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/user.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<User> {
	final Function change;
	final _user = BehaviorSubject<User>();

	get user => _user.stream;
	get changeUser => _user.sink.add;

	Bloc(BuildContext context, {this.change}) {
		otp = context;
		fetch(where: {'is_active': 'true'});
		user.listen(
			(User i) => change(i.uri)
		);
	}

	dispose() {
		_user.close();
		dispose();
	}
}

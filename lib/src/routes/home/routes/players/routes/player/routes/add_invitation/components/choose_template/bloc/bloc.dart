import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<InvitationTemplate> {
	final Function change;
	final _template = BehaviorSubject<InvitationTemplate>();

	get template => _template.stream;
	get changeTemplate => _template.sink.add;

	Bloc(BuildContext context, {this.change}) {
		otp = context;
		fetch(where: {'is_active': 'true'});
		template.listen(
			(InvitationTemplate i) => change(i.uri)
		);
	}

	dispose() {
		_template.close();
		dispose();
	}
}

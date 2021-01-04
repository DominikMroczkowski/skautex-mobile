import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<InvitationTemplate> {
	final Stream reload;
	Bloc(BuildContext context, {@required this.reload}) {
		otp = context;
		super.fetch();
		reload.listen((i) => fetch);
	}
}

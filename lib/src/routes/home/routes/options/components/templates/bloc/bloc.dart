import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/blocs/item_list.dart';
import 'package:skautex_mobile/src/models/invitation_template.dart';
import 'package:skautex_mobile/src/routes/home/routes/options/bloc/bloc.dart' as optionsBloc;

import 'provider.dart';
export 'provider.dart';

class Bloc extends ItemList<InvitationTemplate> {
	final Stream reload;
	final Function update;
	Bloc(BuildContext context, {@required this.reload}) :
		update = optionsBloc.Provider.of(context).reloadTemplates {
		otp = context;
		super.fetch();
		reload.listen((i) => fetch);
	}
}

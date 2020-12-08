import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/helpers/widgets/homeDrawer.dart';
import 'bloc/bloc.dart';
import 'view.dart';

class Options extends StatelessWidget {
	Widget build(context) {
		return Provider(
			context: context,
			child: View()
		);
	}
}



import 'package:flutter/material.dart';

import 'bloc/bloc.dart';
import 'view.dart';

class AddReport extends StatelessWidget {
	Widget build(BuildContext context) {
		return Provider(child: View(), context: context);
	}
}

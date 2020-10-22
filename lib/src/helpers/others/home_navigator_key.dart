import 'package:flutter/material.dart';
import 'package:skautex_mobile/src/routes/home/bloc/bloc.dart' as home;

homeNavigatorKey(BuildContext context) {
	return home.Provider.of(context).homeNavigatorKey;
}

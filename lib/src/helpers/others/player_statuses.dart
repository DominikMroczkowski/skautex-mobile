import 'package:flutter/material.dart';

getPlayerStatusName(String name) {
	switch (name) {
		case 'inapproprieate':
			return 'nieodpowiedni';
		case 'test':
			return 'Testy';
		case 'observation':
			return 'Obserwacje';
		default:
			return 'Brak tłumaczenia';
	}
}

getPlayerStatusColor(String name) {
	switch (name) {
		case 'inappropriate':
			return Colors.red;
		case 'test':
			return Colors.orange;
		case 'observation':
			return Colors.blue;
		default:
			return Colors.white;
	}
}

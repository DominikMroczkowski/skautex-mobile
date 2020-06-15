import 'package:flutter/material.dart';

import '../models/permissions.dart';

class DashCard {
	String text;
	IconData icon;
	String path;
	Permissions perms;

	DashCard(String text, IconData icon, String path, Permissions perms) :
		text = text,
		icon = icon,
		path = path,
		perms = perms;
}


class Data {
	static List<DashCard> main() {
		List<DashCard> toRet = [];

		Permissions perms = Permissions.toXOR();
		perms.viewGroup = true;
		toRet.add(DashCard('Zawodnicy', Icons.person_pin, '/home/players', perms));
		toRet.add(DashCard('Rekomendacje', Icons.favorite, '/home/recommended', perms));
		toRet.add(DashCard('Kalendarz', Icons.event, '/home/calendar', perms));
		toRet.add(DashCard('Zadania', Icons.check, '/home/task', perms));
		toRet.add(DashCard('Wydatki', Icons.poll, '/home/expenses', perms));
		toRet.add(DashCard('Rezerwacje', Icons.save, '/home/booked', perms));

		return toRet;
	}

	static List<DashCard> role() {
		List<DashCard> toRet = [];

		Permissions perms = Permissions.toXOR();
		perms.viewGroup = true;
		toRet.add(DashCard('Raporty', Icons.person_outline, '/home/reports', perms));
		toRet.add(DashCard('Testy', Icons.tune, '/players/tests', perms));
		toRet.add(DashCard('Rankingi', Icons.tune, '/players/rankings',  perms));

		return toRet;
	}

	static List<DashCard> options() {
		List<DashCard> toRet = [];

		Permissions perms = Permissions.toXOR();
		perms.viewUser = true;
		toRet.add(DashCard('Użytkownicy', Icons.person_outline, '/home/users', perms));
		perms = Permissions.toXOR();
		perms.viewTotpdevice = true;
		toRet.add(DashCard('Opcje', Icons.tune, '/options', perms));
		return toRet;
	}

}

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
		perms.viewAuditentry = true;
		toRet.add(DashCard('Zawodnicy', Icons.person_pin, '/home/player', perms));
		perms = Permissions.toXOR();

		toRet.add(DashCard('Rekomendacje', Icons.favorite, '/home/recommended', perms));
		perms = Permissions.toXOR();

		toRet.add(DashCard('Kalendarz', Icons.event, '/home/calendar', perms));
		toRet.add(DashCard('Zadania', Icons.check, '/home/task', perms));
		toRet.add(DashCard('Wydatki', Icons.poll, '/home/expenses', perms));
		toRet.add(DashCard('Rezerwacje', Icons.save, '/home/booked', perms));

		return toRet;
	}

	static List<DashCard> role() {
		List<DashCard> toRet = [];

		Permissions perms = Permissions.toXOR();

		toRet.add(DashCard('Raporty', Icons.person_outline, '/home', perms));
		toRet.add(DashCard('Testy', Icons.tune, '/players', perms));
		toRet.add(DashCard('Rankingi', Icons.tune, '/players',  perms));

		return toRet;
	}

	static List<DashCard> options() {
		List<DashCard> toRet = [];

		Permissions perms = Permissions.toXOR();
		perms.viewUser = true;
		toRet.add(DashCard('Użytkownicy', Icons.person_outline, '/home', perms));
		perms = Permissions.toXOR();
		perms.viewTotpdevice = true;
		toRet.add(DashCard('Opcje', Icons.tune, '/players', perms));
		return toRet;
	}

}

import 'package:skautex_mobile/src/models/jwt.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

class SkautexDbProvider {
	Future<Database> db;

	SkautexDbProvider() {
	  db = init();
	}

	Future<Database> init() async {
		Directory documents = await getApplicationDocumentsDirectory();
		final path = join(documents.path, "refresh.db");
		print('$path');
		return openDatabase(
			path,
			version: 1,
			onCreate: (Database newDb, int version) async {
				newDb.execute("""
					CREATE TABLE Refresh (
						refresh String
					);
				""");
			}
		);
	}

	Future<String> getRefresh() async {
		print((await db).isOpen);
		var rows = await (await db).query(
			"Refresh"
		);
		if (rows.isEmpty) {
			return "refresh";
		}
		return (rows[0]['refresh'] as String);
	}

	setRefresh(Future<JWT> jwt) async {
		await clear();
		JWT jwtC = await jwt;
		(await db).insert("Refresh", {'refresh' : jwtC.refresh});
	}

	Future<int> clear() async {
		return (await db).delete("Refresh");
	}
}

final SkautexDbProvider skautexDbProvider = SkautexDbProvider();

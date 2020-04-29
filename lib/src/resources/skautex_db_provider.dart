import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
	Database db;

	NewsDbProvider() {
	  init();
	}

	void init() async {
		Directory documents = await getApplicationDocumentsDirectory();
		final path = join(documents.path, "item.db");
		db = await openDatabase(
			path,
			version: 1,
			onCreate: (Database newDb, int version) {
				newDb.execute("""
					CREATE TABLE Items (
						id INTEGER PRIMARY KEY
					);
				""");
			}
		);
	}

	// Todo - store and fetch top ids
	Future<List<int>> fetch() {
		return null;
	}

	Future<ItemModel> fetchItem(int id) async {
		final maps = await db.query(
			"Items",
			columns: null,
			where: "id = ?",
			whereArgs: [id]
		);

		if (maps.length > 0) {
			return ItemModel.fromDb(maps.first);
		}

		return null;
	}

	/*
	 * Todo: create model with toMapForDb()
	 *
	Future<int> addItem(ItemModel item) {
		return db.insert("Items", item.toMapForDb());
	}
	*/

	Future<int> clear() {
		return db.delete("Items");
	}
}

f

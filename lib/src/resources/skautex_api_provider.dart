import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';
import 'dart:async';
import 'repository.dart';

final _root = 'https://skautex.azurewebsites.net/';

class SkautexApiProvider implements Source {
	SecurityContext clientContext = new SecurityContext()
    		..setTrustedCertificates(file: 'CA.pem');
	Client client = Client(context: clientContext);

	Future<List<int>> fetchToken() async {
		final response = await client.post('$_root/jwt/');
		final token = json.decode(response.body);

		return List<int>.from(ids);
	}


	Future<ItemModel> fetchItem(int id) async {
		final response = await  client.get('$_root/item/$id.json');
		final parsedJson = json.decode(response.body);

		return ItemModel.fromJson(parsedJson);
	}
}

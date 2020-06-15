import 'package:skautex_mobile/src/models/player.dart';

class Report {
	String uri;
	String title;
	String owner;
	String openDate;
	String closeDate;
	String description;
	List<Player> players;
	String event;

	Report({String title, String description, List<Player> players, String event}) :
		title = title,
		description = description,
		players = players,
		event = event;

	Report.fromJson(Map<String, dynamic> parsedJson) :
		uri         = parsedJson['url'] ?? '',
    title       = parsedJson['title'] ?? '',
		owner       = parsedJson['owner'] ?? '',
   	openDate    = parsedJson['open_date'] ?? '',
   	closeDate   = parsedJson['close_date'] ?? '',
   	description = parsedJson['description'] ?? '';

	toJson() {
		List<String> playersUris = [];
		players.forEach((Player p) => playersUris.add(p.uri));
		return <String, dynamic> {
			'url' : uri,
			'title' : title,
			'description' : description,
			'players' : playersUris,
		};
	}

	Map<String, dynamic> toPost() {
		Map map = toJson();
		map.remove('url');
		print(map.toString());
		return map;
	}
}

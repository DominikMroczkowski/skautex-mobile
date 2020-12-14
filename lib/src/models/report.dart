import 'package:skautex_mobile/src/models/player.dart';

class Report {
	String uri;
	String title;
	String owner;
	String openDate;
	String closeDate;
	String description;
	String type;
	List<Player> players;
	String event;

	Report({String title, String description, List<Player> players, String event, this.type}) :
		title = title,
		description = description,
		players = players,
		event = event;

	Report.fromJson(Map<String, dynamic> parsedJson) :
		uri         = parsedJson['url'] ?? '',
    title       = parsedJson['title'] ?? '',
		owner       = parsedJson['owner']['username'] ?? '',
   	openDate    = parsedJson['open_date']?.toString()?.substring(0, 10) ?? '1970-01-01',
   	closeDate   = parsedJson['close_date']?.toString()?.substring(0, 10) ?? '1970-01-01',
   	description = parsedJson['description'] ?? '',
   	type = parsedJson['type'] ?? '';

	toJson() {
		List<String> playersUris = [];
		players.forEach((Player p) => playersUris.add(p.uri));
		return <String, dynamic> {
			'url' : uri,
			'title' : title,
			'description' : description,
			'players' : playersUris,
			'type': type
		};
	}

	Map<String, dynamic> toPost() {
		Map map = toJson();
		map.remove('url');
		print(map.toString());
		return map;
	}
}

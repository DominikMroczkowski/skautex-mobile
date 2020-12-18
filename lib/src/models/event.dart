import 'package:skautex_mobile/src/models/event_type.dart';
import 'package:skautex_mobile/src/models/user.dart';

class Event {
	String uri;
	String name;
	String description;
	String startDate;
	String endDate;
	EventType type;
	User owner;
	List<User> connectedUsers;
	bool hide;
	String color;

	Event({this.uri, this.name, this.description, this.startDate, this.endDate, this.type, this.owner, this.hide, this.color, this.connectedUsers});

	Event.fromJson(Map<String, dynamic> parsedJson) :
		uri = parsedJson['url'],
		name = parsedJson['name'] ?? '',
		description = parsedJson['description'] ?? '',
		startDate = parsedJson['start_date'],
		endDate = parsedJson['end_date'],
		type = EventType.fromJson(parsedJson['type']),
		owner = User.fromJson(parsedJson['owner']),
		hide = parsedJson['hide'] ?? true,
		color = parsedJson['color'] ?? '#ffffff';

	Map<String, dynamic> toJson() {
		var map = <String, dynamic> {
			'url'   : uri,
			'name'  : name,
			'type'  : type.uri,
			'description' : description,
			'start_date' : startDate,
			'end_date' : endDate,
			'owner' : owner,
			'hide' : hide,
			'color' : color,
		};
		if (connectedUsers != null)
			map['connected_users'] = connectedUsers.map((i) => i.uri).toList();
		return map;
	}

	Map<String, dynamic> toPost() {
		var map = toJson();
		map.remove('url');
		map.remove('owner');
		return map;
	}
}

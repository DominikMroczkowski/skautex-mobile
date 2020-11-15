import 'user.dart';
import 'booking.dart';

class BookingBlacklist {
	String uri;
	String description;
	User user;
	Booking booking;

	BookingBlacklist({this.uri, this.description, this.user, this.booking});

	BookingBlacklist.fromJson(Map<String, dynamic> parsedJson) :
		uri   = parsedJson['url'],
		description = parsedJson['description'] ?? '';

	Map<String, dynamic> toJson() {
		return <String, dynamic> {
			'url': uri,
			'description': description,
			'user': user.uri,
			'booking_object': booking.uri
		};
	}

	Map<String, dynamic> toPost() {
		var map = toJson();
		map.remove('url');
		return map;
	}
}

class BookingReservation {
	String uri;
	String objectUri;
	String objectName;
	String user;
	String startDate;
	String endDate;

	BookingReservation({this.uri, this.objectUri, this.objectName, this.user, this.startDate, this.endDate});

	BookingReservation.fromJson(Map<String, dynamic> parsedJson) :
		uri       = parsedJson['url'],
		objectUri = parsedJson['booking_object']['url'],
		objectName = parsedJson['booking_object']['name'],
		user      = parsedJson['user']['url'],
		startDate = parsedJson['start_date'],
		endDate   = parsedJson['end_date'];

	Map<String, dynamic> toJson() {
		return <String, dynamic> {
			'url'            : uri,
			'booking_object' : objectUri,
			'user'           : user,
			'start_date'     : startDate,
			'end_date'       : endDate
		};
	}

	Map<String, dynamic> toPost() {
		var map = toJson();
		map.remove('url');
		return map;
	}
}

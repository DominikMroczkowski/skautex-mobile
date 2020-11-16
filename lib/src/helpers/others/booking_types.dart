getBookingTypeName(String name) {
	switch (name) {
		case 'Car':
			return 'Samochód';
		case 'Mobile Phone':
			return 'Telefon';
		case 'Computer':
			return 'Komputer';
		default:
			return 'Brak tłumaczenia';
	}
}

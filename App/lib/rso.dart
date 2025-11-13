class RSO {
  final String name;
  final String description;
  bool isMember;
  final List<RsoEvent> events;

  RSO({
    required this.name,
    required this.description,
    this.isMember = false,
    required this.events,
  });
}

class RsoEvent {
  final String title;       // Event title
  final String description; // Event description
  final String location;    // Event location
  final RSO rso;            // Reference back to parent RSO
  final DateTime startTime;
  final DateTime endTime;

  RsoEvent({
    required this.title,
    required this.description,
    required this.location,
    required this.rso,
    required this.startTime,
    required this.endTime,
  });
}

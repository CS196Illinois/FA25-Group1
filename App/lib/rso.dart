enum MembershipStatus {
  notMember,   // Never applied or applied and rejected
  pending,     // Application submitted, awaiting approval
  member,      // Active member
  inactive,    // Was a member but left (can rejoin without reapplying)
}

class User {
  final String username;
  final String passkey;
  final Map<RSO, String> rso_list;

  User({
    required this.username,
    required this.passkey,
    Map<RSO, String>? rso_list,
  }) : rso_list = rso_list ?? {};
}

class RSO {
  final String name;
  final String description;
  MembershipStatus membershipStatus;
  final List<RsoEvent> events;
  bool eventsLoadedInCalendar; // Track whether events are currently shown in calendar

  RSO({
    required this.name,
    required this.description,
    this.membershipStatus = MembershipStatus.notMember,
    required this.events,
    this.eventsLoadedInCalendar = false, // Default to not loaded
  });

  // Convenience getter for backward compatibility
  bool get isMember => membershipStatus == MembershipStatus.member;
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

import 'rso.dart';

// Simple in-memory user database
// In a real app, this would be fetched from a backend server
class UserDatabase {
  static User getUserByCredentials(String username, String password) {
    // For now, accept any credentials and create/return a user
    if (username.isEmpty || password.isEmpty) {
      throw Exception("Invalid credentials");
    } else if (username == "student@illinois.edu" &&
        password == "password123") {
      return User(
        username: username,
        passkey: password,
        rso_list:
            {}, // Will be populated in RsoListPage based on getUserMemberships
      );
    } else if (username == "frankp5@illinois.edu" && password == "123") {
      return User(
        username: username,
        passkey: password,
        rso_list:
            {}, // Will be populated in RsoListPage based on getUserMemberships
      );
    } else {
      throw Exception("Invalid credentials");
    }

    // In a real app, this would validate against a backend
  }

  // Check if user has pre-existing memberships
  // Returns a map of RSO name -> membership status
  static Map<String, String> getUserMemberships(String username) {
    if (username == "student@illinois.edu") {
      return {
        "Open Source @ Illinois": "member",
        "WCS: Women in Computer Science": "member",
      };
    } else if (username == "frankp5@illinois.edu") {
      return {"ACM: Association for Computing Machinery": "member"};
    }

    // No pre-existing memberships for new users
    return {};
  }
}

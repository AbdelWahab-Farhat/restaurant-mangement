
enum Role { customer, admin }

class User {
  String userID;
  String userName;
  String password;
  Role role;

  User({
    required this.userID,
    required this.userName,
    required this.password,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json["userID"],
      userName: json["userName"],
      password: json["password"],
      role: roleFromJson(json["role"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "userName": userName,
      "password": password,
      "role": roleToJson(role),
    };
  }
}

Role roleFromJson(String role) {
  switch (role) {
    case 'customer':
      return Role.customer;
    case 'admin':
      return Role.admin;
    default:
      throw ArgumentError('Invalid role: $role');
  }
}

String roleToJson(Role role) {
  switch (role) {
    case Role.customer:
      return 'customer';
    case Role.admin:
      return 'admin';
    default:
      throw ArgumentError('Invalid role: $role');
  }
}

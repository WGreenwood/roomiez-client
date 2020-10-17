
class User {
  static final User _nullInstance =  User(id: null, displayName: null, email: null, registered: null, householdId: null, householdCreator: null);
  static User get nullInstance => _nullInstance;

  final int id;
  final String displayName;
  final String email;
  final DateTime registered;
  final int householdId;
  final bool householdCreator;

  User({this.id, this.displayName, this.email, this.registered, this.householdId, this.householdCreator});

  bool isNull() => identical(this, nullInstance);
  bool isNotNull() => !isNull();

  static User fromJson(dynamic json)
    => json.isEmpty
    ? User.nullInstance
    : User(
      id: json['id'] as int,
      displayName: json['displayName'],
      email: json['email'],
      registered: DateTime.parse(json['registered']),
      householdId: json['householdId'],
      householdCreator: json['householdCreator'],
    );

  dynamic toJson()
    => isNull() ? {} : {
      'id': id,
      'displayName': displayName,
      'email': email,
      'registered': registered.toIso8601String(),
      'householdId': householdId,
      'householdCreator': householdCreator,
    };

  @override
  String toString()
    => identical(this, nullInstance)
    ? 'User{null}'
    : 'User{id: $id, displayName: $displayName, email: $email, registered: $registered, householdId: $householdId, householdCreator: $householdCreator}';
}
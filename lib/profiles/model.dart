class Profile {
  final String profileId;
  final String username;
  final String lastName;
  final String firstName;
  final String middleName;
  final String number;
  final String address;
  final String? avatarUrl;

  Profile({
    required this.profileId,
    required this.username,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.number,
    required this.address,
    this.avatarUrl,
  });

  factory Profile.fromMap(Map<String, dynamic> map){
    return Profile(
      profileId: map['profile_id'] as String,
      username: map['username'] as String,
      lastName: map['last_name'] as String,
      firstName: map['first_name'] as String,
      middleName: map['middle_name'] as String,
      number: map['number'] as String,
      address: map['address'] as String,
      avatarUrl: map['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profile_id': profileId,
      'username': username,
      'last_name': lastName,
      'first_name': firstName,
      'middle_name': middleName,
      'number': number,
      'address': address,
      'avatar_url': avatarUrl,
    };
}
}
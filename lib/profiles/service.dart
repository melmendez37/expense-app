import 'package:expense_app/profiles/model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final database = Supabase.instance.client.from('profiles');

  //Create
  Future createProfile(Profile newProfile) async {
    await database.insert(newProfile.toMap());
  }

  //Read
  final stream = Supabase.instance.client.from('profiles').stream(
      primaryKey: ['profile_id']
  ).eq('profile_id', Supabase.instance.client.auth.currentUser?.id as Object)
      .map((data) => data.map((profileMap) => Profile.fromMap(profileMap))
      .toList());

  //Update
  Future updateProfile(Profile oldProfile, Profile newProfile) async{
    await database.update({
      'profile_id': oldProfile.profileId,
      'username': newProfile.username,
      'last_name': newProfile.lastName,
      'first_name': newProfile.firstName,
      'middle_name': newProfile.middleName,
      'number': newProfile.number,
      'address': newProfile.address,
    }).eq('profile_id', oldProfile.profileId).select();
  }

  //Delete
}
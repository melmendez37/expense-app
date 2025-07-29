import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  //Sign in
  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    return await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password
    );
  }

  //sign up
  Future<AuthResponse> signUpWithEmailPassword(
      String email, String password) async {
    final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password
    );
    return response;
  }

  //sign out
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
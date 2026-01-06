import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://rsnxpexkdsmvpulwdlbf.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJzbnhwZXhrZHNtdnB1bHdkbGJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY5OTYwODMsImV4cCI6MjA4MjU3MjA4M30.MmJygggCAjiZsqkgdz-4Zc38BZ0q0EGPLVM_I6j2cO4';
  
  static bool _initialized = false;
  
  static Future<void> initialize() async {
    if (_initialized) {
      if (kDebugMode) {
        print('Supabase already initialized');
      }
      return;
    }

    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
        ),
        debug: kDebugMode,
      );
      
      _initialized = true;
      
      if (kDebugMode) {
        print('✅ Supabase initialized successfully');
        print('📍 URL: $supabaseUrl');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to initialize Supabase: $e');
      }
      rethrow;
    }
  }
  
  static SupabaseClient get client {
    if (!_initialized) {
      throw Exception('Supabase not initialized. Call SupabaseConfig.initialize() first.');
    }
    return Supabase.instance.client;
  }
  
  static GoTrueClient get auth => client.auth;
  
  static bool get isInitialized => _initialized;
  
  static User? get currentUser => client.auth.currentUser;
  
  static String? get currentUserId => currentUser?.id;
  
  static bool get isAuthenticated => currentUser != null;
  
  static Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;
}

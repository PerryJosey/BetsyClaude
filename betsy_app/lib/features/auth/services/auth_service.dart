import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/config/supabase_config.dart';

class AuthService {
  final SupabaseClient _client = SupabaseConfig.client;

  /// Sign in with Google
  Future<AuthResponse?> signInWithGoogle() async {
    try {
      final serverClientId = const String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');
      final googleSignIn = GoogleSignIn(
        serverClientId: serverClientId.isNotEmpty ? serverClientId : null,
        scopes: const ['email', 'profile'],
      );

      final account = await googleSignIn.signIn();
      if (account == null) {
        return null;
      }

      final authentication = await account.authentication;
      final idToken = authentication.idToken;

      if (idToken == null || idToken.isEmpty) {
        throw AuthException('Sign-in failed. Please try again or use email.');
      }

      return await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );
    } on AuthException {
      rethrow;
    } on SocketException {
      throw AuthException('Unable to connect. Check your internet.');
    } catch (e) {
      throw AuthException('Sign-in failed. Please try again or use email.');
    }
  }

  /// Sign in with Apple (iOS only)
  Future<AuthResponse?> signInWithApple() async {
    if (!Platform.isIOS) return null;

    try {
      final available = await SignInWithApple.isAvailable();
      if (!available) {
        throw AuthException('Apple Sign In is not available on this device.');
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final idToken = credential.identityToken;
      if (idToken == null || idToken.isEmpty) {
        throw AuthException('Sign-in failed. Please try again or use email.');
      }

      return await _client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return null;
      }
      throw AuthException('Sign-in failed. Please try again or use email.');
    } on AuthException {
      rethrow;
    } on SocketException {
      throw AuthException('Unable to connect. Check your internet.');
    } catch (e) {
      throw AuthException('Sign-in failed. Please try again or use email.');
    }
  }

  /// Sign up a new user with email, password, and name
  Future<AuthResponse> signUp(String email, String password, String name) async {
    try {
      if (kDebugMode) {
        print('🔐 Attempting sign up for: $email');
      }

      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'display_name': name,
        },
      );

      if (kDebugMode) {
        print('✅ Sign up successful for: $email');
      }

      return response;
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('❌ Sign up failed: ${e.message}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Unexpected error during sign up: $e');
      }
      throw AuthException('An unexpected error occurred during sign up');
    }
  }

  /// Sign in an existing user with email and password
  Future<AuthResponse> signIn(String email, String password) async {
    try {
      if (kDebugMode) {
        print('🔐 Attempting sign in for: $email');
      }

      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (kDebugMode) {
        print('✅ Sign in successful for: $email');
      }

      return response;
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('❌ Sign in failed: ${e.message}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Unexpected error during sign in: $e');
      }
      throw AuthException('An unexpected error occurred during sign in');
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      if (kDebugMode) {
        print('🔐 Attempting sign out');
      }

      await _client.auth.signOut();

      if (kDebugMode) {
        print('✅ Sign out successful');
      }
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('❌ Sign out failed: ${e.message}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Unexpected error during sign out: $e');
      }
      throw AuthException('An unexpected error occurred during sign out');
    }
  }

  /// Get the currently authenticated user
  Future<User?> getCurrentUser() async {
    try {
      final user = _client.auth.currentUser;
      
      if (kDebugMode) {
        if (user != null) {
          print('👤 Current user: ${user.email}');
        } else {
          print('👤 No user currently authenticated');
        }
      }

      return user;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting current user: $e');
      }
      return null;
    }
  }

  /// Stream of authentication state changes
  Stream<AuthState> get authStateChanges {
    return _client.auth.onAuthStateChange;
  }

  /// Send a password reset email to the user
  Future<void> resetPassword(String email) async {
    try {
      if (kDebugMode) {
        print('🔐 Sending password reset email to: $email');
      }

      await _client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.betsyapp://reset-password',
      );

      if (kDebugMode) {
        print('✅ Password reset email sent to: $email');
      }
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('❌ Password reset failed: ${e.message}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Unexpected error during password reset: $e');
      }
      throw AuthException('An unexpected error occurred during password reset');
    }
  }

  /// Check if a user is currently authenticated
  bool get isAuthenticated => _client.auth.currentUser != null;

  /// Get the current user's ID
  String? get currentUserId => _client.auth.currentUser?.id;

  /// Get the current user's email
  String? get currentUserEmail => _client.auth.currentUser?.email;

  /// Get the current user's name from metadata
  String? get currentUserName {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return user.userMetadata?['name'] as String? ?? 
           user.userMetadata?['display_name'] as String?;
  }

  /// Update user metadata (e.g., name, profile info)
  Future<UserResponse> updateUserMetadata(Map<String, dynamic> metadata) async {
    try {
      if (kDebugMode) {
        print('🔐 Updating user metadata');
      }

      final response = await _client.auth.updateUser(
        UserAttributes(data: metadata),
      );

      if (kDebugMode) {
        print('✅ User metadata updated');
      }

      return response;
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('❌ Update metadata failed: ${e.message}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Unexpected error updating metadata: $e');
      }
      throw AuthException('An unexpected error occurred updating user metadata');
    }
  }

  /// Resend verification email to user
  Future<void> resendVerificationEmail(String email) async {
    try {
      if (kDebugMode) {
        print('📧 Resending verification email to: $email');
      }

      await _client.auth.resend(
        type: OtpType.signup,
        email: email,
      );

      if (kDebugMode) {
        print('✅ Verification email resent to: $email');
      }
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('❌ Resend verification failed: ${e.message}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Unexpected error resending verification: $e');
      }
      throw AuthException('An unexpected error occurred resending verification email');
    }
  }

  /// Check if current user's email is verified
  bool get isEmailVerified {
    final user = _client.auth.currentUser;
    return user?.emailConfirmedAt != null;
  }
}

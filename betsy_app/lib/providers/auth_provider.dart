import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../features/auth/services/auth_service.dart';

/// Provider for AuthService singleton
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// Provider for current authenticated user
final currentUserProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  
  return authService.authStateChanges.map((authState) {
    return authState.session?.user;
  });
});

/// Provider to check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  
  return userAsync.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// Provider for current user ID
final currentUserIdProvider = Provider<String?>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  
  return userAsync.when(
    data: (user) => user?.id,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Provider for current user email
final currentUserEmailProvider = Provider<String?>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  
  return userAsync.when(
    data: (user) => user?.email,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Provider for current user name
final currentUserNameProvider = Provider<String?>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  
  return userAsync.when(
    data: (user) {
      if (user == null) return null;
      return user.userMetadata?['name'] as String? ?? 
             user.userMetadata?['display_name'] as String?;
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

/// State notifier for auth loading states
class AuthStateNotifier extends StateNotifier<AsyncValue<void>> {
  AuthStateNotifier(this._authService) : super(const AsyncValue.data(null));

  final AuthService _authService;

  Future<void> signUp(String email, String password, String name) async {
    state = const AsyncValue.loading();
    
    try {
      await _authService.signUp(email, password, name);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    
    try {
      await _authService.signIn(email, password);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    
    try {
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AsyncValue.loading();
    
    try {
      await _authService.resetPassword(email);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

/// Provider for auth state notifier
final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier, AsyncValue<void>>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthStateNotifier(authService);
});

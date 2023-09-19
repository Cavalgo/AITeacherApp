abstract class AuthProvider {
  logIn({required String email, required String password});
  logOut();
  register({
    required String email,
    required String password,
    required String name,
  });
  deleteAccount();
  getCurrentUser();
}

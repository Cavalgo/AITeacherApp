import 'package:ai_chat_voice/firebase_options.dart';
import 'package:ai_chat_voice/services/authentication/auth_exception.dart';
import 'package:ai_chat_voice/services/authentication/auth_provider.dart';
import 'package:ai_chat_voice/services/authentication/my_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FBAuthService implements AuthProvider {
  MyUser? myUser;

/* Singleton */
  static final FBAuthService _fbServiceSingleton = FBAuthService._internal();
  factory FBAuthService() {
    return _fbServiceSingleton;
  }
  FBAuthService._internal();
/* Singleton */

//Methods
  @override
  MyUser? getCurrentUser() {
    return myUser;
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      await user?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      throw MyAuthException(
        e.code,
        e.toString(),
      );
    } catch (e) {
      throw MyAuthException(
        'There is an issue',
        e.toString(),
      );
    }
  }

  @override
  Future<void> logIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw MyAuthException(
        e.code,
        e.toString(),
      );
    } catch (e) {
      throw MyAuthException(
        'There is an issue',
        e.toString(),
      );
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      myUser = null;
    } catch (e) {
      MyAuthException('Problem to log-out', e.toString());
    }
  }

  @override
  deleteAccount() {
    throw UnimplementedError();
  }

  Future<void> sendEmailVerification() async {
    if (myUser != null) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
    }
  }

  Future<bool> checkIfUserIsEmailVerified() async {
    if (myUser != null) {
      await FirebaseAuth.instance.currentUser!.reload();
      myUser!.isEmailVerified =
          FirebaseAuth.instance.currentUser!.emailVerified;
      return myUser!.isEmailVerified!;
    } else {
      return false;
    }
  }

  Future<void> initlizeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //we set a listener to user changes and update the user object here.
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          myUser = null;
        } else {
          myUser = MyUser(
            userId: user.uid,
            email: user.email,
            name: user.displayName,
            isEmailVerified: user.emailVerified,
          );
        }
      },
    );
  }
}

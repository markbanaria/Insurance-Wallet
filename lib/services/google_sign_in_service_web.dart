import 'dart:js' as js;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GoogleSignInService {
  late GoogleSignIn _googleSignIn;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  GoogleSignInService() {
    String? clientId = js.context['env']['GOOGLE_CLIENT_ID'] as String;
    
    _googleSignIn = GoogleSignIn(
      clientId: clientId,
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication auth = await account.authentication;
        await _storage.write(key: 'token', value: auth.accessToken);
        await _storage.write(key: 'user', value: account.displayName);
        await _storage.write(key: 'email', value: account.email);
        await _storage.write(key: 'image', value: account.photoUrl);

        return {
          "name": account.displayName,
          "email": account.email,
          "image": account.photoUrl,
          "id": account.id,
          "token": auth.accessToken,
        };
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}

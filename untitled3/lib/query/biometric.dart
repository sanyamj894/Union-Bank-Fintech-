import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class BioMetricAuth{
  static bool authStatus = false;
  static final storage = FlutterSecureStorage();
  static String? user;
  static String? password;
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<void> addAuth(String emailAddress,String password) async {
    if(BioMetricAuth.authStatus==false){
      await storage.write(key: 'user', value: emailAddress);
      await storage.write(key: 'password', value: password);
    }
  }

  static Future<void> checkAuth() async {
    user = await storage.read(key: 'user');
    password = await storage.read(key: 'password');
    if(user!=null&&password!=null){
      authStatus=true;
    } else {
      authStatus = false;
    }
  }

  Future<String> bioMetrics() async {
    try {
      if(authStatus){
        print(authStatus);
        print(user);
        print(password);
        final support = await _auth.isDeviceSupported();
        print("Device supports biometrics: $support");

        final available = await _auth.getAvailableBiometrics();
        print("Available Biometrics: $available");

        // If Face ID is not available, return a proper message
        if (!available.contains(BiometricType.strong)) {
          return "Please enable Face Biometrics in Settings";
        }

        // Proceed with authentication
        final authenticated = await _auth.authenticate(
          localizedReason: "Face ID Login",
          options: const AuthenticationOptions(biometricOnly: true),
        );

        print("Authentication result: $authenticated");

        return authenticated ? "" : "Failed to Authenticate. Try Again...";
      } else{
        return "Please Login first with email ID";
      }
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }


}
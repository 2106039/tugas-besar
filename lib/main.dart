import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_uilogin/provider/auth_provider.dart';
import 'package:flutter_uilogin/screen/home_screen.dart';
import 'package:flutter_uilogin/screen/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
        ),
        themeMode: ThemeMode.dark,
        home: StreamBuilder<firebase_auth.User?>(
          stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (snapshot.hasData && snapshot.data != null) {
                return HomePage();
              } else {
                return LoginScreen();
              }
            }
          },
        ),
      ),
    );
  }
}

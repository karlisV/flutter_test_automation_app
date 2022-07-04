import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import './home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test automation demo app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _pwdTextController = TextEditingController();

  SnackBar snackBar(String text) {
    return SnackBar(
      content: Text(text),
    );
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _pwdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                      ),
                      controller: _emailTextController,
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains(RegExp(r'^(.+)@(.+)$'))) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0)),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                      ),
                      obscureText: true,
                      controller: _pwdTextController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0)),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailTextController.text,
                                      password: _pwdTextController.text);
                              if (!mounted) return;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                            } on FirebaseAuthException catch (e) {
                              log(e.code);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar(e.code));
                            }
                          } else {
                            log('Form validation triggered');
                          }
                        },
                        child: const Text('Login'))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

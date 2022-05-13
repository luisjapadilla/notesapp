import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class Registerview extends StatefulWidget {
  const Registerview({Key? key}) : super(key: key);

  @override
  _RegisterviewState createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  late final TextEditingController _email;
  late final TextEditingController _psw;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _psw = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _psw.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Enter your email'
                    ),
                  ),
                  TextField(
                    controller: _psw,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: 'Enter your password'
                    ),
                  ),
                  TextButton(
                    onPressed: ()  async {
                      final email = _email.text;
                      final password = _psw.text;
                      try {
                        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                        print(userCredential);
                      } on FirebaseAuthException catch(e) {
                        if (e.code == 'weak-passwork'){

                        }
                        else if (e.code == 'email-already-in-use'){

                        }
                        else if(e.code == 'invalid-email'){

                        }
                      }
                    }, child: Text('Register'),
                  ),
                ],
              );
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}


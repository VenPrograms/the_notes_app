import 'package:flutter/material.dart';
import 'package:the_notes_app/controllers/google_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: Container(
                  decoration: BoxDecoration(


                  ),
                ),
            ),
            Text(
                'The Drawers Of Your Life'
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child:
              ElevatedButton(
                onPressed: (){
                  signInWithGoogle(context);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
                  backgroundColor: MaterialStateProperty.all(Colors.grey[700]),
                ),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(
                    "Continue With Google",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

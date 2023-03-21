import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'confirm_email.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgot-password';
  final String message =
      "An email has just been sent to you, Click the link provided to complete password reset";

  const ForgotPassword({super.key});
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  late String _email;

  _passwordReset() async {
    try {
      _formKey.currentState?.save();
      await _auth.sendPasswordResetEmail(email: _email);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ConfirmEmail(
            message: widget.message,
            key: _formKey,
          );
        }),
      );
    } catch (e) {
      debugPrintStack(label: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const SizedBox(height: 4),
              const Text(
                'Enter your email  to reset your password',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 28),
              TextFormField(
                onSaved: (newEmail) {
                  _email = newEmail!;
                },
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 15.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),

                  // fillColor: Colors.white,
                  filled: true,
                  hintText: "Email",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  border: border(context),
                  enabledBorder: border(context),
                  focusedBorder: focusBorder(context),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: const Text(
                    'Send Email',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _passwordReset();
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                child: const Text(
                  'Back to Login',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  border(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey[400]!,
        width: 0.0,
      ),
    );
  }

  focusBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 1.0,
      ),
    );
  }
}

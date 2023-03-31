import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:ayurveda/screens/auth_errors.dart';
import 'package:ayurveda/screens/custom_error.dart';
import '../auth/auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:ayurveda/models/user_model.dart' as user_model;
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password, _confirmPassword, _name;

  bool _isLoading = false;
  bool obscureText = true;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      _formKey.currentState!.save();

      try {
        final UserCredential userCredential =
            await FirebaseAuthService.signUpWithEmailAndPassword(
                email: _email, password: _password);
        const FirebaseChatCoreConfig('contacts', 'rooms', 'users');
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
            firstName: _name.split(' ')[0],
            id: userCredential.user!.uid,
            imageUrl: 'https://ui-avatars.com/api/?name=$_name',
          ),
        );
        final currentUser = userCredential.user;
        final user = user_model.User(
            id: currentUser!.uid,
            fullName: _name,
            email: _email,
            address: "",
            imageUrl:
                'https://ui-avatars.com/api/?name=$_name&background=0D8ABC&color=fff',
            phone: "");

        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update(user.toMap());

        setState(() {
          _isLoading = false;
        });

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: CustomSnackBarContent(
                errorText: (AuthErrors.getErrorText(e.code)))));
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: CustomSnackBarContent(errorText: e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 190.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome !',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Create an account to get started.',
                  style: TextStyle(fontSize: 16.0, color: Colors.black54),
                ),
                const SizedBox(height: 32.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),

                    // fillColor: Colors.white,
                    filled: true,
                    hintText: "Full Name",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),

                    // fillColor: Colors.white,
                    filled: true,
                    hintText: "Email address",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() => obscureText = !obscureText);
                      },
                      child: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 15.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    // fillColor: Colors.white,
                    filled: true,
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                  obscureText: obscureText,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),

                    // fillColor: Colors.white,
                    filled: true,
                    hintText: " Confirm Password",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _confirmPassword = value!;
                  },
                ),
                const SizedBox(height: 32.0),
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        height: 45.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          onPressed: _submit,
                          child: Text(
                            'SIGN UP'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account ?'),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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

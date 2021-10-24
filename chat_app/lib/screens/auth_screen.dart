import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/helpers/snackbar_message.dart';

import 'package:chat_app/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm({
    required String? email,
    required String? password,
    required String? username,
    required bool isLogin,
  }) async {
    UserCredential _userCredential;
    if (isLogin) {
      try {
        setState(() {
          _isLoading = true;
        });
        _userCredential = await _auth.signInWithEmailAndPassword(
          email: email as String,
          password: password as String,
        );
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (_error) {
        if (_error.code == 'user-not-found') {
          showError(
            errorMessage: 'No user found!',
            context: context,
          );
        } else if (_error.code == 'wrong-password') {
          showError(
            errorMessage: 'Wrong password!',
            context: context,
          );
        }
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      try {
        setState(() {
          _isLoading = true;
        });
        _userCredential = await _auth.createUserWithEmailAndPassword(
          email: email as String,
          password: password as String,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_userCredential.user!.uid)
            .set({
              'username': username,
              'email': email,
            })
            .then((_value) => showSuccess(
                  message: 'Signup Successful',
                  context: context,
                ))
            .catchError((_error) => showError(
                  errorMessage: 'Failed to add user: $_error',
                  context: context,
                ));
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (_error) {
        if (_error.code == 'weak-password') {
          showError(
            errorMessage: 'The password provided is too weak.',
            context: context,
          );
        } else if (_error.code == 'email-already-in-use') {
          showError(
            errorMessage: 'The account already exists for that email.',
            context: context,
          );
        }
        setState(() {
          _isLoading = false;
        });
      } catch (_error) {
        showError(
          errorMessage: _error as String,
          context: context,
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submitAuthForm: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}

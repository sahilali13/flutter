import 'dart:io';

import 'package:flutter/material.dart';

import 'package:chat_app/helpers/loading_indicator.dart';
import 'package:chat_app/helpers/snackbar_message.dart';
import 'package:chat_app/widgets/pickers/user_profile_picker.dart';

class AuthForm extends StatefulWidget {
  final bool _isLoading;

  final void Function({
    required String? email,
    required String? password,
    required String? username,
    required bool isLogin,
    required File? userProfileImage,
  }) _submitAuthForm;

  const AuthForm({submitAuthForm, isLoading, Key? key})
      : _submitAuthForm = submitAuthForm,
        _isLoading = isLoading,
        super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;

  String? _userEmail = '';
  String? _userName = '';
  String? _userPassword = '';
  File? _userProfileImage;

  void _imagePickFn(File? pickedImageFile) {
    _userProfileImage = pickedImageFile;
  }

  void _trySubmit() {
    final bool _isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();

    if (_userProfileImage == null && !_isLogin) {
      showError(
        errorMessage: 'Please pick an image.',
        context: context,
      );
      return;
    }

    if (_isValid) {
      _formKey.currentState!.save();
      widget._submitAuthForm(
        email: _userEmail!.trim(),
        password: _userPassword!.trim(),
        username: _userName!.trim(),
        isLogin: _isLogin,
        userProfileImage: _userProfileImage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin)
                    UserProfilePicker(
                      imagePickFn: _imagePickFn,
                    ),
                  TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    key: const ValueKey('email'),
                    validator: (_value) {
                      if (_value!.isEmpty || !_value.contains('@')) {
                        return 'Please enter a valid email address.';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (_value) {
                      _userEmail = _value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      key: const ValueKey('username'),
                      validator: (_value) {
                        if (_value!.isEmpty || _value.length < 4) {
                          return 'Please enter atleast 4 characters long.';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (_value) {
                        _userName = _value;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (_value) {
                      if (_value!.isEmpty || _value.length < 7) {
                        return 'Password must be atleast 7 characters long.';
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (_value) {
                      _userPassword = _value;
                    },
                  ),
                  const SizedBox(height: 12),
                  if (widget._isLoading)
                    const AdaptiveCircularProgressIndicator(),
                  if (!widget._isLoading)
                    ElevatedButton(
                      child: Text(_isLogin ? 'Login' : 'Sign up'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget._isLoading)
                    TextButton(
                      child: Text(
                          !_isLogin ? 'Existing User' : 'Create New Account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

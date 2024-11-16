import 'dart:io';

import 'package:chat_apps/shared/images.dart';
import 'package:chat_apps/shared/widget/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/size.dart';

///variable to initialize firbase auth
final _fireBase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticating = false;
  var _enteredUserName = '';

  void _isSubmit() async {
    final isValid = _form.currentState!.validate();

    // Check if it’s not login mode and an image hasn’t been selected
    if (!isValid || (!_isLogin && _selectedImage == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(!_isLogin && _selectedImage == null
            ? 'Please pick an image for signup.'
            : 'Please enter valid credentials.')),
      );
      return;
    }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        // Sign in with email and password
        final userCredential = await _fireBase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        print('Login credential $userCredential'); // Debugging
      } else {
        // Register with email and password
        final userCredential = await _fireBase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        // Upload image to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredential.user!.uid}.jpg');
        await storageRef.putFile(_selectedImage!);

        // Get download URL
        final imageUrl = await storageRef.getDownloadURL();
        //print('The image URL is $imageUrl');
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid)
        .set({
          'userName': _enteredUserName,
          'email': _enteredEmail,
          'image-url': imageUrl
        })
        ;
      }
    } on FirebaseException catch (error) {
      // Handle Firebase-specific errors
      ScaffoldMessenger.of(context).clearSnackBars();
      String errorMessage = 'Authentication Failed';
      if (error.code == 'email-already-in-use') {
        errorMessage = 'The email is already in use. Please try another one.';
      } else if (error.message != null) {
        errorMessage = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 30, bottom: 20, left: 20, right: 20),
                width: 200,
                child: const Image(image: AssetImage(Images.chatImage)),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!_isLogin)
                              UserImagePicker(
                                onPickImage: (pickedImage) {
                                  _selectedImage = pickedImage;
                                },
                              ),
                            TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid email';

                                  /// ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter a valid Email')));
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                              ),
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                            ),
                            if(!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'user name'

                              ),
                              enableSuggestions: false,
                              validator: (value){
                                if(value == null || value.isEmpty || value.trim().length < 4){
                                  return 'please enter a valid user name(at least 4 character)';

                                }
                                return null;

                              },
                              onSaved: (value){
                                _enteredUserName = value!;

                              },

                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.trim().length < 8 ||
                                    value.trim().isEmpty) {
                                  return 'Please enter a valid password with (at-least 8 characters)';
                                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter a valid Password it must be 8 character')));
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Password',
                              ),
                              obscureText: true,
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            ),
                            const SizedBox(
                                height: Sizes.spaceBtwButtonAndTextField),
                            if(_isAuthenticating)
                              const CircularProgressIndicator(),
                            if(!_isAuthenticating)
                            SizedBox(
                                width: double.infinity,

                                child: ElevatedButton(
                                  onPressed: () {
                                    _isSubmit();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                                  child: Text(_isLogin ? 'Login' : 'SignUp'),
                                )),
                            if(!_isAuthenticating)
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(_isLogin
                                    ? 'Create an account'
                                    : 'I already Have an account')),
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

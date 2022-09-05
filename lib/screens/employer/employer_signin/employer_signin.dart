import 'package:employ/authentication/authentication_methods.dart';
import 'package:employ/authentication/validator.dart';
import 'package:employ/constants/custom_colors.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/utilities/show_snackbar.dart';
import 'package:employ/widgets/custom_formfield.dart';
import 'package:employ/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../constants/custom_fonts.dart';
import '../../../constants/custom_icons.dart';
import '../../../widgets/custom_buttons.dart';

class EmployerSignIn extends StatefulWidget {
  const EmployerSignIn({Key? key}) : super(key: key);

  @override
  State<EmployerSignIn> createState() => _EmployerSignInState();
}

class _EmployerSignInState extends State<EmployerSignIn> {
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();



  @override
  void dispose() {
    // TODO: implement dispose
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.white,
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            NavigationMethods().toSelectUsersPage(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                      const Spacer(flex: 1),
                      CFont.primary(' Welcome ', color: CColor.black),
                      const Spacer(flex: 2),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CFont.small('Provide Login details to continue ',
                      color: CColor.black),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomFormField(
                      controller: _emailFieldController,
                      validator: validateEmail,
                      nameOfTextField: 'Company Email Address',
                      hintText: 'infofacebook@fb.com',
                      icon: Icons.mail_outline),
                  CustomFormField(
                    nameOfTextField: 'Password',
                    hintText: '........',
                    validator: validatePassword,
                    controller: _passwordFieldController,
                    icon: Icons.abc,
                    hidePassword: true,
                  ),
                  const Spacer(
                    flex: 1,
                  ),

                  // sign in button
                  CButton.primary(
                      text: 'Sign In',
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          bool shouldNavigate = await signIn(
                              _emailFieldController.text,
                              _passwordFieldController.text,
                              context);
                          shouldNavigate == true
                              ? NavigationMethods().toEmployerHomePage(context)
                              : showSnackBar(
                                  'Error: No internet connection OR Wrong password or mail',
                                  context,
                                  const Duration(milliseconds: 1000),
                                  CColor.red);
                        }
                      }),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            NavigationMethods()
                                .toEmployerForgotPassword(context);
                          },
                          child: CFont.secondary('Forgot Password ?',
                              color: CColor.red)),
                    ],
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // google sign in button
                  // CButton.secondaryIcon(
                  //     text: 'Sign in with Google',
                  //     icon: CIcon.google,
                  //     onPressed: () async {
                  //       bool isSignedIn = await signInByGoogle();
                  //       isSignedIn == true
                  //           ? NavigationMethods().toEmployerHomePage(context)
                  //           : showSnackBar('Sign in not successful', context,
                  //               const Duration(microseconds: 1), CColor.red);
                  //     }),
                  // const SizedBox(
                  //   height: 100,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

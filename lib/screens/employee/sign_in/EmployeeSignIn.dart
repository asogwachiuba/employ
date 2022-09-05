import 'package:employ/authentication/authentication_methods.dart';
import 'package:employ/authentication/validator.dart';
import 'package:employ/constants/custom_colors.dart';
import 'package:employ/models/user.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/utilities/show_snackbar.dart';
import 'package:employ/widgets/custom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/custom_fonts.dart';
import '../../../constants/custom_icons.dart';
import '../../../widgets/custom_buttons.dart';

class EmployeeSignIn extends StatefulWidget {
  const EmployeeSignIn({Key? key}) : super(key: key);

  @override
  State<EmployeeSignIn> createState() => _EmployeeSignInState();
}

class _EmployeeSignInState extends State<EmployeeSignIn> {
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
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
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        NavigationMethods().toPreviousPage(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Spacer(flex: 1),
                  CFont.primary('Ready to get started ?'),                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 10),
              CFont.small('Create an account or sign in',
                  color: CColor.black),
              CustomFormField(
                  controller: _emailFieldController,
                  validator: validateEmail,
                  nameOfTextField: 'Email Address',
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

              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        NavigationMethods().toEmployeeForgotPasswordPage(context);
                      },
                      child:
                      CFont.small('Forgot Password?', color: CColor.red)),
                  const SizedBox(width: 40,)
                ],
              ),

              const SizedBox(
                height: 40,
              ),

              // next button
              CButton.primary(
                  text: 'Sign In',
                  onPressed: () async {
                    if (_key.currentState!.validate()){
                      bool shouldNavigate = await signIn(
                          _emailFieldController.text,
                          _passwordFieldController.text, context);
                      shouldNavigate == true  // && userProfileProvider.validateUserIsAnEmployee() == true
                          ? {
                        NavigationMethods().toEmployeesHomePage(context)}
                          : showSnackBar('Error: check your internet connection OR \nWrong password or e-mail address', context, const Duration(milliseconds: 1000), CColor.red);
                    }

                    //saves user login info to keep user logged in
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    preferences.setStringList('userIdInfo', [_emailFieldController.text, _passwordFieldController.text,'employee']);
                  }),

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
              //           ? NavigationMethods().toEmployeesHomePage(context)
              //           : showSnackBar('Sign in not successful', context,
              //           const Duration(microseconds: 1), CColor.red);
              //     }),

              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CFont.small('Don\'t have an account ?', color: CColor.black),
                GestureDetector(
                    onTap: () {
                      NavigationMethods().toEmployeesSignUpPage(context);
                    } ,
                    child: CFont.small('  Sign Up', color: CColor.red)),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

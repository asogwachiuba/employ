import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/utilities/show_snackbar.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../authentication/authentication_methods.dart';
import '../../../authentication/validator.dart';
import '../../../constants/custom_icons.dart';
import '../../../provider/users_profile_provider.dart';
import '../../../widgets/custom_formfield.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProfileProvider =
        Provider.of<UsersProfileProvider>(context, listen: false);
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
                  CFont.primary('Create Account ', color: CColor.black),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 10),
              CFont.small('Provide account details in few minutes ',
                  color: CColor.black),
              CustomFormField(
                  controller: _nameController,
                  nameOfTextField: 'Full Name',
                  hintText: 'Asogwa Chi-uba',
                  icon: Icons.person_outline_rounded),
              CustomFormField(
                  controller: _emailController,
                  validator: validateEmail,
                  nameOfTextField: 'Email Address',
                  hintText: 'infofacebook@fb.com',
                  icon: Icons.mail_outline),
              CustomFormField(
                nameOfTextField: 'Phone Number',
                hintText: '+2348103982330',
                controller: _phoneNumberController,
                icon: Icons.phone,
                hidePassword: false,
              ),
              CustomFormField(
                nameOfTextField: 'User Location',
                hintText: 'Street,City.E.g Abakaliki Lane, Enugu',
                controller: _locationController,
                icon: Icons.location_city_outlined,
                hidePassword: false,
              ),
              CustomFormField(
                nameOfTextField: 'Password',
                hintText: '************',
                validator: validatePassword,
                controller: _passwordController,
                icon: Icons.abc,
                hidePassword: true,
              ),
              const SizedBox(
                height: 40,
              ),

              // next button
              CButton.primary(
                  text: 'Sign Up',
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      bool shouldNavigate = await signUp(
                          _emailController.text, _passwordController.text, context);
                      shouldNavigate == true
                          ? {
                              userProfileProvider.createCompanyProfileInfo(
                                  _nameController.text,
                                  _phoneNumberController.text,
                                  _locationController.text),
                              NavigationMethods().toEmployeesSignInPage(context)
                            }
                          : showSnackBar('Sign up not successful',
                              context, const Duration(milliseconds: 800), CColor.red);
                    }
                  }),
              // const SizedBox(
              //   height: 10,
              // ),
              // Center(child: CFont.darkSecondary('OR')),

              const SizedBox(
                height: 20,
              ),

              // google sign in button
              // CButton.secondaryIcon(
              //     text: 'Sign up with Google',
              //     icon: CIcon.google,
              //     onPressed: () async {
              //       bool isSignedIn = await signInByGoogle();
              //       isSignedIn == true
              //           ? {
              //         userProfileProvider.createCompanyProfileInfo(
              //             FirebaseAuth
              //                 .instance.currentUser?.displayName ?? 'Update your name',
              //             FirebaseAuth
              //                 .instance.currentUser?.tenantId ??'Update your location',
              //             FirebaseAuth
              //                 .instance.currentUser?.phoneNumber ?? 'Update phone number'),
              //         NavigationMethods().toEmployeesHomePage(context),
              //       }
              //           : showSnackBar('Sign up not successful', context,
              //           const Duration(microseconds: 1), CColor.red);
              //     }),
              // const SizedBox(
              //   height: 20,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CFont.small('Already have an account?', color: CColor.black),
                  GestureDetector(
                      onTap: () {
                        NavigationMethods().toEmployeesSignInPage(context);
                      },
                      child: CFont.small('Login', color: CColor.red)),
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

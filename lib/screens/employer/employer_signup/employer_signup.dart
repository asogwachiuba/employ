import 'package:employ/authentication/authentication_methods.dart';
import 'package:employ/authentication/validator.dart';
import 'package:employ/constants/custom_colors.dart';
import 'package:employ/provider/company_profile_provider.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/widgets/custom_formfield.dart';
import 'package:employ/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../constants/custom_fonts.dart';
import '../../../constants/custom_icons.dart';
import '../../../utilities/show_snackbar.dart';
import '../../../widgets/custom_buttons.dart';

class EmployerSignUp extends StatefulWidget {
  const EmployerSignUp({Key? key}) : super(key: key);

  @override
  State<EmployerSignUp> createState() => _EmployerSignUpState();
}

class _EmployerSignUpState extends State<EmployerSignUp> {
  final TextEditingController _companyPhonenumberFieldController =
      TextEditingController();
  final TextEditingController _companyNameFieldController =
      TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _companyLocationFieldController =
      TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    _companyLocationFieldController.dispose();
    _companyNameFieldController.dispose();
    _companyPhonenumberFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final companyProfileProvider =
        Provider.of<CompanyProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: CColor.white,
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
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
                    controller: _companyNameFieldController,
                    nameOfTextField: 'Company Name',
                    hintText: 'Facebook',
                    icon: Icons.person_outline_rounded),
                CustomFormField(
                    controller: _emailFieldController,
                    validator: validateEmail,
                    nameOfTextField: 'Company Email Address',
                    hintText: 'infofacebook@fb.com',
                    icon: Icons.mail_outline),
                CustomFormField(
                  nameOfTextField: 'Phone Number',
                  hintText: '+2348103982330',
                  controller: _companyPhonenumberFieldController,
                  icon: Icons.phone,
                  hidePassword: false,
                ),
                CustomFormField(
                  nameOfTextField: 'Company Location',
                  hintText: 'Street,City.E.g Abakaliki Lane, Enugu',
                  controller: _companyLocationFieldController,
                  icon: Icons.location_city_outlined,
                  hidePassword: false,
                ),
                CustomFormField(
                  nameOfTextField: 'Password',
                  hintText: '************',
                  validator: validatePassword,
                  controller: _passwordFieldController,
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
                            _emailFieldController.text,
                            _passwordFieldController.text,
                            context);
                        shouldNavigate == true
                            ? {
                                companyProfileProvider.createCompanyProfileInfo(
                                    _companyNameFieldController.text,
                                    _companyLocationFieldController.text,
                                    _companyPhonenumberFieldController.text),
                                context.go('/employer_signin')
                              }
                            : Navigator.pop(context);
                      }
                    }),
                // const SizedBox(
                //   height: 20,
                // ),
                //
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
                //               companyProfileProvider.createCompanyProfileInfo(
                //                   FirebaseAuth
                //                       .instance.currentUser?.displayName ?? 'Update your name',
                //                   FirebaseAuth
                //                       .instance.currentUser?.tenantId ??'Update your location',
                //                   FirebaseAuth
                //                       .instance.currentUser?.phoneNumber ?? 'Update phone number'),
                //               NavigationMethods().toEmployerHomePage(context),
                //             }
                //           : showSnackBar('Sign up not successful', context,
                //               const Duration(microseconds: 1), CColor.red);
                //     }),
                // const SizedBox(
                //   height: 20,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CFont.small('Already have an account?',
                        color: CColor.black),
                    GestureDetector(
                        onTap: () {
                          context.go('/employer_signin');
                        },
                        child: CFont.small('Login', color: CColor.red)),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

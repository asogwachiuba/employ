
import 'package:employ/provider/company_profile_provider.dart';
import 'package:employ/provider/job_posts_provider.dart';
import 'package:employ/provider/users_profile_provider.dart';
import 'package:employ/screens/employee/create_resume/create_resume.dart';
import 'package:employ/screens/employee/edit_resume/contact_details/edit_resume_contact_details.dart';
import 'package:employ/screens/employee/edit_resume/education/edit_resume_education.dart';
import 'package:employ/screens/employee/edit_resume/education/education_edit_form.dart';
import 'package:employ/screens/employee/edit_resume/interest/edit_resume_interest.dart';
import 'package:employ/screens/employee/edit_resume/interest/interest_edit_form.dart';
import 'package:employ/screens/employee/edit_resume/language/edit_resume_language.dart';
import 'package:employ/screens/employee/edit_resume/language/language_edit_form.dart';
import 'package:employ/screens/employee/edit_resume/objectives/edit_resume_objectives.dart';
import 'package:employ/screens/employee/edit_resume/skills/edit_resume_skills.dart';
import 'package:employ/screens/employee/edit_resume/skills/skills_edit_form.dart';
import 'package:employ/screens/employee/edit_resume/work_experience/edit_resume_work_experience.dart';
import 'package:employ/screens/employee/edit_resume/work_experience/work_experience_edit_form.dart';
import 'package:employ/screens/employee/import_resume/import_resume.dart';
import 'package:employ/screens/employee/login/password_entry_page.dart';
import 'package:employ/screens/employee/login/sign_in_page.dart';
import 'package:employ/screens/employee/map/map_page.dart';
import 'package:employ/screens/employee/settings/settings_page.dart';
import 'package:employ/screens/employee/signup_pages/signup_page.dart';
import 'package:employ/screens/employer/employer_home.dart';
import 'package:employ/screens/employer/employer_home_page/employer_home_page.dart';
import 'package:employ/screens/employer/employer_job_post/employer_job_post.dart';
import 'package:employ/screens/employer/employer_profile_info/employer_profile_info.dart';
import 'package:employ/screens/employer/employer_signin/employer_signin.dart';
import 'package:employ/screens/employer/employer_signup/employer_signup.dart';
import 'package:employ/screens/forgot_password/forgot_password.dart';
import 'package:employ/screens/forgot_password/reset_password.dart';
import 'package:employ/screens/forgot_password/reset_password_success.dart';
import 'package:employ/screens/select_user/select_user.dart';
import 'package:employ/screens/select_user_type.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//'package:employ/utilities/navigation.dart'
//'package:employ/screens/employee/login/password_entry_page.dart'
//lib/main.dart
//lib/screens/employer/employer_signin/employer_signin.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List<String>? userInfo = preferences.getStringList('userIdInfo');
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CompanyProfileProvider>(
          lazy: false,
          create: (_) => CompanyProfileProvider(),
        ),

        ChangeNotifierProvider<JobPostsProvider>(
          lazy: false,
          create: (_) => JobPostsProvider(),
        ),
        ChangeNotifierProvider<UsersProfileProvider>(
          lazy: false,
          create: (_) => UsersProfileProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        title: 'Employ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => SelectUserType()
      ),
      GoRoute(
        path: '/create_resume',
        builder: (BuildContext context, GoRouterState state) =>
        const CreateResume(),
      ),
      GoRoute(
        path: '/edit_resume_contact_details',
        builder: (BuildContext context, GoRouterState state) =>
        const EditResumeContactDetails(),
      ),
      GoRoute(
        path: '/edit_resume_education',
        builder: (BuildContext context, GoRouterState state) =>
        const EditResumeEducation(),
      ),
      GoRoute(
        path: '/education_edit_form',
        builder: (BuildContext context, GoRouterState state) =>
        const EducationEditForm(),
      ),
      GoRoute(
        path: '/edit_resume_interest',
        builder: (BuildContext context, GoRouterState state) =>
        const EditResumeInterest(),
      ),
      GoRoute(
        path: '/interest_edit_form',
        builder: (BuildContext context, GoRouterState state) =>
        const InterestEditForm(),
      ),
      GoRoute(
        path: '/edit_resume_language',
        builder: (BuildContext context, GoRouterState state) =>
        const EditResumeLanguage(),
      ),
      GoRoute(
        path: '/language_edit_form',
        builder: (BuildContext context, GoRouterState state) =>
        const LanguageEditForm(),
      ),
      GoRoute(
        path: '/edit_resume_objectives',
        builder: (BuildContext context, GoRouterState state) =>
        const EditResumeObjectives(),
      ),
      GoRoute(
        path: '/edit_resume_skills',
        builder: (BuildContext context, GoRouterState state) =>
        const EditResumeSkills(),
      ),
      GoRoute(
        path: '/skills_edit_form',
        builder: (BuildContext context, GoRouterState state) =>
        const SkillsEditForm(),
      ),
      GoRoute(
        path: '/edit_resume_work_experience',
        builder: (BuildContext context, GoRouterState state) =>
        const EditResumeWorkExperience(),
      ),
      GoRoute(
        path: '/work_experience_edit_form',
        builder: (BuildContext context, GoRouterState state) =>
        const WorkExperienceEditForm(),
      ),
      GoRoute(
        path: '/forgot_password',
        builder: (BuildContext context, GoRouterState state) =>
            ForgotPassword(),
      ),
      GoRoute(
        path: '/reset_password',
        builder: (BuildContext context, GoRouterState state) =>
        const ResetPassword(),
      ),
      GoRoute(
        path: '/reset_password_success',
        builder: (BuildContext context, GoRouterState state) =>
        const ResetPasswordSuccess(),
      ),
      GoRoute(
        path: '/import_resume',
        builder: (BuildContext context, GoRouterState state) =>
        const ImportResume(),
      ),
      GoRoute(
        path: '/password_entry_page',
        builder: (BuildContext context, GoRouterState state) =>
            PasswordEntryPage(),
      ),
      GoRoute(
        path: '/employer_home',
        builder: (BuildContext context, GoRouterState state) =>
        const EmployerHome(),
      ),
      GoRoute(
        path: '/employer_home_page',
        builder: (BuildContext context, GoRouterState state) =>
        const EmployerHomePage(),
      ),
      GoRoute(
        path: '/employer_profile_info',
        builder: (BuildContext context, GoRouterState state) =>
        const EmployerProfileInfo(),
      ),
      GoRoute(
        path: '/employer_signin',
        builder: (BuildContext context, GoRouterState state) =>
            EmployerSignIn(),
      ),
      GoRoute(
        path: '/employer_signup',
        builder: (BuildContext context, GoRouterState state) =>
        const EmployerSignUp(),
      ),
      GoRoute(
        path: '/employer_job_post',
        builder: (BuildContext context, GoRouterState state) =>
        const EmployerJobPost(),
      ),
      GoRoute(
        path: '/sign_in_page',
        builder: (BuildContext context, GoRouterState state) =>
        const SigninPage(),
      ),
      GoRoute(
        path: '/select_user',
        builder: (BuildContext context, GoRouterState state) =>
        const SelectUser(),
      ),
      GoRoute(
        path: '/settings_page',
        builder: (BuildContext context, GoRouterState state) =>
        const SettingsPage(),
      ),
      GoRoute(
        path: '/signup_page',
        builder: (BuildContext context, GoRouterState state) => SignupPage(),
      ),
    ],
  );
}

import 'package:employ/models/employees_model.dart';
import 'package:employ/models/job_application_model.dart';
import 'package:employ/models/job_post_model.dart';
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
import 'package:employ/screens/employee/home_page/home_page.dart';
import 'package:employ/screens/employee/job_details/job_details.dart';
import 'package:employ/screens/employee/map/map_page.dart';
import 'package:employ/screens/employee/settings/settings_page.dart';
import 'package:employ/screens/employee/sign_in/EmployeeSignIn.dart';
import 'package:employ/screens/employee/signup_pages/signup_page.dart';
import 'package:employ/screens/employee/submit_resume/submit_resume.dart';
import 'package:employ/screens/employer/check_applicants_profile/applicants_profile.dart';
import 'package:employ/screens/employer/employer_home_page/employer_home_page.dart';
import 'package:employ/screens/employer/employer_job_applications/submitted_job_applications.dart';
import 'package:employ/screens/employer/employer_job_applications/view_job_application.dart';
import 'package:employ/screens/employer/employer_job_post/employer_job_post.dart';
import 'package:employ/screens/employer/employer_signin/employer_signin.dart';
import 'package:employ/screens/employer/employer_signup/employer_signup.dart';
import 'package:employ/screens/forgot_password/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:go_router/go_router.dart';

import '../screens/employee/submit_resume/submit_resume.dart';

class NavigationMethods {
  //navigate to select user
  toSelectUsersPage(BuildContext context) {
    context.go('/');
  }

  // to logout
  toLogOut(BuildContext context) {
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    context.go('/select_user');

  }

  // to previous screen
  toPreviousPage(BuildContext context) {
    Navigator.pop(context);
  }

  //EMPLOYERS NAVIGATION METHODS

  // navigate to employers sign up page
  toEmployersSignUpPage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EmployerSignUp(),
        ));
  }

// navigate to employer job post page
  toEmployerJobPostPage(BuildContext context, JobPostModel? jobPostToBeEdited) {
    Navigator.pop(context);
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EmployerHomePage(),
        ));
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: EmployerJobPost(
            jobPostModel: jobPostToBeEdited,
          ),
        ));
  }

  // navigate to employers sign in page
  toEmployerSignInPage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EmployerSignIn(),
        ));
  }

  // navigate to employers forgot password page
  toEmployerForgotPassword(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: ForgotPassword(),
        ));
  }

  // navigate to employers home page
  toEmployerHomePage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EmployerHomePage(),
        ));
  }

  // navigate to employer submitted application page
  toEmployerSubmittedJobApplicationsPage(
      BuildContext context, String jobPostId) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: SubmittedJobApplication(jobPostId: jobPostId),
        ));
  }

  // navigate to view application page
  toViewApplicationPage(BuildContext context,
      JobApplicationModel jobApplication, String jobPostId) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: ViewJobApplicationPage(
            selectedJobApplication: jobApplication,
            jobPostId: jobPostId,
          ),
        ));
  }

  // navigate to applicants profile page
  toViewApplicantsProfilePage(
      BuildContext context, EmployeeProfileModel applicantProfileInfo) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: ApplicantsProfile(
            applicantProfile: applicantProfileInfo,
          ),
        ));
  }

  // EMPLOYEES NAVIGATION METHODS

  // navigate to employees sign in page
  toEmployeesSignInPage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EmployeeSignIn(),
        ));
  }

  // navigate to employees sign up page
  toEmployeesSignUpPage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: SignupPage(),
        ));
  }

  // navigate to employees home page
  toEmployeesHomePage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const HomePage(),
        ));
  }

  // navigate to employees settings page
  toEmployeeSettingsPage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const SettingsPage(),
        ));
  }

  // navigate to employees forgot password page
  toEmployeeForgotPasswordPage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: ForgotPassword(),
        ));
  }

  // navigate to reset password page
  toResetPasswordPage(BuildContext context) {
    context.go('/reset_password');
  }

  // navigate to password successful page
  toPasswordSuccessfulPage(BuildContext context) {
    context.go('/reset_password_success');
  }

  // navigate to create resume page
  toCreateResumePage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const CreateResume(),
        ));
  }

  // navigate to edit resume contact details page
  toEditResumeContactDetailsPage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EditResumeContactDetails(),
        ));
  }

  // navigate to edit resume education
  toEditResumeEducation(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EditResumeEducation(),
        ));
  }

  // navigate to education edit form
  toEducationEditForm(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EducationEditForm(),
        ));
  }

  // navigate to edit resume interest
  toEditResumeInterest(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EditResumeInterest(),
        ));
  }

  // navigate to interest edit form
  toInterestEditForm(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const InterestEditForm(),
        ));
  }

  // navigate to edit resume language
  toEditResumeLanguage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EditResumeLanguage(),
        ));
  }

  // navigate to language edit form
  toLanguageEditForm(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const LanguageEditForm(),
        ));
  }

  // navigate to edit resume objectives
  toEditResumeObjectives(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EditResumeObjectives(),
        ));
  }

  // navigate to edit resume skills
  toEditResumeSkills(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EditResumeSkills(),
        ));
  }

  // navigate to skills edit form
  toSkillsEditForm(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const SkillsEditForm(),
        ));
  }

  // navigate to edit resume work experience
  toEditResumeWorkExperience(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const EditResumeWorkExperience(),
        ));
  }

  // navigate to work experience edit form
  toWorkExperienceEditForm(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const WorkExperienceEditForm(),
        ));
  }

// navigate to map to see location of company
  toMap(BuildContext context, String jobLocation, String employeeLocation) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: MapPage(
            employeeLocation: employeeLocation,
            jobLocation: jobLocation,
          ),
        ));
  }

  // navigates to see selected job details
  toJobDetails(BuildContext context, JobPostModel _selectedJobPost) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: JobDetailsPage(
            selectedJobPost: _selectedJobPost,
          ),
        ));
  }

  // navigates to submit resume page
  toSubmitResumePage(
      BuildContext context, String jobPostId, String jobLocation) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: SubmitResume(
            jobPostId: jobPostId,
            jobLocation: jobLocation,
          ),
        ));
  }
}

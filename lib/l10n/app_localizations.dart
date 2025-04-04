import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ta.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
    Locale('hi'),
    Locale('ta')
  ];

  /// No description provided for @authTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to TaskNotify'**
  String get authTitle;

  /// No description provided for @authSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up or login below to manage your project, task and your productivity'**
  String get authSubTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @appleLogin.
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get appleLogin;

  /// No description provided for @googleLogin.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get googleLogin;

  /// No description provided for @continueWithEmail.
  ///
  /// In en, this message translates to:
  /// **'or continue with email'**
  String get continueWithEmail;

  /// No description provided for @userNameHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get userNameHintText;

  /// No description provided for @emailHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHintText;

  /// No description provided for @passwordHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHintText;

  /// No description provided for @confirmPasswordHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter your confirm password'**
  String get confirmPasswordHintText;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgetPassword;

  /// No description provided for @forgetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPasswordTitle;

  /// No description provided for @forgetPasswordSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email account to reset password'**
  String get forgetPasswordSubTitle;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @backToLoginText.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLoginText;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// No description provided for @proverb.
  ///
  /// In en, this message translates to:
  /// **'Proverb'**
  String get proverb;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @taskNameHintText.
  ///
  /// In en, this message translates to:
  /// **'Task name'**
  String get taskNameHintText;

  /// No description provided for @taskDescriptionHintText.
  ///
  /// In en, this message translates to:
  /// **'Task description'**
  String get taskDescriptionHintText;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get myAccount;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal info'**
  String get personalInfo;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// No description provided for @yourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Your email address'**
  String get yourEmailAddress;

  /// No description provided for @appInfo.
  ///
  /// In en, this message translates to:
  /// **'App Info'**
  String get appInfo;

  /// No description provided for @taskNotifyAppInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Tasify - Smart Task Management & Productivity'**
  String get taskNotifyAppInfoDescription;

  /// No description provided for @devInfo.
  ///
  /// In en, this message translates to:
  /// **'Dev Info'**
  String get devInfo;

  /// No description provided for @devInfoSubTitle.
  ///
  /// In en, this message translates to:
  /// **'About the Developer'**
  String get devInfoSubTitle;

  /// No description provided for @yourLanguage.
  ///
  /// In en, this message translates to:
  /// **'Your Language'**
  String get yourLanguage;

  /// No description provided for @yourLanguageSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Change your preferred language'**
  String get yourLanguageSubTitle;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutSubTitle.
  ///
  /// In en, this message translates to:
  /// **'You will be signed out from your account'**
  String get logoutSubTitle;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get passwordMinLength;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm password is required'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @nameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 3 characters long'**
  String get nameMinLength;

  /// No description provided for @noArchiveFound.
  ///
  /// In en, this message translates to:
  /// **'No archive found'**
  String get noArchiveFound;

  /// No description provided for @taskName.
  ///
  /// In en, this message translates to:
  /// **'Task name'**
  String get taskName;

  /// No description provided for @taskDescription.
  ///
  /// In en, this message translates to:
  /// **'Task description'**
  String get taskDescription;

  /// No description provided for @dataRange.
  ///
  /// In en, this message translates to:
  /// **'Pick a date range'**
  String get dataRange;

  /// No description provided for @notificationAlert.
  ///
  /// In en, this message translates to:
  /// **'Notification alert'**
  String get notificationAlert;

  /// No description provided for @taskStatus.
  ///
  /// In en, this message translates to:
  /// **'Task Status'**
  String get taskStatus;

  /// No description provided for @pendingStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingStatus;

  /// No description provided for @inProgressStatus.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgressStatus;

  /// No description provided for @completedStatus.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedStatus;

  /// No description provided for @overDueStatus.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overDueStatus;

  /// No description provided for @taskPriority.
  ///
  /// In en, this message translates to:
  /// **'Task Priority'**
  String get taskPriority;

  /// No description provided for @taskPriorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get taskPriorityHigh;

  /// No description provided for @taskPriorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get taskPriorityMedium;

  /// No description provided for @taskPriorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get taskPriorityLow;

  /// No description provided for @notificationOn.
  ///
  /// In en, this message translates to:
  /// **'Notification On'**
  String get notificationOn;

  /// No description provided for @notificationOff.
  ///
  /// In en, this message translates to:
  /// **'Notification Off'**
  String get notificationOff;

  /// No description provided for @archiveTask.
  ///
  /// In en, this message translates to:
  /// **'ArchiveTask'**
  String get archiveTask;

  /// No description provided for @taskNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Task name is required'**
  String get taskNameRequired;

  /// No description provided for @taskNameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Task name must be at least 3 characters long'**
  String get taskNameMinLength;

  /// No description provided for @taskDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Task description is required'**
  String get taskDescriptionRequired;

  /// No description provided for @taskDescriptionMinLength.
  ///
  /// In en, this message translates to:
  /// **'Task description must be at least 10 characters long'**
  String get taskDescriptionMinLength;

  /// No description provided for @notificationRequired.
  ///
  /// In en, this message translates to:
  /// **'Notification selection is required'**
  String get notificationRequired;

  /// No description provided for @dateRangeRequired.
  ///
  /// In en, this message translates to:
  /// **'Date range selection is required'**
  String get dateRangeRequired;

  /// No description provided for @taskStatusRequired.
  ///
  /// In en, this message translates to:
  /// **'Task status selection is required'**
  String get taskStatusRequired;

  /// No description provided for @taskPriorityRequired.
  ///
  /// In en, this message translates to:
  /// **'Task priority selection is required'**
  String get taskPriorityRequired;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'The email address is already in use.'**
  String get emailAlreadyInUse;

  /// No description provided for @operationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Email/password accounts are not enabled.'**
  String get operationNotAllowed;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak.'**
  String get weakPassword;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'This user account has been disabled.'**
  String get userDisabled;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email.'**
  String get userNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get wrongPassword;

  /// No description provided for @tooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many login attempts. Please try again later.'**
  String get tooManyRequests;

  /// No description provided for @accountExistsWithDifferentCredential.
  ///
  /// In en, this message translates to:
  /// **'This email is already associated with another sign-in method.'**
  String get accountExistsWithDifferentCredential;

  /// No description provided for @invalidCredential.
  ///
  /// In en, this message translates to:
  /// **'The credential received is invalid.'**
  String get invalidCredential;

  /// No description provided for @networkRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get networkRequestFailed;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unexpectedError;

  /// No description provided for @appleSignInNotSupported.
  ///
  /// In en, this message translates to:
  /// **'Apple Sign-In is only supported on iOS and macOS.'**
  String get appleSignInNotSupported;

  /// No description provided for @appleSignInNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'Apple sign-in is not enabled for this Firebase project.'**
  String get appleSignInNotEnabled;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again.'**
  String get networkError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again.'**
  String get unknownError;

  /// No description provided for @onBoardingTitleFirst.
  ///
  /// In en, this message translates to:
  /// **'Stay Organized & Boost Productivity'**
  String get onBoardingTitleFirst;

  /// No description provided for @onBoardingSubTitleFirst.
  ///
  /// In en, this message translates to:
  /// **'Effortlessly manage your tasks, collaborate with your team, and track progress in one place. With smart scheduling, AI-powered assistance, and real-time updates, Tasify helps you stay ahead of deadlines and achieve more! 🚀'**
  String get onBoardingSubTitleFirst;

  /// No description provided for @onBoardingTitleSecond.
  ///
  /// In en, this message translates to:
  /// **'Organize, Plan & Achieve'**
  String get onBoardingTitleSecond;

  /// No description provided for @onBoardingSubTitleSecond.
  ///
  /// In en, this message translates to:
  /// **'Stay on top of your tasks with smart planning, effortless collaboration, and real-time progress tracking. With Tasify, managing work has never been easier—boost productivity and accomplish more every day! ✅'**
  String get onBoardingSubTitleSecond;

  /// No description provided for @onBoardingTitleThird.
  ///
  /// In en, this message translates to:
  /// **'Seamless Collaboration & Real-time Updates'**
  String get onBoardingTitleThird;

  /// No description provided for @onBoardingSubTitleThird.
  ///
  /// In en, this message translates to:
  /// **'Work together effortlessly with real-time notifications and updates. Stay in sync with your team anytime, anywhere.'**
  String get onBoardingSubTitleThird;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied'**
  String get permissionDenied;

  /// No description provided for @documentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Document not found'**
  String get documentNotFound;

  /// No description provided for @serviceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Service unavailable'**
  String get serviceUnavailable;

  /// No description provided for @addTaskToastSuccess.
  ///
  /// In en, this message translates to:
  /// **'Task added successfully'**
  String get addTaskToastSuccess;

  /// No description provided for @addTaskToastFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to add task. Please try again.'**
  String get addTaskToastFailure;

  /// No description provided for @madeWith.
  ///
  /// In en, this message translates to:
  /// **'Made with '**
  String get madeWith;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **' from '**
  String get from;

  /// No description provided for @imran.
  ///
  /// In en, this message translates to:
  /// **'Imran B'**
  String get imran;

  /// No description provided for @languagePreferenceSuccessToast.
  ///
  /// In en, this message translates to:
  /// **'Language preference saved successfully!'**
  String get languagePreferenceSuccessToast;

  /// No description provided for @languagePreferenceFailureToast.
  ///
  /// In en, this message translates to:
  /// **'Please select a language before continuing.'**
  String get languagePreferenceFailureToast;

  /// No description provided for @authSignInSuccessToast.
  ///
  /// In en, this message translates to:
  /// **'Sign In successfully'**
  String get authSignInSuccessToast;

  /// No description provided for @authSignUpSuccessToast.
  ///
  /// In en, this message translates to:
  /// **'Sign Up successfully'**
  String get authSignUpSuccessToast;

  /// No description provided for @authForgetPasswordSentSuccessToast.
  ///
  /// In en, this message translates to:
  /// **'Password sent successfully'**
  String get authForgetPasswordSentSuccessToast;

  /// No description provided for @userLanguagePreferenceSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get userLanguagePreferenceSubTitle;

  /// No description provided for @tamil.
  ///
  /// In en, this message translates to:
  /// **'Tamil'**
  String get tamil;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @userLanguagePreferenceSettings.
  ///
  /// In en, this message translates to:
  /// **'Your language preference can be changed at any time in Settings.'**
  String get userLanguagePreferenceSettings;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @forgetPasswordSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your mail'**
  String get forgetPasswordSuccessTitle;

  /// No description provided for @forgetPasswordSuccessSubTitle.
  ///
  /// In en, this message translates to:
  /// **'We have sent a password recover\ninstructions to your email'**
  String get forgetPasswordSuccessSubTitle;

  /// No description provided for @goToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Go to Sign In'**
  String get goToSignIn;

  /// No description provided for @skipLater.
  ///
  /// In en, this message translates to:
  /// **'Skip, I\'ll confirm later'**
  String get skipLater;

  /// No description provided for @continueLanguage.
  ///
  /// In en, this message translates to:
  /// **'Confirm Language'**
  String get continueLanguage;

  /// No description provided for @languagePreferenceSettingsAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Language Preference'**
  String get languagePreferenceSettingsAppBarTitle;

  /// No description provided for @languagePreferenceSettingsSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language for a better experience.'**
  String get languagePreferenceSettingsSubTitle;

  /// No description provided for @changeLanguagePreferenceAlertDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Language Preference'**
  String get changeLanguagePreferenceAlertDialogTitle;

  /// No description provided for @changeLanguagePreferenceAlertDialogSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to change the language preference?\nThis action cannot be undone.'**
  String get changeLanguagePreferenceAlertDialogSubTitle;

  /// No description provided for @cancelDialogText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelDialogText;

  /// No description provided for @confirmDialogText.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmDialogText;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'TaskNotify'**
  String get appName;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @tapAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Tap again to exit!'**
  String get tapAgainToExit;

  /// No description provided for @authSignOutToastSuccess.
  ///
  /// In en, this message translates to:
  /// **'Sign out successfully'**
  String get authSignOutToastSuccess;

  /// No description provided for @languagePreferenceSettingFailureToast.
  ///
  /// In en, this message translates to:
  /// **'Please select a language and press Continue to apply the changes.'**
  String get languagePreferenceSettingFailureToast;

  /// No description provided for @updateLanguagePreferenceSuccessToast.
  ///
  /// In en, this message translates to:
  /// **'Language preference updated successfully'**
  String get updateLanguagePreferenceSuccessToast;

  /// No description provided for @updateLanguagePreferenceFailureToast.
  ///
  /// In en, this message translates to:
  /// **'Language preference update failed. Please try again.'**
  String get updateLanguagePreferenceFailureToast;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @haveANiceDay.
  ///
  /// In en, this message translates to:
  /// **'Have a nice day.'**
  String get haveANiceDay;

  /// No description provided for @chipTaskCompleted.
  ///
  /// In en, this message translates to:
  /// **'Task Completed'**
  String get chipTaskCompleted;

  /// No description provided for @chipTaskInProgress.
  ///
  /// In en, this message translates to:
  /// **'Task InProgress'**
  String get chipTaskInProgress;

  /// No description provided for @chipTaskOverDue.
  ///
  /// In en, this message translates to:
  /// **'Task OverDue'**
  String get chipTaskOverDue;

  /// No description provided for @internetFailureToast.
  ///
  /// In en, this message translates to:
  /// **'Oops! It looks like you\'re offline. Please check your connection.'**
  String get internetFailureToast;

  /// No description provided for @internetSuccessToast.
  ///
  /// In en, this message translates to:
  /// **'You are online now.'**
  String get internetSuccessToast;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr', 'hi', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
    case 'hi': return AppLocalizationsHi();
    case 'ta': return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

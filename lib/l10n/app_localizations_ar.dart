// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get authTitle => 'مرحباً بكم في إشعار المهمة';

  @override
  String get authSubTitle => 'سجل أو قم بتسجيل الدخول أدناه لإدارة مشروعك ومهمتك وإنتاجيتك';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signUp => 'اشتراك';

  @override
  String get appleLogin => 'تسجيل الدخول باستخدام Apple';

  @override
  String get googleLogin => 'تسجيل الدخول باستخدام جوجل';

  @override
  String get continueWithEmail => 'أو الاستمرار بالبريد الإلكتروني';

  @override
  String get userNameHintText => 'أدخل اسمك';

  @override
  String get emailHintText => 'أدخل بريدك الإلكتروني';

  @override
  String get passwordHintText => 'أدخل كلمة المرور الخاصة بك';

  @override
  String get confirmPasswordHintText => 'أدخل كلمة المرور الخاصة بك للتأكيد';

  @override
  String get forgetPassword => 'نسيت كلمة المرور؟';

  @override
  String get forgetPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get forgetPasswordSubTitle => 'أدخل حساب بريدك الإلكتروني لإعادة تعيين كلمة المرور';

  @override
  String get continueText => 'يكمل';

  @override
  String get backToLoginText => 'العودة إلى تسجيل الدخول';
}

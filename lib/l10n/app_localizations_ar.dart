// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get welcomeBack => 'أهلاً بعودتك!';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get password => 'كلمة المرور';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get intracore => 'IntraCore';

  @override
  String get employeePortal => 'بوابة الموظفين';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get menuHome => 'الرئيسية';

  @override
  String get menuTimeClock => 'تسجيل الوقت';

  @override
  String get menuTimesheets => 'بطاقات الوقت';

  @override
  String get menuApprovals => 'الموافقات';

  @override
  String get menuMore => 'القائمة';

  @override
  String get Dashboard => 'لوحة التحكم';

  @override
  String get menuOrganization => 'المؤسسة';

  @override
  String get menuTimeOff => 'إجازة / وقت راحة';

  @override
  String get menuOverview => 'نظرة عامة';

  @override
  String get menuAccount => 'الحساب';

  @override
  String get menuPersonalSettings => 'الإعدادات الشخصية';

  @override
  String get menuHelp => 'مساعدة';

  @override
  String get menuSupport => 'الدعم';

  @override
  String get trackedHours => 'الساعات المتتبعة';

  @override
  String get worked => 'العمل';

  @override
  String get breaks => 'الاستراحات';

  @override
  String get overtime => 'العمل الإضافي';

  @override
  String get workedHours => 'ساعات العمل';

  @override
  String get breaksLabel => 'الاستراحات';

  @override
  String get overtimeHours => 'ساعات إضافية';

  @override
  String get payrollNote => 'لا تشمل ساعات الرواتب المُدخلة يدويًا';

  @override
  String get whosInOut => "من في الداخل / الخارج";

  @override
  String get inLabel => "داخل";

  @override
  String get breakLabel => "استراحة";

  @override
  String get outLabel => "خارج";
  @override
  String noDataFor(String title) => 'لا يوجد $title';
  @override
  String get projects => 'مشاريع';

  @override
  String get activities => 'أنشطة';
  @override
  String get notifications => 'الإشعارات';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get accountControl => 'إدارة الحساب';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get version => 'الإصدار';
}

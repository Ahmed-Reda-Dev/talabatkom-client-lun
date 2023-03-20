import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lun_talabaty_app/Features/home/drawer/zoom_drawer.dart';
import 'package:lun_talabaty_app/Features/onboarding_screen.dart';
import 'package:lun_talabaty_app/Features/register&login/login_screen.dart';
import 'package:lun_talabaty_app/core/login&register/cubit/cubit.dart';
import 'package:lun_talabaty_app/share/cubit/cubit.dart';
import 'package:lun_talabaty_app/share/locale/cache_helper.dart';
import 'package:lun_talabaty_app/share/remote/dio_helper.dart';
import 'package:lun_talabaty_app/share/simple_bloc_observer.dart';
import 'package:lun_talabaty_app/splash_screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;

import 'Features/notification/init_notification.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await NotificationController.initializeLocalNotifications(debug: true);
  await NotificationController.initializeRemoteNotifications(debug: true);
  await NotificationController.getInitialNotificationAction();

  await CacheHelper.init();
  NotificationController();
  String? lang = CacheHelper.getData(key: 'lang');

  Api.init(
    headers: {
      'lang': lang,
    },
  );
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');
  Widget widget;

  if (onBoarding != null) {
    if (token != null) {
      widget = const ZDrawer();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(startWidget: widget));
  Bloc.observer = SimpleBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({required this.startWidget, super.key});

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(create: (context) {
          return AppCubit()..getProfileData();
        }),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, child) => ResponsiveWrapper.builder(
                    child,
                    maxWidth: 1200,
                    minWidth: 480,
                    defaultScale: true,
                    breakpoints: [
                      const ResponsiveBreakpoint.resize(480, name: MOBILE),
                      const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                      const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                    ],
                    background: Container(color: const Color(0xFFF5F5F5)),
                  ),
              supportedLocales: flc.supportedLocales.map((e) => Locale(e)),
              locale: EasyLocalization.of(context)?.locale,
              localizationsDelegates: const [
                CountryLocalizations.delegate,
                //context.localizationDelegates.first,
              ],
              fallbackLocale: const Locale('en', 'US'),
              theme: ThemeData(
                primarySwatch: Colors.orange,
                useMaterial3: true,
              ),
              home: AnimatedSplashScreen(
                splash: const SplashScreen(),
                splashIconSize: 55.w,
                nextScreen: startWidget,
                splashTransition: SplashTransition.fadeTransition,
                backgroundColor: HexColor('#F5504C'),
                duration: 3000,
              ));
        },
      ),
    );
  }
}

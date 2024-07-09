import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minute_minder/modules/chats/test_chat_screen.dart';
import 'package:minute_minder/shared/components/constant.dart';
import 'package:minute_minder/modules/Social_layout/social_layout_screen.dart';
import 'package:minute_minder/modules/home/social_home_screen.dart';
import 'package:minute_minder/modules/login/new_login_screen.dart';
import 'package:minute_minder/modules/on_boarding/liquid_on_boarding_screen.dart';
import 'package:minute_minder/shared/app_mode_cubit/mode_cubit.dart';
import 'package:minute_minder/shared/app_mode_cubit/mode_states.dart';
import 'package:minute_minder/shared/components/constant.dart';
import 'package:minute_minder/shared/network/local/cache_helper.dart';
import 'package:minute_minder/shared/network/remote/dio_helper.dart';
import 'package:minute_minder/shared/social_cubit/bloc_observer.dart';
import 'package:minute_minder/shared/social_cubit/cubit.dart';
import 'package:minute_minder/shared/styles/themes.dart';
import 'package:minute_minder/test.dart';



void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  darkCopy = CacheHelper.getData(key: 'isDark');


  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');


  print(uId);


  Widget startWidget;

  if (onBoarding != null)
  {
    if (uId != null)
    {
      startWidget = const SocialLayoutScreen();
    }
    else
    {
      startWidget = SocialLoginNewScreen();
    }
  }
  else
  {
    startWidget = const LiquidOnBoarding();
  }

  runApp(
      MyApp(
        isDark: darkCopy,
        startWidget: startWidget,
      ));
}
class MyApp extends StatelessWidget
{
  MyApp({super.key, this.isDark, required this.startWidget});

  bool? isDark;
  Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context)
            {
              return ModeCubit()..changeAppMode(fromShared: isDark);
            }
        ),
        BlocProvider(
            create: (BuildContext context)
            {
              return SocialCubit();
            }
        ),
      ],
      child: BlocConsumer<ModeCubit, ModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ModeCubit.get(context).isDark?ThemeMode.light:ThemeMode.dark, //اعكس
            debugShowCheckedModeBanner: false,
            home:startWidget ,// startWidget  or  MyApppppp()
          );
        },
      ),
    );
  }
}

// to arabic commands:

// flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
// flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys

// to add a package
// flutter pub add firebase_core

// flutter clean
// flutter pub get

// Firebase Mail
// user1@gmail.com
// 123456
// user2@gmail.com
// 123456
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/styles/styles.dart';
import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/onboarding/onboarding.dart';
import 'modules/shop_login/cubit/cubit.dart';
import 'modules/shop_login/shop_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  late bool onBoarding;
  token = CacheHelper.getData(key: 'token');
  Widget onStart;
  if (CacheHelper.getData(key: 'onBoarding') == null) {
    CacheHelper.saveData(key: 'onBoarding', value: false);
    onBoarding = CacheHelper.getData(key: 'onBoarding');
    onStart = const OnBoardingScreen();
  } else {
    onBoarding = CacheHelper.getData(key: 'onBoarding');
    if (onBoarding) {
      if (token != null) {
        onStart = const ShopLayout();
      } else {
        onStart = ShopLogin();
      }
    } else {
      onStart = const OnBoardingScreen();
    }
  }
  runApp(MyApp(onStart));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget onBoarding;

  const MyApp(this.onBoarding, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginShopCubit()),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getSettingsData())
      ],
      child: MaterialApp(
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          theme: lightTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: onBoarding),
    );
  }
}

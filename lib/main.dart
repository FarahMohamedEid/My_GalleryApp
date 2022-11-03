import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery_app/features/home/home_screen.dart';
import 'core/logic/cubit/app_cubit.dart';
import 'core/logic/cubit/app_states.dart';
import 'core/network/local/cache_helper.dart';
import 'core/network/remote/dio_helpers/dio_helper.dart';
import 'core/utilities/resources/bloc_observer.dart';
import 'features/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    late bool goHome;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()
        ),
      ],
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          if(CacheHelper.getData(key: 'goHome') != null && CacheHelper.getData(key: 'goHome') == true){
            goHome = true;
          }else{
            goHome = false;
          }
          return MaterialApp(
            title: 'My Gallery App',
            debugShowCheckedModeBanner: false,
            home: goHome ? const HomeScreen() : const LoginScreen(),
          );
        }
      ),
    );
  }
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Register/cubit/cubit.dart';
import 'package:social_app/conistants/conistants.dart';
import 'package:social_app/network/shared_prefrunce.dart';
import 'package:social_app/social_cubit/cubit.dart';
import 'package:social_app/social_cubit/states.dart';
import 'package:social_app/social_layout.dart';
import 'package:social_app/social_login/cubit/cubit.dart';
import 'package:social_app/social_login/social_login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();

  Widget widget;
  uId = CashHelper.getData(key: 'uId');

  if(uId != null)
    {
      widget = SocialLayout();
    }
  else
    {
      widget = SocialLoginScreen();
    }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({
    @required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => SocialCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialLoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialRegisterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserDate()..getsPosts(),
        ),
      ],
      child: BlocBuilder<SocialCubit, SocialStates>(
        builder: (context, state) {
          return MaterialApp(
            home: startWidget,
          );
        },
      ),
    );
  }
}
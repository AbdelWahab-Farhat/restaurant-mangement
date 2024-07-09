import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/Features/Auth/login/login_screen.dart';
import 'package:restaurant_management/Features/Profile/profile_cubit.dart';
import 'package:restaurant_management/Features/Profile/side_profile_screens/order_history/order_history_cubit.dart';
import 'package:restaurant_management/Features/auth/signup/signup_cubit.dart';
import 'package:restaurant_management/Features/auth/login/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_management/Features/home/menus/menu_cubit.dart';
import 'package:restaurant_management/Features/root/root_client.dart';
import 'package:restaurant_management/services/FirebaseServices/fireStore_service.dart';
import 'package:restaurant_management/utility/size_config.dart';
import 'Blocs/order_bloc/order_bloc.dart';
import 'Blocs/reservation_bloc/reservation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().initSizeConfig(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OrderHistoryCubit(),),
        BlocProvider(create: (context) => ReservationBloc(),),
        BlocProvider(create: (context) => OrderBloc(),),
        BlocProvider(create: (context) => MenuCubit(FirebaseService()),),
        BlocProvider(create: (context) => LoginCubit(firebaseAuth: FirebaseAuth.instance),),
        BlocProvider(create: (context) => SignupCubit(FirebaseFirestore.instance,FirebaseAuth.instance,),),
        BlocProvider(create: (context) => ProfileCubit(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Root();
            }
            else if (!snapshot.hasData) {
              return const LoginScreen();
            }
            else {
              return  LoginScreen();
            }
          },
        ),
      ),
    );
  }
}

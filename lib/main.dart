import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'Features/menu/presentation/viewModel/price_cubit/price_cubit.dart';
import 'Features/root/presentation/views/root.dart';
import 'core/widgets/custom_loading_widget.dart';
import 'features/Reservation/presentation/viewModel/reservation_cubit/reservation_cubit.dart';
import 'features/auth/presentation/views/login_view.dart';
import 'features_admin/admin_home/presentation/views/home_admin_view.dart';
import 'models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Features/Profile/profile_cubit.dart';
import '../../Features/Profile/side_profile_screens/order_history/order_history_cubit.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/presentation/viewModel/login_cubit/login_cubit.dart';
import '../../features/auth/presentation/viewModel/sign_up_cubit/signup_cubit.dart';
import '../../features/menu/data/repo/menu_repo_impl.dart';
import '../../features/menu/presentation/viewModel/menu_cubit/menu_cubit.dart';
import '../../features_admin/admin_menu/add_menu_item/add_menu_item_cubit.dart';
import '../../features_admin/admin_menu/remove_menu_item/remove_menu_item_cubit.dart';
import 'services/FirebaseServices/fireStore_service.dart';
import 'utility/size_config.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoveMenuItemCubit>(
          create: (context) => RemoveMenuItemCubit(),
        ),
        BlocProvider<AddMenuItemCubit>(
          create: (context) => AddMenuItemCubit(),
        ),
        BlocProvider<OrderHistoryCubit>(
          create: (context) => OrderHistoryCubit(),
        ),
        BlocProvider<MenuCubit>(
          create: (context) =>
              MenuCubit(
                MenuRepoImpl(store: FirebaseFirestore.instance),
              ),
        ),
        BlocProvider<LoginCubit>(
          create: (context) =>
              LoginCubit(),
        ),
        BlocProvider<SignupCubit>(
          create: (context) =>
              SignupCubit(AuthRepoImpl(
                auth: FirebaseAuth.instance,
                store: FirebaseFirestore.instance,
              )),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<PriceCubit>(
          create: (context) => PriceCubit(),
        ),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().initSizeConfig(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReservationCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<auth.User?>(
          stream: auth.FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingWidget();
            } else if (snapshot.hasData) {
              return FutureBuilder<Role>(
                future: FirebaseService().checkUserRole(snapshot.data!.uid),
                builder: (context, roleSnapshot) {
                  if (roleSnapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(body: CustomLoadingWidget());
                  } else if (roleSnapshot.hasData) {
                    if (roleSnapshot.data == Role.admin) {
                      return const HomeAdminView();
                    }
                    else {
                      return const Root();
                    }
                  } else {
                    return const LoginView();
                  }
                },
              );
            } else {
              return const LoginView();
            }
          },
        ),
      ),
    );
  }
}

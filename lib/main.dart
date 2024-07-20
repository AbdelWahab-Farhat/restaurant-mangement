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
    // providers for state (from state to other)
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
    // init Size Config  (give us screen width and height)
    SizeConfig().initSizeConfig(context);
    // providers for state (from state to other)
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
        // check if user is login or not and keep listen to changes if user logoff or login
        // depend on user state at will lead you to different screen
        home: StreamBuilder<auth.User?>(
          stream: auth.FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // when data is loading show custom loading view(page)
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingWidget();
              // when the stream (has data) => user.
            } else if (snapshot.hasData) {
              // future builder for check the user role if admin or user
              return FutureBuilder<Role>(
                // sending user id to check user role to check user role
                future: FirebaseService().checkUserRole(snapshot.data!.uid),
                builder: (context, roleSnapshot) {
                  // wait data
                  if (roleSnapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(body: CustomLoadingWidget());
                  } else if (roleSnapshot.hasData) {
                    if (roleSnapshot.data == Role.admin) {
                      // if role is admin go to admin view(page)
                      return const HomeAdminView();
                    }
                    else {
                      // if role is customer (go to customer home page)
                      return const Root();
                    }
                  } else {
                    // if user not login and no data  show loginView
                    return const LoginView();
                  }
                },
              );
              // if user not login and no data  show loginView
            } else {
              return const LoginView();
            }
          },
        ),
      ),
    );
  }
}

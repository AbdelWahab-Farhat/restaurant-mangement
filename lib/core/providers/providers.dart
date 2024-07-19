import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Features/Profile/profile_cubit.dart';
import '../../Features/Profile/side_profile_screens/order_history/order_history_cubit.dart';
import '../../Features/Reservation/presentation/viewModel/reservation_cubit/reservation_cubit.dart';
import '../../Features/menu/presentation/viewModel/price_cubit/price_cubit.dart';
import '../../features/Order/data/repo/order_repo_impl.dart';
import '../../features/Order/presentation/viewModel/order_cubit.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/presentation/viewModel/login_cubit/login_cubit.dart';
import '../../features/auth/presentation/viewModel/sign_up_cubit/signup_cubit.dart';
import '../../features/menu/data/repo/menu_repo_impl.dart';
import '../../features/menu/presentation/viewModel/menu_cubit/menu_cubit.dart';
import '../../features/menu/presentation/viewModel/menu_detail_item/menu_detail_item_cubit.dart';
import '../../features_admin/admin_menu/add_menu_item/add_menu_item_cubit.dart';
import '../../features_admin/admin_menu/remove_menu_item/remove_menu_item_cubit.dart';
import '../../main.dart';



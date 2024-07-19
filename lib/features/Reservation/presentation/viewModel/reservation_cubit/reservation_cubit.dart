import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_management/models/user/customer.dart';

import '../../../../../models/reservation.dart';
import '../../../data/repo/reservation_repo.dart';
import '../../../data/repo/reservation_repo_impl.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final Resev reservationRepo = Resev(store: FirebaseFirestore.instance, auth: FirebaseAuth.instance);
  ReservationCubit()
      : super(ReservationInitial());

  Future<void> fetchReservations() async {
    var result = await reservationRepo.fetchUserReservations();
    result.fold(
      (l) => emit(ReservationFailure(errMessage:l.errMessage)),
      (r) => emit(ReservationSuccess(customer: r)),
    );
  }
}

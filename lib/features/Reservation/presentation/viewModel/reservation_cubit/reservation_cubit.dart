import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../../models/user/customer.dart';
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

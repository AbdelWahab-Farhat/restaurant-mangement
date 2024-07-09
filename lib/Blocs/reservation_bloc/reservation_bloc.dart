import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_management/services/FirebaseServices/fireStore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/reservation.dart';
import '../../models/user/customer.dart';
import '../../models/user/user.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc() : super(ReservationInitial()) {
    on<AddReservationEvent>((event, emit) async {
    });
    on<LoadReservationEvent>((event, emit) async {
        emit(ReservationLoading());
        List<Reservation>? revs = await FirebaseService().getCustomerReservation();
        final sp = await SharedPreferences.getInstance();
        sp.remove('user');
        User? user = await FirebaseService().getUser();
        if (user is Customer) {
          Customer customer = user;
          if (revs != null) {
            emit(ReservationSuccess(reservations: revs, customer: customer));
          }
          else {
            emit(ReservationError(massage: 'No Reservation At the Moment'));
          }
        }
        else {
          emit(ReservationError(massage: 'Cant Fetch Reservation At the Moment'));
        }
    });
  }
}

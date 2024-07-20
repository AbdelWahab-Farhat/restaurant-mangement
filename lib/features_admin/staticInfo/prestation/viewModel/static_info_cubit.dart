import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/employee.dart';
import '../../../../models/order/order.dart';
import '../../data/repo/static_info_repo.dart';

part 'static_info_state.dart';

class StaticInfoCubit extends Cubit<StaticInfoState> {
  final StaticInfoRepo repo;
   List<Employee> employees = [];
   List<Order> orders = [];
  StaticInfoCubit(this.repo) : super(StaticInfoInitial());


  Future<void> fetchEmployees ()async{
    emit(StaticInfoLoading());
    var result = await repo.fetchEmployees();
    result.fold((l) => emit(StaticInfoFailure(l.errMessage)), (remployess) {
      employees = remployess;
      emit(StaticInfoSuccess());
    },);
  }
  Future<void> fetchOrders () async {
    emit(StaticInfoLoading());
    var result = await repo.fetchOrders();
    result.fold((l) => emit(StaticInfoFailure(l.errMessage)), (rorders) {
      orders = rorders;
      emit(StaticInfoSuccess());
    },);
  }



  double bills (List<Employee> employeess){
    double bill = 0;
    for (var employee in employeess) {
      bill+=employee.employeeSalary;
    }
    return bill;
  }
  double totalIncome(List<Order> orders) {
    double income = 0;
    for (var order in orders) {
      if (order.orderStatus == OrderStatus.completed) {
        income+=order.totalPrice;
      }
    }
    return income;
  }
  int numberOfDailyOrders(List<Order> orders) {
    int dailyOrders = 0;
    final today = DateTime.now().toLocal();
    for (var order in orders) {
      final orderDate = order.orderDate.toLocal();
      if (orderDate.year == today.year &&
          orderDate.month == today.month &&
          orderDate.day == today.day) {
        dailyOrders++;
      }
    }
    return dailyOrders;
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_management/models/order/orderItem.dart';

import '../../../data/repo/menu_repo.dart';

part 'menu_detail_item_state.dart';

class MenuDetailItemCubit extends Cubit<MenuDetailItemState> {
  final MenuRepo menuRepo;
  MenuDetailItemCubit(this.menuRepo) : super(MenuDetailItemInitial());

  Future<void> addItem(OrderItem orderItem) async {
    emit(MenuDetailItemLoading());
    var result = await menuRepo.addItemFromMenuToOrder(orderItem);
    result.fold(
      (failure) => emit(MenuDetailItemFailure(errMessage: failure.errMessage)),
      (successMessage) => emit(MenuDetailItemSuccess(successMessage: successMessage)),
    );
  }
}

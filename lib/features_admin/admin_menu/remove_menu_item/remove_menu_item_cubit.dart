import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/item.dart';
import '../../../services/FirebaseServices/fireStore_service.dart';

part 'remove_menu_item_state.dart';

class RemoveMenuItemCubit extends Cubit<RemoveMenuItemState> {
  List<Item>? items;
  RemoveMenuItemCubit() : super(RemoveMenuItemInitial());



  Future<void> initItems () async {
    items = [];
    emit(RemoveMenuItemLoading());
    items = await FirebaseService().fetchItems();
    if (items == null) {
      emit(RemoveMenuItemFailure());
    }
    else {
      emit(RemoveMenuItemSuccess(menuItems: items!));
    }
  }
  Future<void> removeItem(Item item) async {
    emit(RemoveMenuItemLoading());
    bool result = await FirebaseService().removeMenuItem(item);
    if (result) {
      await initItems();
      emit(RemoveMenuItemSuccess(menuItems: items!));

    }
    else {
      emit(RemoveMenuItemFailure());
    }
  }
}

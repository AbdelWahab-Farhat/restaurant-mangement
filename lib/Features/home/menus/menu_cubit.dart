import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_management/models/menu/menu.dart';
import 'package:restaurant_management/services/FirebaseServices/fireStore_service.dart';

import '../../../utility/helpers.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final FirebaseService fireStoreService;

  MenuCubit(this.fireStoreService) : super(MenuInitial()) {
    fetchMenus();
  }

  Future<void> fetchMenus() async {
    try {
      emit(MenuLoading());
      List<Menu>? menus = await fireStoreService.getMenus();
      if (menus == null) {
        emit(MenuError(message:'Weak Internet, Cannot Load Images.'));
      }
      else {
        _shuffleItems(menus);
        emit(MenuLoaded(menus: menus));
      }
    } catch (e) {
      emit(MenuError(message:'Weak Internet, Cannot Load Images.'));
    }
  }

  void _shuffleItems(List<Menu> menus) {
    for (var item in menus) {
      item.menuItems?.shuffle();
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../models/menu/menu.dart';
import '../../../data/repo/menu_repo.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuRepo menuRepo;
  MenuCubit(this.menuRepo) : super(MenuInitial());

  Future<void> fetchMenus() async {
    var result = await menuRepo.fetchMenus();
    result.fold(
          (failure) => emit(MenuFailure(message: failure.errMessage)),
          (menus) => emit(MenuSuccess(menus: menus)),
    );
  }

}

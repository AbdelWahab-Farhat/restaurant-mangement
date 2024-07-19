import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../models/addon.dart';
part  'price_state.dart';




class PriceCubit extends Cubit<PriceState> {
  PriceCubit() : super(PriceInitial());
  List<Addon> addons = [];

  void updateAddons(List<Addon> selectedAddons) {
    addons.clear();
    addons = selectedAddons;
    emit(PickAddonUpdated(addons));
  }
}

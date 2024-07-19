part of 'price_cubit.dart';




@immutable
abstract class PriceState {}

class PriceInitial extends PriceState {}

class PickAddonUpdated extends PriceState {
  final List<Addon> addons;

  PickAddonUpdated(this.addons);
}

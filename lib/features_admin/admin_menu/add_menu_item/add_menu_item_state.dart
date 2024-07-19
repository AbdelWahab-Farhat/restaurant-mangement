part of 'add_menu_item_cubit.dart';

@immutable
sealed class AddMenuItemState {}

final class AddMenuItemInitial extends AddMenuItemState {}
final class AddMenuItemFailure extends AddMenuItemState {
  String message;
  AddMenuItemFailure({required this.message});
}

final class AddMenuItemSuccess extends AddMenuItemState {}
final class AddMenuItemLoading extends AddMenuItemState {}

// comps
final class PhotoChanged extends AddMenuItemState {}
final class AddonChanged extends AddMenuItemState {}
final class DropMenuChanged extends AddMenuItemState {}
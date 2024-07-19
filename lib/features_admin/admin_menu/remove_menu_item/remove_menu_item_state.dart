part of 'remove_menu_item_cubit.dart';

@immutable
sealed class RemoveMenuItemState {}

final class RemoveMenuItemInitial extends RemoveMenuItemState {}
final class RemoveMenuItemFailure extends RemoveMenuItemState {}
final class RemoveMenuItemSuccess extends RemoveMenuItemState {
  List<Item> menuItems;
  RemoveMenuItemSuccess({required this.menuItems});
}
final class RemoveMenuItemLoading extends RemoveMenuItemState {}
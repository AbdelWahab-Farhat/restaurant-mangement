part of 'menu_detail_item_cubit.dart';

@immutable
sealed class MenuDetailItemState {}

final class MenuDetailItemInitial extends MenuDetailItemState {}
final class MenuDetailItemLoading extends MenuDetailItemState {}
final class MenuDetailItemSuccess extends MenuDetailItemState {
  final String successMessage;
  MenuDetailItemSuccess({required this.successMessage});
}
final class MenuDetailItemFailure extends MenuDetailItemState {
  final String errMessage;

  MenuDetailItemFailure({required this.errMessage});
}


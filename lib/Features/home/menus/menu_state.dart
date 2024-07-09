part of 'menu_cubit.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<Menu> menus;
  MenuLoaded({required this.menus});
}

class MenuError extends MenuState {
  final String message;
  MenuError({required this.message});
}

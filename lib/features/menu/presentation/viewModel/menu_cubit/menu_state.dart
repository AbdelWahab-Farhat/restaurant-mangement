part of 'menu_cubit.dart';


@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuSuccess extends MenuState {
  final List<Menu> menus;
  MenuSuccess({required this.menus});
}

class MenuFailure extends MenuState {
  final String message;
  MenuFailure({required this.message});
}


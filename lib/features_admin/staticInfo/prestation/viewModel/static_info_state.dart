part of 'static_info_cubit.dart';

@immutable
sealed class StaticInfoState {}

final class StaticInfoInitial extends StaticInfoState {}

final class StaticInfoLoading extends StaticInfoState {}

final class StaticInfoFailure extends StaticInfoState {
  final String errorMessage;

  StaticInfoFailure(this.errorMessage);
}

final class StaticInfoSuccess extends StaticInfoState {


  StaticInfoSuccess();
}

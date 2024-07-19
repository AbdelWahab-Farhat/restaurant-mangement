
abstract class Failure {
  final String errMessage;

  Failure({required this.errMessage});
}

class FailureService extends Failure{
  FailureService({required super.errMessage});
}
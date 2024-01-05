part of 'cubit.dart';

sealed class AcceptUserState extends Equatable {
  const AcceptUserState();

  @override
  List<Object> get props => [];
}

//
final class AcceptUserInitial extends AcceptUserState {}

final class AcceptUserLoading extends AcceptUserState {}

final class AcceptUserSuccess extends AcceptUserState {}

final class AcceptUserFailure extends AcceptUserState {}

final class AcceptUserTimeOut extends AcceptUserState {}

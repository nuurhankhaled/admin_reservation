part of 'cubit.dart';

sealed class AddAdminState extends Equatable {
  const AddAdminState();

  @override
  List<Object> get props => [];
}

//
final class AddAdminInitial extends AddAdminState {}

final class AddAdminLoading extends AddAdminState {}

final class AddAdminSuccess extends AddAdminState {}

final class AddAdminFailure extends AddAdminState {}

final class AddAdminTimeOut extends AddAdminState {}

part of 'cubit.dart';

sealed class AddCashierState extends Equatable {
  const AddCashierState();

  @override
  List<Object> get props => [];
}

//
final class AddCahierInitial extends AddCashierState {}

final class AddCahierLoading extends AddCashierState {}

final class AddCahierSuccess extends AddCashierState {}

final class AddCahierFailure extends AddCashierState {}

final class AddCahierTimeOut extends AddCashierState {}

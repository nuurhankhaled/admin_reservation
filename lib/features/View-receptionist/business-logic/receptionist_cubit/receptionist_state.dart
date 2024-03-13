part of 'receptionist_cubit.dart';

abstract class ReceptionistState {}

class ReceptionistsInitial extends ReceptionistState {}

class GetReceptionistsLoading extends ReceptionistState {}

class GetReceptionistsSuccess extends ReceptionistState {}

class GetReceptionistsFailure extends ReceptionistState {}

class GetReceptionistsTimeOut extends ReceptionistState {}

class ChangePasswordLoading extends ReceptionistState {}

class ChangePasswordSuccess extends ReceptionistState {}

class ChangePasswordError extends ReceptionistState {}

part of 'admin_cubit.dart';

abstract class AdminState {}

class UsersInitial extends AdminState {}

class GetAdminsLoading extends AdminState {}

class GetAdminsSuccess extends AdminState {}

class GetAdminsFailure extends AdminState {}

class DeleteAdminLoading extends AdminState {}

class DeleteAdminSuccess extends AdminState {}

class DeleteAdminFailure extends AdminState {}

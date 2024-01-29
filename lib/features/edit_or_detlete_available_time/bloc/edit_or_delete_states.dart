part of 'edit_or_delete_cubit.dart';

abstract class EditOrDeleteStates {}

class UsersInitial extends EditOrDeleteStates {}

class GetALLAvailableLoading extends EditOrDeleteStates {}

class GetALLAvailableSuccess extends EditOrDeleteStates {}

class GetALLAvailableFailure extends EditOrDeleteStates {}

class DeleteALLAvailableLoading extends EditOrDeleteStates {}

class DeleteALLAvailableSuccess extends EditOrDeleteStates {}

class DeleteALLAvailableFailure extends EditOrDeleteStates {}

class EditAvailableLoading extends EditOrDeleteStates {}

class EditAvailableSuccess extends EditOrDeleteStates {}

class EditAvailableFailure extends EditOrDeleteStates {}

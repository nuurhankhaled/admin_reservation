part of 'additional_options_cubit.dart';

abstract class AdditionalOptionsState {}

class AdditionalOptionsInitial extends AdditionalOptionsState {}

class AddAdditionalOptionsLoading extends AdditionalOptionsState {}

class AddAdditionalOptionsSuccess extends AdditionalOptionsState {}

class AddAdditionalOptionsFailure extends AdditionalOptionsState {}

class AdditionalOptionsTimeOut extends AdditionalOptionsState {}

class GetAdditionalOptionsLoading extends AdditionalOptionsState {}

class GetAdditionalOptionsSuccess extends AdditionalOptionsState {}

class GetAdditionalOptionsFailure extends AdditionalOptionsState {}

class DeleteAdditionalOptionsLoading extends AdditionalOptionsState {}

class DeleteAdditionalOptionsSuccess extends AdditionalOptionsState {}

class DeleteAdditionalOptionsFailure extends AdditionalOptionsState {}

class EditAdditionalOptionsLoading extends AdditionalOptionsState {}

class EditAdditionalOptionsSuccess extends AdditionalOptionsState {}

class EditAdditionalOptionsFailure extends AdditionalOptionsState {}

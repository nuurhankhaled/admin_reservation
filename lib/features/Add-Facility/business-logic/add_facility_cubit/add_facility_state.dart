part of 'add_facility_cubit.dart';

abstract class AddFacilityState {}

class AddFacilityInitial extends AddFacilityState {}

class AddFacilityLoading extends AddFacilityState {}

class AddFacilitySuccess extends AddFacilityState {}

class AddFacilityFailure extends AddFacilityState {}

class AddFacilityTimeOut extends AddFacilityState {}

class PickImageSuccessState extends AddFacilityState {}

class PickImageErrorState extends AddFacilityState {
  final String error;

  PickImageErrorState(this.error);
}

class UpdateImageLoading extends AddFacilityState {}

class UpdateImageSuccess extends AddFacilityState {}

class UpdateImageError extends AddFacilityState {}

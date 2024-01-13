part of 'reservations_cubit.dart';

abstract class ReservationsState {}

class ReservationsInitial extends ReservationsState {}

class GetReservationsLoading extends ReservationsState {}

class GetReservationsSuccess extends ReservationsState {}

class GetReservationsFailure extends ReservationsState {}

class GetReservationsTimeOut extends ReservationsState {}

class AcceptReservationLoading extends ReservationsState {}

class AcceptReservationSuccess extends ReservationsState {}

class AcceptReservationFailure extends ReservationsState {}

class DeclineReservationLoading extends ReservationsState {}

class DeclineReservationSuccess extends ReservationsState {}

class DeclineReservationFailure extends ReservationsState {}

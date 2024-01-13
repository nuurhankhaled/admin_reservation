part of 'item_cubit.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class AddItemLoading extends ItemState {}

class AddItemSuccess extends ItemState {}

class AddItemFailure extends ItemState {}

class AddCategoryTimeOut extends ItemState {}

class PickImageSuccessState extends ItemState {}

class PickImageErrorState extends ItemState {
  final String error;

  PickImageErrorState(this.error);
}

class UpdateImageLoading extends ItemState {}

class UpdateImageSuccess extends ItemState {}

class UpdateImageError extends ItemState {}

class GetItemsLoading extends ItemState {}

class GetItemsSuccess extends ItemState {}

class GetItemsFailure extends ItemState {}

class DeleteItemLoading extends ItemState {}

class DeleteItemSuccess extends ItemState {}

class DeleteItemFailure extends ItemState {}

class EditItemLoading extends ItemState {}

class EditItemSuccess extends ItemState {}

class EditItemFailure extends ItemState {}

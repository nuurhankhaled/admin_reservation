part of 'category_cubit.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class AddCategoryLoading extends CategoryState {}

class AddCategorySuccess extends CategoryState {}

class AddCategoryFailure extends CategoryState {}

class AddCategoryTimeOut extends CategoryState {}

class PickImageSuccessState extends CategoryState {}

class PickImageErrorState extends CategoryState {
  final String error;

  PickImageErrorState(this.error);
}

class UpdateImageLoading extends CategoryState {}

class UpdateImageSuccess extends CategoryState {}

class UpdateImageError extends CategoryState {}

class GetCategoriesLoading extends CategoryState {}

class GetCategoriesSuccess extends CategoryState {}

class GetCategoriesFailure extends CategoryState {}

class GetCategoriesTimeOut extends CategoryState {}

class EditCategoryLoading extends CategoryState {}

class EditCategorySuccess extends CategoryState {}

class EditCategoryFailure extends CategoryState {}

class DeleteCategoryLoading extends CategoryState {}

class DeleteCategorySuccess extends CategoryState {}

class DeleteCategoryFailure extends CategoryState {}

class GetCategoryItemsLoading extends CategoryState {}

class GetCategoryItemsSuccess extends CategoryState {}

class GetCategoryItemsFailure extends CategoryState {}

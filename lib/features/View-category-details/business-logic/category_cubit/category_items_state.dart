part of 'category_items_cubit.dart';

abstract class CategoryItemsState {}

class CategoryItemsInitial extends CategoryItemsState {}

class GetCategoryItemsLoading extends CategoryItemsState {}

class GetCategoryItemsSuccess extends CategoryItemsState {}

class GetCategoryItemsFailure extends CategoryItemsState {}

class GetCategoryItemsTimeOut extends CategoryItemsState {}

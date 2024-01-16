import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservationapp_admin/features/View-categories/presentation/widgets/edit-category-dialog.dart';

class ViewCategoriesScreen extends StatelessWidget {
  const ViewCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is DeleteCategorySuccess) {
          CategoryCubit.get(context).getCategories();
        }
      },
      builder: (context, state) {
        var categoryCubit = CategoryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
              title: const Text("المنشآت",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Padding(
                padding: EdgeInsets.only(right: 50.w),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              )),
          body: (state is GetCategoriesLoading)
              ? const CustomLoadingIndicator()
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 8.h,
                    ),
                    itemCount: categoryCubit.categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.pushNamed(Routes.viewCategoryDetailsScreen,
                              arguments: categoryCubit.categories[index].name!);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.blueGrey,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                CachedNetworkImage(
                                  imageUrl:
                                      categoryCubit.categories[index].image!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 200,
                                    height: 128,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          categoryCubit.categories[index].name!,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.sp,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BlocProvider(
                                                      create: (context) =>
                                                          CategoryCubit(),
                                                      child: EditCategoryDialog(
                                                        id: categoryCubit
                                                            .categories[index]
                                                            .id
                                                            .toString(),
                                                        name: categoryCubit
                                                            .categories[index]
                                                            .name!,
                                                        image: categoryCubit
                                                            .categories[index]
                                                            .image!,
                                                      ));
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                              size: 20,
                                            )),
                                      ),
                                      SizedBox(width: 10.w),
                                      Container(
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              categoryCubit.deleteCategory(
                                                  id: categoryCubit
                                                      .categories[index].id!);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 20,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}

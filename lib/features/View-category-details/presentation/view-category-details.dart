import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/features/View-category-details/business-logic/category_cubit/category_items_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewCategoryDetails extends StatelessWidget {
  String title;
  ViewCategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    CategoryItemsCubit.get(context).getCategoryItems(categoryName: title);
    return BlocConsumer<CategoryItemsCubit, CategoryItemsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CategoryItemsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Padding(
                padding: EdgeInsets.only(right: 50.w),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              )),
          body: (state is GetCategoryItemsLoading)
              ? const CustomLoadingIndicator()
              : (cubit.categorieItems.isEmpty)
                  ? const Center(
                      child: Text("لا يوجد أغراض متاحة",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800)))
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 10.h,
                        ),
                        itemCount: cubit.categorieItems.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // context.pushNamed(Routes.viewFacilityDetailsScreen);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.blueGrey,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10.h),
                                    CachedNetworkImage(
                                      imageUrl:
                                          cubit.categorieItems[index].logo!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 140,
                                        height: 108,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
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
                                    SizedBox(height: 5.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Text(
                                        cubit.categorieItems[index].name!,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
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

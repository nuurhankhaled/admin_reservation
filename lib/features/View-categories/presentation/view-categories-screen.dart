import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewCategoriesScreen extends StatelessWidget {
  const ViewCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var categoryCubit = CategoryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
              title: Text("reservationApp".tr()),
              leading: Padding(
                padding: EdgeInsets.only(right: 50.w),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              )),
          body: (state is GetCategoriesLoading)
              ? CustomLoadingIndicator()
              : Padding(
                  padding: EdgeInsets.all(18.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 25.w,
                      mainAxisSpacing: 8.h,
                    ),
                    itemCount: categoryCubit.categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.pushNamed(Routes.viewCategoryDetailsScreen);
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
                                      categoryCubit.categories[index].image!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 140,
                                    height: 108,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(height: 2.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(
                                    categoryCubit.categories[index].name!,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.sp,
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

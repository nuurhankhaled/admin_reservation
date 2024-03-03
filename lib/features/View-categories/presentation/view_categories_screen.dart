import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Category/business-logic/category_cubit/category_cubit.dart';
import 'package:reservationapp_admin/features/Add-Category/data/models/category_model.dart';
import 'package:reservationapp_admin/features/View-categories/presentation/widgets/edit-category-dialog.dart';

class ViewCategoriesScreen extends StatefulWidget {
  const ViewCategoriesScreen({super.key});

  @override
  _ViewCategoriesScreenState createState() => _ViewCategoriesScreenState();
}

class _ViewCategoriesScreenState extends State<ViewCategoriesScreen> {
  TextEditingController searchController = TextEditingController();

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
        List<Data> filteredCategories = categoryCubit.categories
            .where((category) => category.name!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();

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
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: 200,
                  child: CustomTextFormField(
                    hintText: "بحث ..",
                    contentPadding: const EdgeInsets.only(bottom: 15.0),
                    controller: searchController,
                    prefixIcon: const Icon(Icons.search),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          body: (state is GetCategoriesLoading)
              ? const CustomLoadingIndicator()
              : (filteredCategories.isEmpty)
                  ? const Center(
                      child: Text(
                        "لا يوجد منشات متاحة حالياً",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                childAspectRatio: 1.1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 8.h,
                              ),
                              itemCount: filteredCategories.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                        Routes.viewCategoryDetailsScreen,
                                        arguments:
                                            filteredCategories[index].name!);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.blueGrey,
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          CachedNetworkImage(
                                            imageUrl: filteredCategories[index]
                                                .image!,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 200,
                                              height: 128,
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
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                          const SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    filteredCategories[index]
                                                        .name!,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22.sp,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  width: 35,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return BlocProvider(
                                                            create: (context) =>
                                                                CategoryCubit(),
                                                            child:
                                                                EditCategoryDialog(
                                                              id: filteredCategories[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              name:
                                                                  filteredCategories[
                                                                          index]
                                                                      .name!,
                                                              image:
                                                                  filteredCategories[
                                                                          index]
                                                                      .image!,
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.green,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                                Container(
                                                  width: 35,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      categoryCubit.deleteCategory(
                                                          id: filteredCategories[
                                                                  index]
                                                              .id!);
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  ),
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
                        ],
                      ),
                    ),
        );
      },
    );
  }
}

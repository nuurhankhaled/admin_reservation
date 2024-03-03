import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:reservationapp_admin/core/widgets/custom_loading_indecator.dart';
import 'package:reservationapp_admin/core/widgets/custom_text_form_field.dart';
import 'package:reservationapp_admin/features/Add-Items/business-logic/Item_cubit/item_cubit.dart';
import 'package:reservationapp_admin/features/View-category-details/business-logic/category_cubit/category_items_cubit.dart';
import 'package:reservationapp_admin/features/View-category-details/data/models/items-model.dart';

class ViewCategoryDetails extends StatefulWidget {
  final String title;
  const ViewCategoryDetails({super.key, required this.title});

  @override
  _ViewCategoryDetailsState createState() => _ViewCategoryDetailsState();
}

class _ViewCategoryDetailsState extends State<ViewCategoryDetails> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CategoryItemsCubit.get(context)
        .getCategoryItems(categoryName: widget.title);
    return BlocConsumer<CategoryItemsCubit, CategoryItemsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var categoryCubit = CategoryItemsCubit.get(context);
        return BlocConsumer<ItemCubit, ItemState>(
          listener: (context, state) {
            if (state is DeleteItemSuccess) {
              categoryCubit.getCategoryItems(categoryName: widget.title);
            }
          },
          builder: (context, state) {
            var itemCubit = ItemCubit.get(context);
            List<Data> filteredItems = categoryCubit.categoryItems
                .where((item) => item.name!
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase()))
                .toList();

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
              body: (state is GetCategoryItemsLoading)
                  ? const CustomLoadingIndicator()
                  : (filteredItems.isEmpty)
                      ? const Center(
                          child: Text(
                            "لا يوجد وحدات متاحة حالياً",
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
                                  itemCount: filteredItems.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        // context.pushNamed(Routes.viewFacilityDetailsScreen);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: Colors.blueGrey,
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              CachedNetworkImage(
                                                imageUrl:
                                                    filteredItems[index].logo!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: 200,
                                                  height: 128,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      child: Text(
                                                        filteredItems[index]
                                                            .name!,
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 22.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
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
                                                            context.pushNamed(
                                                                Routes
                                                                    .editItemScreen,
                                                                arguments:
                                                                    filteredItems[
                                                                        index]);
                                                          },
                                                          icon: const Icon(
                                                            Icons.edit,
                                                            color: Colors.green,
                                                            size: 20,
                                                          )),
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
                                                            itemCubit.deleteItem(
                                                                id: filteredItems[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                          },
                                                          icon: const Icon(
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
                            ],
                          ),
                        ),
            );
          },
        );
      },
    );
  }
}

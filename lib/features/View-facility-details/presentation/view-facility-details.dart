import 'package:flutter/material.dart';
import 'package:reservationapp_admin/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reservationapp_admin/core/routing/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewFacilityDetails extends StatelessWidget {
  const ViewFacilityDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("قاعه اللؤلؤة"),
          leading: Padding(
            padding: EdgeInsets.only(right: 50.w),
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            childAspectRatio: 1.5,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 10.h,
          ),
          itemCount: 20,
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
                        imageUrl: "http://via.placeholder.com/200x150",
                        imageBuilder: (context, imageProvider) => Container(
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
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "Facility Naryeyyyyyyyyyyyyyyyme",
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
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
//
// class AddNewPersonWidget extends StatefulWidget {
//   const AddNewPersonWidget({Key? key}) : super(key: key);
//
//   @override
//   State<AddNewPersonWidget> createState() => _AddNewPersonWidgetState();
// }
//
// class _AddNewPersonWidgetState extends State<AddNewPersonWidget> {
//
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _confirmPassController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool passwordVisible = false;
//
//   bool isSecure = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//       width: 75.w,
//       child: Form(
//         key: _formKey,
//
//         child: Column(
//           children: [
//             const SizedBox(height: 15,),
//
//             Text("تسجيل موظف جديد", style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20),),
//
//             const SizedBox(height: 15,),
//
//             Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//
//               children: [
//               Column(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("الأسم الأخير", textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Cairo'),),
//                     ],
//                   ),
//                   SizedBox(height:8,),
//                   TextFormFieldWidget(labelText: "",
//                     prefix: null,
//                     suffix: Icon(Icons.people_outline, color: AppColors.lightGrey,),
//                     IsObsecure: false,
//                     textFieldController: _lastNameController,
//                     fillcolor: Colors.transparent, width: 14.w,
//
//                   ),
//                 ],
//               ),
//                 SizedBox(width: 2.w,),
//                 Column(
//                   children: [
//                     Text("الأسم الأول", textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Cairo'),),
//                     SizedBox(height:8,),
//                     TextFormFieldWidget(labelText: "",
//                       prefix: null,
//                       suffix: Icon(Icons.perm_identity, color: AppColors.lightGrey,),
//                       IsObsecure: false,
//                       textFieldController: _firstNameController,
//                       // color: AppColors.lightGrey,
//                       fillcolor: Colors.transparent, width: 14.w,
//
//                     ),
//                   ],
//                 ),
//
//               ],
//             ),
//             const SizedBox(height: 10,),
//             Container(
//               child: Text("رقم الهاتف", textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Cairo'),),),
//             SizedBox(height:8,),
//             TextFormFieldWidget(labelText: "",
//               prefix: null,
//               suffix: Icon(Icons.phone, color: AppColors.lightGrey,),
//               IsObsecure: false,
//               textFieldController: _phoneController,
//               // color: AppColors.lightGrey,
//               fillcolor: Colors.transparent, width: 30.w,
//
//             ),
//
//             const SizedBox(height: 10,),
//
//             Container(
//               child: Text("البريد الألكتروني", textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Cairo'),),),
//             SizedBox(height:8,),
//             TextFormFieldWidget(labelText: "",
//               prefix: null,
//               suffix: Icon(Icons.email_outlined, color: AppColors.lightGrey,),
//               IsObsecure: false,
//               textFieldController: _emailController,
//               // color: AppColors.lightGrey,
//               fillcolor: Colors.transparent, width: 30.w,
//
//             ),
//
//             const SizedBox(height: 10,),
//
//             Text("كلمه السر", textAlign: TextAlign.start, style: TextStyle(fontFamily:'Cairo'), ),
//             SizedBox(height: 5,),
//
//             TextFormFieldWidget(width: 30.w,
//               labelText: "",
//               suffix: IconButton(
//                 icon: Icon(
//                   passwordVisible ? Icons.lock_open : Icons.lock_outline,
//                   color: AppColors.lightGrey,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isSecure = !isSecure;
//                     passwordVisible = !passwordVisible;
//                   });
//                 },
//               ),
//               prefix: IconButton(
//                 icon: Icon(
//                   passwordVisible ? Icons.visibility : Icons.visibility_off,
//                   color: AppColors.lightGrey,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isSecure = !isSecure;
//                     passwordVisible = !passwordVisible;
//                   });
//                 },
//               ),
//               IsObsecure: isSecure,
//               textFieldController: _passwordController,
//               fillcolor: Colors.transparent,
//             ),
//             const SizedBox(height: 10,),
//
//             Text("تأكيد كلمه السر", textAlign: TextAlign.start, style: TextStyle(fontFamily:'Cairo'), ),
//             SizedBox(height: 5,),
//
//             TextFormFieldWidget(width: 30.w,
//               labelText: "",
//               suffix: IconButton(
//                 icon: Icon(
//                   passwordVisible ? Icons.lock_open : Icons.lock_outline,
//                   color: AppColors.lightGrey,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isSecure = !isSecure;
//                     passwordVisible = !passwordVisible;
//                   });
//                 },
//               ),
//               prefix: IconButton(
//                 icon: Icon(
//                   passwordVisible ? Icons.visibility : Icons.visibility_off,
//                   color: AppColors.lightGrey,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isSecure = !isSecure;
//                     passwordVisible = !passwordVisible;
//                   });
//                 },
//               ),
//               IsObsecure: isSecure,
//               textFieldController: _confirmPassController,
//               fillcolor: Colors.transparent,
//             ),
//             const SizedBox(height: 10,),
//
//             SizedBox(
//               width: 25.w,
//               height: 7.h,
//               child: ElevatedButton(
//                 onPressed: (){
//                   // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
//                 },
//                 child: Text("تسجيل", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.black ,fontFamily: 'Cairo'),),
//               ),
//             ),
//
//             const SizedBox(height: 20,),
//
//           ],
//         ),
//       ),
//     );
//   }
// }

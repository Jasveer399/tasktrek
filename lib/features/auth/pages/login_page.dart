import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasktrek/common/utils/constants.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:tasktrek/common/widgets/custom_TextFild.dart';
import 'package:tasktrek/common/widgets/custom_otln_btn.dart';
import 'package:tasktrek/common/widgets/reusable_text.dart';
import 'package:tasktrek/features/auth/controllers/code_provider.dart';
import 'package:tasktrek/features/auth/pages/otp_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();
  Country country = Country(
    phoneCode: '1',
    countryCode: 'IND',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'IND',
    example: 'IND',
    displayName: 'India',
    displayNameNoCountryCode: 'India',
    e164Key: '',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Image.asset("assets/images/todo2.png"),
                ),
                SizedBox(
                  height: 50.h,
                ),
                //text for show the enter you phone number,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                  child: Text(
                    "Enter You Phone Number",
                    style: appstyle(16, AppConst.KLight, FontWeight.w400),
                  ),
                ),

                //Show the textfromfiled for get the user number,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomTextFiled(
                    controller: phone,
                    keyboardType: TextInputType.number,
                    hintText: " Enter Phone Number",
                    hintStyle: appstyle(15, AppConst.KBkdark, FontWeight.w400),
                    prefixIcon: Container(
                      padding: EdgeInsets.only(left: 10.w, top: 13.h),
                      child: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                  backgroundColor: AppConst.KBkdark,
                                  textStyle: appstyle(
                                      17, AppConst.KLight, FontWeight.normal),
                                  searchTextStyle: appstyle(
                                      17, AppConst.KLight, FontWeight.normal),
                                  inputDecoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    prefixIconColor: Colors.white,
                                    labelText: "Search",
                                    labelStyle: appstyle(
                                        15, Colors.white, FontWeight.w500),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: AppConst.KLight, width: 1)),
                                  ),
                                  bottomSheetHeight: AppConst.khight * 0.6,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              onSelect: (code) {
                                setState(() {
                                  country=code;
                                });
                                ref.read(codeStateProvider.notifier).setstate(code.phoneCode);
                              });
                        },
                        child: ReusableText(
                            text: "${country.flagEmoji} + ${country.phoneCode}",
                            style: appstyle(
                                15, AppConst.KBkdark, FontWeight.w600)),
                      ),
                    ),
                  ),
                ),

                //this BTN is function as the send the OTP/code,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 60.h),
                  child: CustomOtlnBtn(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPPage()));
                    },
                      height: AppConst.khight * 0.07,
                      widgth: AppConst.kwidth * 0.85,
                      colorT: AppConst.KBkdark,
                      colorB: AppConst.KLight,
                      text: "Send code"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

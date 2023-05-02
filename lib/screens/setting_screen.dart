import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sowaanerp_hr/common/common_dialog.dart';
import 'package:sowaanerp_hr/common/common_widget.dart';
import 'package:sowaanerp_hr/models/employee.dart';
import 'package:sowaanerp_hr/responsive/responsive_flutter.dart';
import 'package:sowaanerp_hr/screens/locations_screen.dart';
import 'package:sowaanerp_hr/screens/login_screen.dart';
import 'package:sowaanerp_hr/theme.dart';
import 'package:sowaanerp_hr/utils/app_colors.dart';
import 'package:sowaanerp_hr/utils/shared_pref.dart';
import 'package:sowaanerp_hr/utils/utils.dart';
import 'package:sowaanerp_hr/widgets/box_card.dart';
import 'package:sowaanerp_hr/widgets/custom_appbar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Utils _utils = new Utils();
  SharedPref prefs = new SharedPref();
  Employee _employeeModel = Employee();
  String baseURL = '';

  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";

  @override
  void initState() {
    super.initState();

    //Read base url from prefs
    prefs.readString(prefs.prefBaseUrl).then((value) {
      setState(() {
        baseURL = value;
      });
    });

    //Read employee info from prefs
    prefs.readObject(prefs.prefKeyEmployeeData).then((value) => {
          if (value != null)
            {
              setState(() {
                _employeeModel = Employee.fromJson(value);
              })
            }
        });

    initApp();
  }

  Future<void> initApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    setState(() {});
  }

  logout() {
    prefs.saveObject(prefs.prefKeyEmployeeData, null);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return LoginScreen();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.textWhiteGrey,
        appBar: const PreferredSize(
          child: CustomAppBar(
            title: "Settings",
            icon: Icons.notifications_none,
            // icon2: Icons.settings,
          ),
          preferredSize: Size.fromHeight(50),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 6),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IntrinsicHeight(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  // show User Image
                                  return AlertDialog(
                                    content: SizedBox(
                                        height: 250,
                                        width: 200,
                                        child: Hero(
                                          tag: 'imageHero',
                                          child: FadeInImage.assetNetwork(
                                            fit: BoxFit.cover,
                                            placeholder:
                                                "assets/images/giphy.gif",
                                            image: _employeeModel.image !=
                                                        null &&
                                                    _employeeModel.image!
                                                        .startsWith("https://")
                                                ? _employeeModel.image
                                                    .toString()
                                                : '$baseURL${_employeeModel.image}',
                                          ),
                                        )),
                                  );
                                });
                          },
                          child: SizedBox(
                            width: ResponsiveFlutter.of(context).scale(100),
                            height: ResponsiveFlutter.of(context)
                                .verticalScale(100),
                            // child: Container(),
                            child: Hero(
                              tag: 'imageHero',
                              child: widgetCommonProfile(
                                imagePath: _employeeModel.image != null &&
                                        _employeeModel.image!
                                            .startsWith("https://")
                                    ? _employeeModel.image.toString()
                                    : '$baseURL${_employeeModel.image}',
                                isBackGroundColorGray: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _employeeModel.employeeName != null
                          ? Text(
                              '${_employeeModel.employeeName}',
                              textAlign: TextAlign.right,
                              style: heading5.copyWith(
                                  color: AppColors.primary, fontSize: 20),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      _employeeModel.designation != null
                          ? Text(
                              '${_employeeModel.designation}',
                              textAlign: TextAlign.right,
                              style: heading5.copyWith(
                                  color: AppColors.primary, fontSize: 15),
                            )
                          : Container(),
                      _employeeModel.designation != null
                          ? const SizedBox(
                              height: 10,
                            )
                          : Container(),
                      _employeeModel.department != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.apartment,
                                  color: AppColors.textGrey,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${_employeeModel.department}',
                                  textAlign: TextAlign.right,
                                  style: heading6.copyWith(
                                      color: AppColors.textGrey, fontSize: 14),
                                ),
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: Text(
                        'Allowed Locations',
                        style: heading6.copyWith(color: AppColors.textGrey),
                      ),
                      leading: Icon(Icons.gps_fixed),
                      iconColor: AppColors.primary,
                      minLeadingWidth: 10,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationsScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                          "${appName} v${version} (${buildNumber.padLeft(2, '0')})",
                          style: heading6.copyWith(color: AppColors.textGrey)),
                      leading: Icon(Icons.info_outline),
                      iconColor: AppColors.primary,
                      minLeadingWidth: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _utils.hideKeyboard(context);

            dialogConfirm(context, _utils, () {
              logout();
            }, "Are you sure to logout from the app?");
          },
          backgroundColor: AppColors.checkoutRed,
          label: const Text("Logout"),
          icon: const Icon(Icons.logout),
        ),
      ),
    );
  }
}

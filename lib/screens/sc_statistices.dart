import 'package:flutter/material.dart';
import 'package:nobody/models/list_colors.dart';
import 'package:nobody/widgets/data.dart';
import 'package:nobody/widgets/wid_important.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:currency_picker/currency_picker.dart';

class StatisticesScreen extends StatefulWidget {
  const StatisticesScreen({super.key});

  @override
  State<StatisticesScreen> createState() => _StatisticesScreenState();
}

class _StatisticesScreenState extends State<StatisticesScreen> {
  Currency? counts;
  Future<void> loadCurrency() async {
    final code = await readCurrency();

    if (code == null) return;

    setState(() {
      counts = CurrencyService().findByCode(code);
    });
  }

  @override
  void initState() {
    super.initState();
    loadCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theDarkMode
          ? darkColors["background"]
          : lightColors["background"],
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "الاعدادات",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoxSwitch(
              supTitle: "يخفف الألوان الساطعة",
              text: "الوضع الليلي",
              stateSw: false,
            ),

            Divider(
              height: 1,
              thickness: 2,
              color: theDarkMode
                  ? darkColors["divider"]
                  : lightColors["divider"],
            ),

            InkWell(
              onTap: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("تأكيد الحذف"),
                      content: Text("هل أنت متأكد من حذف جميع العمليات؟"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text("إلغاء"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            "حذف",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (result == true) {
                  deleteList();
                }
              },
              child: Container(
                alignment: Alignment.centerRight,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 70,
                child: Text(
                  " حذف كل العمليات",
                  style: TextStyle(
                    fontSize: 19,
                    color: theDarkMode
                        ? darkColors["text"]
                        : lightColors["text"],
                  ),
                ),
              ),
            ),

            Divider(
              height: 1,
              thickness: 2,
              color: theDarkMode
                  ? darkColors["divider"]
                  : lightColors["divider"],
            ),

            InkWell(
              onTap: () {
                //لاختيار نوع العملة
                showCurrencyPicker(
                  context: context,
                  showFlag: true,
                  showCurrencyName: true,
                  showCurrencyCode: true,
                  onSelect: (Currency currency) async {
                    setState(() {
                      counts = currency;
                    });

                    await saveCurrency(currency.code);
                  },
                );
              },
              child: Container(
                alignment: Alignment.centerRight,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 70,
                child: Text(
                  counts == null
                      ? "اختر العملة"
                      : "${counts!.name} (${counts!.code})",
                  style: TextStyle(
                    fontSize: 19,
                    color: theDarkMode
                        ? darkColors["text"]
                        : lightColors["text"],
                  ),
                ),
              ),
            ),

            Divider(
              height: 1,
              thickness: 2,
              color: theDarkMode
                  ? darkColors["divider"]
                  : lightColors["divider"],
            ),

            Expanded(child: Container()),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerRight,
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: theDarkMode
                        ? Colors.white.withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: theDarkMode
                    ? const Color.fromARGB(246, 167, 179, 155)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              //اصدار التطبيق
              child: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('رقم الاصدار  [${snapshot.data!.version}]');
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

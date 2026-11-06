import 'package:flutter/material.dart';
import 'package:nobody/models/list_colors.dart';
import 'package:nobody/widgets/data.dart';
import 'package:nobody/widgets/wid_important.dart';
import 'package:nobody/models/operation_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String coin = "";
  @override
  void initState() {
    super.initState();
    _load();
    _loadCurrency();
  }

  Future<void> _loadCurrency() async {
    final currency = await readCurrency();

    if (!mounted) return;

    setState(() {
      coin = currency ?? "";
    });
  }

  Future<void> _load() async {
    final data = await readMap();

    if (!mounted) return;

    setState(() => listOperations = data);
  }

  final totalExpenses = sum(listOperations, Colors.red);
  final totalIncome = sum(listOperations, Colors.green);

  @override
  Widget build(BuildContext context) {
    //انشاء قائمة جديدة
    final recent = List<Map<String, dynamic>>.from(listOperations);
    //مقارنة 
    recent.sort((a, b) {
      return b["date"].compareTo(a["date"]);
    });
    final lastThree = recent.take(3).toList();
    final totalExpenses = sum(listOperations, Colors.red);
    final totalIncome = sum(listOperations, Colors.green);
    return Scaffold(
      backgroundColor: theDarkMode
          ? darkColors["background"]
          : lightColors["background"],
      appBar: AppBar(
        title: const Text(
          "الصفحة الرئيسية",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 10),
              ////
              //// بطاقة الدخل والمصاريف
              ////
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: theDarkMode
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset("assets/card_home.png", fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "ملخصك المالي لهذا الشهر",
                              style: TextStyle(
                                color: Color.fromARGB(230, 255, 255, 255),
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    (totalIncome - totalExpenses).toString(),
                                    style: const TextStyle(
                                      fontSize: 29,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  coin,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 29,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            Row(
                              children: [
                                Expanded(
                                  child: BuildFinancialInfo(
                                    title: "المصاريف",
                                    amount: totalExpenses.toString(),
                                    icon: Icons.trending_down_rounded,
                                    color: const Color.fromARGB(
                                      255,
                                      233,
                                      79,
                                      68,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 45,
                                  color: const Color.fromARGB(
                                    255,
                                    248,
                                    246,
                                    246,
                                  ),
                                ),
                                Expanded(
                                  child: BuildFinancialInfo(
                                    title: "الدخل",
                                    amount: totalIncome.toString(),
                                    icon: Icons.trending_up_rounded,
                                    color: const Color(0xFF86EFAC),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // عنوان آخر العمليات
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "آخر العمليات",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: theDarkMode
                          ? darkColors["income"]
                          : lightColors["primary"],
                    ),
                  ),
                ],
              ),
            ),

            // بطاقة العمليات
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theDarkMode ? darkColors["card"] : lightColors["card"],
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: theDarkMode
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.25),
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: lastThree.isEmpty
                        ? [
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theDarkMode
                                    ? darkColors["card"]
                                    : lightColors["card"],
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.receipt_long_rounded,
                                size: 43,
                                color: theDarkMode
                                    ? const Color(0xFF35D69A)
                                    : const Color(0xFF087F5B),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "لا توجد عمليات بعد",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: theDarkMode
                                    ? darkColors["income"]
                                    : lightColors["income"],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "ستظهر عملياتك المالية هنا",
                              style: TextStyle(
                                fontSize: 13,
                                color: theDarkMode
                                    ? darkColors["subText"]
                                    : lightColors["subText"],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ]
                        : lastThree.map((op) {
                            final cat = categories.firstWhere(
                              (item) => item.id == op["id"],
                              orElse: () => categories.first,
                            );
                            final d = op["date"] as DateTime;

                            return AddPractical(
                              text: cat.text,
                              icon: cat.icon,
                              colorCircle: cat.color,
                              date: "${d.year}/${d.month}/${d.day}",
                              price: op["amount"].toString(),
                              iconPrice: isState(op, Colors.red)
                                  ? Icons.trending_down_rounded
                                  : Icons.trending_up_rounded,
                              colorPrice: op["state"],
                            );
                          }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

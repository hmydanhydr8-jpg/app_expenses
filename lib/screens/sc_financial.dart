import 'package:flutter/material.dart';
import 'package:nobody/models/list_colors.dart';
import 'package:nobody/models/operation_category.dart';
import 'package:nobody/widgets/data.dart';
import 'package:nobody/widgets/wid_dialog.dart';
import 'package:nobody/widgets/wid_important.dart';

class FinancialOperationsScreen extends StatefulWidget {
  const FinancialOperationsScreen({super.key});

  

  @override
  State<FinancialOperationsScreen> createState() =>
      _FinancialOperationsScreenState();
}

class _FinancialOperationsScreenState extends State<FinancialOperationsScreen> {
  static const String all = "all";
  static const String income = "income";
  static const String expenses = "expenses";
  static const Color mainGreen = Color(0xFF087F5B);

  String selectedFilter = all;

  Future<void> loadUser() async {
    final data = await readMap();

    if (!mounted) return;

    setState(() {
      listOperations = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final totalExpenses = sum(listOperations, Colors.red);
    final totalIncome = sum(listOperations, Colors.green);

    final shown = listOperations.where((op) {
      if (selectedFilter == income) return isState(op, Colors.green);
      if (selectedFilter == expenses) return isState(op, Colors.red);
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: theDarkMode ? Colors.black : Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainGreen,
        foregroundColor: Colors.white,
        elevation: 5,
        onPressed: () async {
          final result = await showAddOperationDialog(context);

          if (result != null) {
            setState(() {
              listOperations.add(result);
            });

            await saveMap(listOperations);
          }
        },
        child: const Icon(Icons.add, size: 30),
      ),
      body: Stack(
        children: [
          Image.asset(
            theDarkMode
                ? "assets/dark_financial.png"
                : "assets/light_financial.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // العنوان
                    BoxText(size: 29, text: "العمليات"),
                    const SizedBox(height: 4),
                    BoxText(size: 16, text: "كل مصاريفك ودخلك في مكان واحد"),
                    const SizedBox(height: 20),

                    // أزرار التصفية
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: theDarkMode
                            ? darkColors["card"]
                            : lightColors["card"],
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: theDarkMode
                                ? Colors.white.withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),

                      child: SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: all, label: Text("الكل")),
                          ButtonSegment(
                            value: expenses,
                            label: Text("المصاريف"),
                          ),
                          ButtonSegment(value: income, label: Text("الدخل")),
                        ],
                        selected: {selectedFilter},
                        emptySelectionAllowed: false,
                        multiSelectionEnabled: false,
                        onSelectionChanged: (value) {
                          setState(() {
                            selectedFilter = value.first;
                          });
                        },
                        showSelectedIcon: false,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.resolveWith((
                            states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return mainGreen;
                            }
                            return Colors.white;
                          }),
                          foregroundColor: WidgetStateProperty.resolveWith((
                            states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.white;
                            }
                            return Colors.black87;
                          }),
                          side: const WidgetStatePropertyAll(
                            BorderSide(color: Colors.transparent),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          visualDensity: VisualDensity.compact,
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // إجمالي المصاريف والدخل
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: theDarkMode
                            ? darkColors["card"]
                            : lightColors["card"],
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: theDarkMode
                                ? Colors.white.withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: BoxSpends(
                              total: totalExpenses.toDouble(),
                              text: "إجمالي المصاريف",
                              color: Colors.red.shade600,
                              icon: Icons.arrow_downward,
                            ),
                          ),
                          const SizedBox(
                            height: 55,
                            child: VerticalDivider(
                              thickness: 1.5,
                              color: Color(0xFFDDE5E0),
                              width: 1,
                            ),
                          ),
                          Expanded(
                            child: BoxSpends(
                              icon: Icons.arrow_upward,
                              total: totalIncome.toDouble(),
                              text: "إجمالي الدخل",
                              color: mainGreen,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // عنوان التفاصيل
                    BoxText(size: 25, text: "التفاصيل"),

                    const SizedBox(height: 12),

                    // بطاقة العمليات
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: theDarkMode
                                ? Colors.white.withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Image.asset(
                              "assets/card_financial.png",
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: double.infinity,

                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          shown.isEmpty
                              ? Center(
                                  child: Text(
                                    "لا يوجد عمليات بعد",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: theDarkMode
                                          ? darkColors["text"]
                                          : lightColors["text"],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: shown.length,
                                  itemBuilder: (context, index) {
                                    final op = shown[index];
                                    final cat = categories.firstWhere(
                                      (c) => c.id == op["id"],
                                      orElse: () => categories.first,
                                    );
                                    final data = op["date"] as DateTime;

                                    return InkWell(
                                      onLongPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return AlertDialog(
                                              title: const Text("حذف العملية"),
                                              content: const Text(
                                                "هل تريد حذف هذه العملية؟",
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                      dialogContext,
                                                    );
                                                  },
                                                  child: const Text("إلغاء"),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      listOperations.remove(op);
                                                    });

                                                    await saveMap(
                                                      listOperations,
                                                    );

                                                    if (dialogContext.mounted) {
                                                      Navigator.pop(
                                                        dialogContext,
                                                      );
                                                    }
                                                  },
                                                  child: const Text(
                                                    "حذف",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: AddPractical(
                                        text: cat.text,
                                        icon: cat.icon,
                                        colorCircle: cat.color,
                                        date:
                                            "${data.year}/${data.month}/${data.day}",
                                        price: op["amount"].toString(),
                                        iconPrice:
                                            op["state"].toARGB32() ==
                                                Colors.red.toARGB32()
                                            ? Icons.trending_down_rounded
                                            : Icons.trending_up_rounded,
                                        colorPrice: op["state"],
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nobody/models/operation_category.dart';

Future<Map<String, dynamic>?> showAddOperationDialog(BuildContext context) {
  int currentStep = 0;
  bool colorButtonRed = false;
  bool colorButtonGreen = false;
  final controller = TextEditingController();

  Map<String, dynamic> selectedType = {
    "id": 0,
    "state": Colors.red,
    "date": "",
    "amount": 0.0,
  };

  return showGeneralDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible: false,

    barrierLabel: "إغلاق",
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),

    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment(1, 0.9),
        ///////////////////////
        child: Material(
          color: Colors.transparent,
          child: Container(
            // تعديل 1: نرفع الحوار فوق لوحة المفاتيح
            margin: EdgeInsets.only(
              bottom: 90 + MediaQuery.of(dialogContext).viewInsets.bottom,
              left: 20,
              right: 20,
            ),
            width: double.infinity,
            height: 266,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: StatefulBuilder(
                    builder: (context, setStateDialog) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              "assets/wellet.png",
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.black.withValues(alpha: 0.2),
                            ),
                          ),

                          // المرحلة الأولى: اختيار التصنيف
                          if (currentStep == 0)
                            GridView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: categories.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 100,
                                    mainAxisExtent: 90,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                  ),
                              itemBuilder: (context, index) {
                                final item = categories[index];

                                return InkWell(
                                  onTap: () {
                                    setStateDialog(() {
                                      selectedType["id"] = item.id;
                                      currentStep = 1;
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor: item.color,
                                        child: Icon(
                                          item.icon,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item.text,
                                        style: const TextStyle(
                                          fontSize: 19,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                          // المرحلة الثانية: نوع العملية والمبلغ
                          if (currentStep == 1)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "اختر نوع العملية",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),

                                    const SizedBox(height: 12),
                                    ///////////////////////////
                                    ///زيادة ونقصان
                                    ///////////////////////////
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setStateDialog(() {
                                              colorButtonRed = true;
                                              if (colorButtonGreen == true) {
                                                colorButtonGreen = false;
                                              }

                                              selectedType["state"] =
                                                  Colors.red;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: colorButtonRed
                                                ? Colors.red
                                                : const Color.fromARGB(
                                                    255,
                                                    235,
                                                    128,
                                                    120,
                                                  ),
                                          ),
                                          child: const Text(
                                            "نقص",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),

                                        ElevatedButton(
                                          onPressed: () {
                                            setStateDialog(() {
                                              colorButtonGreen = true;
                                              if (colorButtonRed == true) {
                                                colorButtonRed = false;
                                              }
                                              selectedType["state"] =
                                                  Colors.green;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: colorButtonGreen
                                                ? Colors.green
                                                : const Color.fromARGB(
                                                    255,
                                                    135,
                                                    231,
                                                    139,
                                                  ),
                                          ),
                                          child: const Text(
                                            "زيادة",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),
                                    //////////////////////////
                                    ///مربع الادخال
                                    //////////////////////////
                                    TextField(
                                      controller: controller,
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),

                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.greenAccent,
                                          ),
                                        ),
                                        hintText: "المبلغ",
                                        filled: true,
                                        fillColor: Colors.white,
                                        counterText: "",
                                        suffixIcon: Icon(
                                          Icons.attach_money,
                                          color: Colors.green,
                                        ),
                                      ),

                                      textInputAction: TextInputAction.done,
                                      maxLength: 8,
                                      cursorColor: Colors.green,
                                    ),

                                    const SizedBox(height: 8),

                                    ElevatedButton(
                                      onPressed: () {
                                        final amount = double.tryParse(
                                          controller.text.trim(),
                                        );

                                        if (amount == null || amount <= 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "أدخل مبلغاً صحيحاً",
                                                  ),
                                                ),
                                              );
                                          return;
                                        }

                                        if (selectedType["state"] == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "اختر زيادة أو نقص",
                                                  ),
                                                ),
                                              );
                                          return;
                                        }

                                        setStateDialog(() {
                                          selectedType["amount"] = amount;
                                          currentStep = 2;
                                        });
                                      },
                                      child: const Text("التالي"),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          // المرحلة الثالثة: اختيار التاريخ
                          if (currentStep == 2)
                            Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  final date = await showDatePicker(
                                    context: dialogContext,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2035),
                                    initialDate: DateTime.now(),
                                  );

                                  if (date != null && dialogContext.mounted) {
                                    selectedType["date"] = date;
                                    Navigator.pop(dialogContext, selectedType);
                                  }
                                },
                                child: const Text(
                                  "اختيار التاريخ",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(dialogContext),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black87,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },

    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      );
    },
  ).whenComplete(() {
    Future.delayed(const Duration(milliseconds: 400), controller.dispose);
  });
}

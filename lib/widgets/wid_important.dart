import 'package:flutter/material.dart';
import 'package:nobody/models/list_colors.dart';
import 'package:nobody/models/operation_category.dart';
import 'package:nobody/widgets/data.dart';
import 'package:nobody/main.dart';

class BoxText extends StatelessWidget {
  const BoxText({super.key, required this.size, required this.text});
  final double size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            color: theDarkMode ? darkColors["text"] : lightColors["text"],
          ),
        ),
      ],
    );
  }
}

class BoxSpends extends StatelessWidget {
  const BoxSpends({
    super.key,
    required this.total,
    required this.text,
    required this.color,
    required this.icon,
  });
  final double total;
  final String text;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                radius: 17,
                backgroundColor: color.withValues(alpha: 0.2),
                child: Icon(icon, color: color),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: theDarkMode ? darkColors["text"] : lightColors["text"],
              ),
            ),
          ],
        ),
        Text(total.toString(), style: TextStyle(color: color, fontSize: 19)),
      ],
    );
  }
}

class BuildFinancialInfo extends StatelessWidget {
  const BuildFinancialInfo({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });
  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 25),

              const SizedBox(width: 5),

              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              amount,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoxSwitch extends StatefulWidget {
  const BoxSwitch({
    super.key,
    required this.text,
    required this.supTitle,
    required this.stateSw,
  });
  final String text;
  final String supTitle;
  final bool stateSw;

  @override
  State<BoxSwitch> createState() => _BoxSwitchState();
}

class _BoxSwitchState extends State<BoxSwitch> {
  late bool darkMode;

  @override
  void initState() {
    super.initState();
    darkMode = darkModeNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.text,
        style: TextStyle(
          color: theDarkMode ? darkColors["text"] : lightColors["text"],
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        widget.supTitle,
        style: TextStyle(
          color: theDarkMode ? darkColors["subText"] : lightColors["subText"],
        ),
      ),
      trailing: Transform.scale(
        scale: 0.80,
        child: Switch(
          value: darkMode,
          activeThumbColor: const Color.fromARGB(
            133,
            27,
            102,
            163,
          ).withValues(alpha: 0.1),
          onChanged: (s) async {
            setState(() => darkMode = s);
            theDarkMode = s;
            darkModeNotifier.value = s;
            await saveSwitches();
          },
        ),
      ),
    );
  }
}

class AddPractical extends StatelessWidget {
  const AddPractical({
    super.key,
    required this.text,
    required this.icon,
    required this.colorCircle,
    required this.date,
    required this.price,
    required this.iconPrice,
    required this.colorPrice,
  });

  final String text;
  final IconData icon;
  final Color colorCircle;
  final String date;
  final String price;
  final IconData iconPrice;
  final Color colorPrice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: theDarkMode
                ? const Color.fromARGB(246, 220, 235, 206)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(
                  255,
                  0,
                  0,
                  0,
                ).withValues(alpha: 0.2),
                offset: Offset(1, 3),
                blurRadius: 4,
              ),
            ],
          ),
          height: 70,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: colorCircle,
                  child: Icon(icon, color: Colors.white),
                ),
                SizedBox(width: 8),
                //التاريخ و النوع
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(), const SizedBox(width: 10),
                //سهم الايقونة
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          price,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(iconPrice, color: colorPrice),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleButtom extends StatelessWidget {
  const CircleButtom({
    super.key,
    required this.icon,
    required this.colorIcon,
    required this.onTap,
  });
  final IconData icon;
  final VoidCallback onTap;
  final Color colorIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 206, 204, 204),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: colorIcon, size: 40),
      ),
    );
  }
}

class DeleteOperation extends StatelessWidget {
  final Map op;
  final Widget child;
  final VoidCallback onUpdate;

  const DeleteOperation({
    super.key,
    required this.op,
    required this.child,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: const Text("إدارة العملية"),
              content: const Text("ماذا تريد أن تفعل؟"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("إلغاء"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    _editAmount(context);
                  },
                  child: const Text("تعديل"),
                ),
                TextButton(
                  onPressed: () async {
                    listOperations.remove(op);
                    await saveMap(listOperations);
                    onUpdate();

                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                    }
                  },
                  child: const Text("حذف", style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
      child: child,
    );
  }

  void _editAmount(BuildContext context) {
    final controller = TextEditingController(text: op["amount"].toString());

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("تعديل المبلغ"),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
            decoration: const InputDecoration(labelText: "المبلغ الجديد"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("إلغاء"),
            ),
            TextButton(
              onPressed: () async {
                final amount = double.tryParse(controller.text);

                if (amount == null || amount <= 0) return;

                op["amount"] = amount;

                await saveMap(listOperations);
                onUpdate();

                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text("حفظ"),
            ),
          ],
        );
      },
    );
  }
}

class OperationItem extends StatelessWidget {
  final Map<String, dynamic> op;
  final VoidCallback onUpdate;

  const OperationItem({super.key, required this.op, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    final cat = categories.firstWhere(
      (item) => item.id == op["id"],
      orElse: () => categories.first,
    );

    final d = op["date"] as DateTime;

    return DeleteOperation(
      op: op,
      onUpdate: onUpdate,
      child: AddPractical(
        text: cat.text,
        icon: cat.icon,
        colorCircle: cat.color,
        date: "${d.year}/${d.month}/${d.day}",
        price: op["amount"].toString(),
        iconPrice: isState(op, Colors.red)
            ? Icons.trending_down_rounded
            : Icons.trending_up_rounded,
        colorPrice: op["state"],
      ),
    );
  }
}

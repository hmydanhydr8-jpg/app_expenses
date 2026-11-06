import 'package:flutter/material.dart';
import 'package:nobody/models/list_colors.dart';
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

  Future<void> loadSwitches() async {
    final state = await readSwitches();
    setState(() {
      darkMode = state;
    });
  }

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: theDarkMode
              ? const Color.fromARGB(246, 220, 235, 206)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.2),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(iconPrice, color: colorPrice),
                  const SizedBox(width: 5),
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
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              CircleAvatar(
                radius: 25,
                backgroundColor: colorCircle,
                child: Icon(icon, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

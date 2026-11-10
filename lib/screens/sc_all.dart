import 'package:flutter/material.dart';
import 'package:nobody/widgets/data.dart';
import 'package:nobody/widgets/wid_important.dart';

class ScAll extends StatefulWidget {
  const ScAll({super.key});

  static String routeAll = "/all";

  @override
  State<ScAll> createState() => _ScAllState();
}

class _ScAllState extends State<ScAll> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "assets/LoLo2.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.4),
          ),
          if (listOperations.isEmpty)
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                
                children: [
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 30),
                        child: CircleButtom(
                          icon: Icons.arrow_forward,
                          colorIcon: const Color.fromARGB(255, 37, 206, 42),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          SafeArea(
            child: listOperations.isEmpty
                ? Center(
                    child: Text(
                      "لا يوجد عمليات بعد",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight - 150,
                        child: ListView.builder(
                          itemCount: listOperations.length,
                          itemBuilder: (context, index) {
                            final op = listOperations[index];

                            return OperationItem(
                              op: op,
                              onUpdate: () {
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleButtom(
                              icon: Icons.delete_sweep,
                              colorIcon: Colors.red,
                              onTap: () async {
                                final result = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("تأكيد الحذف"),
                                      content: Text(
                                        "هل أنت متأكد من حذف جميع العمليات؟",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text("إلغاء"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
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
                                  setState(() {});
                                }
                              },
                            ),

                            CircleButtom(
                              icon: Icons.arrow_forward,
                              colorIcon: const Color.fromARGB(255, 37, 206, 42),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

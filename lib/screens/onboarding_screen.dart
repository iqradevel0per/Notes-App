import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/screens/login_screen.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  var currentPage = 0;
  var colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
  ];

  var images = [
    "assets/images/Twos.png",
    "assets/images/Two.png",
    "assets/images/three.png",
  ];
  var text = [
    "Welcome to Surf.",
    "Design Template uploads Every Tuesday!",
    "Download now!",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: pageController,
                itemCount: images.length,
                onPageChanged: (nextIndex) {
                  setState(() {
                    currentPage = nextIndex;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 250),
                          child: Image.asset(
                            images[index],
                            height: 270,
                            width: 320,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          text[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton(
                      onPressed: () {
                        Get.offAll(() => LoginScreen());
                      },
                      child: Text("Skip",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                  ),
                ),

                //spread operater

                ...List.generate(colors.length, (index) {
                  return Container(
                    height: 8,
                    width: currentPage == index ? 20 : 8,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentPage == index ? Colors.red : Colors.grey,
                    ),
                  );
                }),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: TextButton(
                      onPressed: () {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceIn,
                        );
                        if (currentPage == 2) {
                          Get.to(
                            () => LoginScreen(),
                          );
                        }
                      },
                      child: Text("Next",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
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

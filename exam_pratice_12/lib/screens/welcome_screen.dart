import 'package:flutter/material.dart';
import '../models/welcome_model.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = new PageController();
  int currentIndex = 0;

  final List<welcomeModel> data = [
    welcomeModel(
      title: "Nền tảng học tập",
      description: "Ứng dụng học tập giúp học sinh lớp 12 ôn thi tốt nghiệp THPT.",
      imageUrl: 'assets/welcome/h1.png',
    ),
    welcomeModel(
      title: 'Tài liệu học tập',
      description: 'Ứng dụng cung cấp nhiều tài liệu từ nhiều trường THPT khác nhau trong Việt Nam.',
      imageUrl: 'assets/welcome/h2.png',
    ),
    welcomeModel(
      title: 'Video giảng dạy', 
      description: 'Có nhiều video giảng dạy từ các giáo viên được đánh giá cao.', 
      imageUrl: 'assets/welcome/h3.png'
    ),
    welcomeModel(
      title: 'Ôn tập và luyện đề',
      description: 'Ứng dụng sẽ có các đề ôn tập và sẽ có các đề thi thử của các năm trước hoặc các cuộc thi được tạo vào cuối tháng.',
      imageUrl: 'assets/welcome/h4.png'
    )
  ];

  void nextPage() {
    if (currentIndex < data.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void prevPage() {
    if (currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  Widget builDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: currentIndex == index ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: data.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = data[index];

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(item.imageUrl, height: 200),
                        const SizedBox(height: 30),
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: prevPage, 
                              icon: const Icon(Icons.arrow_back)
                            ),
                            IconButton(
                              onPressed: nextPage,
                              icon: const Icon(Icons.arrow_forward)
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(data.length, 
                          (index) => builDot(index),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {}, ///ready_button -> Login_screen 
                              child: const Text(
                                "Bắt đầu",
                                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  );
                },
              )
            )
          ],
        )
      )
    );
  }
}
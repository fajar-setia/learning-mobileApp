import 'package:flutter/material.dart';
import 'package:flutter_app/pages/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> fitures = [
    {'icon': Icons.local_offer, 'label': 'Offers'},
    {'icon': Icons.new_releases, 'label': 'New Arrivals'},
    {'icon': Icons.star, 'label': 'Top Rated'},
    {'icon': Icons.trending_up, 'label': 'Trending'},
    {'icon': Icons.access_time_sharp, 'label':'time'},
    {'icon': Icons.add_comment, 'label':'Comment'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              'Welcome!!!',
            ),
            Text(
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              'course flutter',
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(70),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 300,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      Positioned(
                        top: -100,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 180,
                          width: 380,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(70),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              //title
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Special For You',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'We recommend the best for you',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                alignment: Alignment.bottomLeft,
                                margin: const EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProductPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text(
                                    'Lihat Produk',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      //ini bagian title topics
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        margin: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          'Topics',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      //ini bagian card topics
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 12,
                          children: fitures.map((feature) {
                            return SizedBox(
                              width: (MediaQuery.of(context).size.width - 40)/4 - 8,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.withAlpha(30),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(12),

                                    child: Icon(
                                      feature['icon'],
                                      color: Colors.deepPurple,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    feature['label'],
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

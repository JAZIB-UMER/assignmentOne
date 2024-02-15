import 'package:assignment/apis/model_data.dart';
import 'package:assignment/apis/services_api.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ApisScreen extends StatefulWidget {
  const ApisScreen({super.key});

  @override
  State<ApisScreen> createState() => _ApisScreenState();
}

class _ApisScreenState extends State<ApisScreen> {
  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: const Text('Apis Screen',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<PrayerModel>(
              future: ServicesApis.getPrayerData(),
              builder: (context, AsyncSnapshot<PrayerModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Lottie.asset(
                          'assets/animations/Animation - 1705657389604.json'),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error: Failed To load Data'),
                  );
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Text('No data available'),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: height * 0.2,
                          width: width * 0.8,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.deepPurple),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'DATE : ${snapshot.data!.data[index].date.readable}'),
                                ],
                              ),
                              ListTile(
                                title: const Text('Fajr'),
                                trailing: Text(
                                    snapshot.data!.data[index].timings.fajr),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              ListTile(
                                title: const Text('Zuhur'),
                                trailing: Text(
                                    snapshot.data!.data[index].timings.dhuhr),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              ListTile(
                                title: const Text('Asar'),
                                trailing: Text(
                                    snapshot.data!.data[index].timings.asr),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              ListTile(
                                title: const Text('Maghrib'),
                                trailing: Text(
                                    snapshot.data!.data[index].timings.maghrib),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              ListTile(
                                title: const Text('Isha'),
                                trailing: Text(
                                    snapshot.data!.data[index].timings.isha),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );
                        // ListTile(
                        //   title: Text(snapshot.data!.data[index].timings.fajr),
                        // );
                      });
                }
              }),
        ));
  }
}

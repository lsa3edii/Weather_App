import 'package:flutter/material.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
// import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Weather? weather;

  // void updateUI() {
  //   setState(() {
  //     Provider.of<WeatherProvider>(context).weatherData = getWeather(Provider.of<WeatherProvider>(context).weatherData!.location);
  // });
  // }

  // Future<void> handlerRefresh() async {
  //   await Future.delayed(const Duration(seconds: 1));
  // }

  @override // use provider and notify to solve rebuild app
  Widget build(BuildContext context) {
    WeatherModel? weatherData =
        Provider.of<WeatherProvider>(context).weatherData;

    dynamic date = weatherData?.date;
    dynamic time;
    if (weatherData != null) {
      time = date.split(' ')[1];
      date = date.split(' ')[0];
    } else {
      date = '??';
      time = '??';
    }

    List<Widget> getforcasts() {
      List<Widget> items = [];
      if (weatherData != null) {
        for (int i = 0; i <= weatherData.getForcastDays().length; i++) {
          items.add(Text(
            '${weatherData.getForcastDays()[0][i]} ->   Avg : ${weatherData.getForcastDays()[1][i].toInt()}°    Max : ${weatherData.getForcastDays()[2][i].toInt()}°    Min : ${weatherData.getForcastDays()[3][i].toInt()}°',
            style: const TextStyle(
                fontSize: 17,
                // fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico'),
          ));
        }
      }
      return items;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Search();
              }));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                ////////////////////////
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        title: const Text(
          'Weather App',
          style: TextStyle(fontSize: 25, fontFamily: 'Pacifico'),
        ),
      ),
      // backgroundColor: weatherData?.getColor()[200],
      body: weatherData == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'there is no weather',
                    style: TextStyle(fontSize: 35, fontFamily: 'Pacifico'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (constext) {
                        return Search();
                      }));
                    },
                    child: const Text(
                      'start searching now  🔍',
                      style: TextStyle(fontSize: 25, fontFamily: 'Pacifico'),
                    ),
                  ),
                ],
              ),
            )

          //LiquidPullToRefresh(
          //onRefresh: handlerRefresh,
          // child: ListView(children: [

          : Container(
              // margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  // default weatherData.getColor()[500]!
                  weatherData.getColor(),
                  weatherData.getColor()[100]!,
                  weatherData.getColor(),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    weatherData!.location ?? 'City',
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico'),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico'),
                  ),
                  Text(
                    'Updated at : $time',
                    style: const TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      weatherData.condition,
                      style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico'),
                    ),
                  ),
                  // const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(weatherData.getImage()),
                      Text(
                        '${weatherData.currentTemp.toInt()}°',
                        style: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico'),
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('Avg : ',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Pacifico')),
                              Text('${weatherData.avgTemp.toInt()}°',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Pacifico')),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Max : ',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Pacifico')),
                              Text('${weatherData.maxTemp.toInt()}°',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Pacifico')),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Min : ',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Pacifico')),
                              Text('${weatherData.minTemp.toInt()}°',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Pacifico')),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: getforcasts()[0],
                  ),
                  getforcasts()[1],
                  getforcasts()[2],
                  getforcasts()[3],
                  getforcasts()[4],

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 35),
                  //   child: ListView.builder(
                  //     itemCount: weatherData.getForcastDays().length,
                  //     itemBuilder: (context, i) {
                  //       return getforcasts()[i];
                  //     },
                  //   ),
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 35),
                  //   child: Text(
                  //     '${weatherData.getForcastDays()[0][0]} ->   Avg : ${weatherData.getForcastDays()[1][0].toInt()}°    Max : ${weatherData.getForcastDays()[2][0].toInt()}°    Min : ${weatherData.getForcastDays()[3][0].toInt()}°',
                  //     style: const TextStyle(
                  //         fontSize: 17,
                  //         // fontWeight: FontWeight.bold,
                  //         fontFamily: 'Pacifico'),
                  //   ),
                  // ),
                  // Text(
                  //   '${weatherData.getForcastDays()[0][1]} ->   Avg : ${weatherData.getForcastDays()[1][1].toInt()}°    Max : ${weatherData.getForcastDays()[2][1].toInt()}°    Min : ${weatherData.getForcastDays()[3][1].toInt()}°',
                  //   style: const TextStyle(
                  //       fontSize: 17,
                  //       // fontWeight: FontWeight.bold,
                  //       fontFamily: 'Pacifico'),
                  // ),
                  // Text(
                  //   '${weatherData.getForcastDays()[0][2]} ->   Avg : ${weatherData.getForcastDays()[1][2].toInt()}°    Max : ${weatherData.getForcastDays()[2][2].toInt()}°    Min : ${weatherData.getForcastDays()[3][2].toInt()}°',
                  //   style: const TextStyle(
                  //       fontSize: 17,
                  //       // fontWeight: FontWeight.bold,
                  //       fontFamily: 'Pacifico'),
                  // ),
                  // Text(
                  //   '${weatherData.getForcastDays()[0][3]} ->   Avg : ${weatherData.getForcastDays()[1][3].toInt()}°    Max : ${weatherData.getForcastDays()[2][3].toInt()}°    Min : ${weatherData.getForcastDays()[3][3].toInt()}°',
                  //   style: const TextStyle(
                  //       fontSize: 17,
                  //       // fontWeight: FontWeight.bold,
                  //       fontFamily: 'Pacifico'),
                  // ),
                  // Text(
                  //   '${weatherData.getForcastDays()[0][4]} ->   Avg : ${weatherData.getForcastDays()[1][4].toInt()}°    Max : ${weatherData.getForcastDays()[2][4].toInt()}°    Min : ${weatherData.getForcastDays()[3][4].toInt()}°',
                  //   style: const TextStyle(
                  //       fontSize: 17,
                  //       // fontWeight: FontWeight.bold,
                  //       fontFamily: 'Pacifico'),
                  // ),

                  const Spacer(flex: 1),
                ],
              ),
            ),
    );
  }
}

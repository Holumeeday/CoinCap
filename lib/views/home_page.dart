import 'package:flutter/material.dart';
import 'package:new_api/services/remote_service.dart';

import '../models/coinlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic coinData;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

// assign what is returned from the getCoins method here to the apiResponse
// and store it in the coin data variable
  void getData() async {
    var apiResponse = await RemoteService.getCoins();
    coinData = apiResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Comments"),
        ),
        body: FutureBuilder<dynamic>(
            future: RemoteService.getCoins(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    /// the problem here was that you returned
                    /// a map of list of map from getCoins()
                    /// and tried to access it as a List of map
                    /// in order to access it as a list of map
                    /// in stead of returning posts i returned posts['data']
                    // final userData = coinData[index];
                    // CoinCap coinPrice = CoinCap(
                    //     id: coinData[index]['id'],
                    //     rank: coinData[index]['rank'],
                    //     symbol: coinData[index]['symbol'],
                    //     name: coinData[index]['name'],
                    //     supply: coinData[index]['supply'],
                    //     maxSupply: coinData[index]['maxSupply'],
                    //     marketCapUsd: coinData[index]['marketCapUsd'],
                    //     volumeUsd24Hr: coinData[index]['volumeUsd24Hr'],
                    //     priceUsd: coinData[index]['priceUsd'],
                    //     changePercent24Hr: coinData[index]['changePercent24Hr'],
                    //     vwap24Hr: coinData[index]['vwap24Hr']);

                    return Container(
                      padding: const EdgeInsets.all(15),
                      color: Colors.pinkAccent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            /// because we have tapped into the ['data'] property from the api
                            /// all we need to tap into now is the index in the list and the
                            /// property we need from the map
                            coinData[index]['name'].toString(),

                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(coinData[index]['id'].toString())
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.green,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              );
            }));
  }
}

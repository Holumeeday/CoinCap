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

  void getData()async{
    var apiResponse = RemoteService.getCoins();
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
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.separated(
                itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    final userData = coinData[index];

                    CoinCap coinPrice = CoinCap(
                        id: coinData[index]['id'],
                        rank: coinData[index]['rank'],
                        symbol: coinData[index]['symbol'],
                        name: coinData[index]['name'],
                        supply: coinData[index]['supply'],
                        maxSupply: coinData[index]['maxSupply'],
                        marketCapUsd: coinData[index]['marketCapUsd'],
                        volumeUsd24Hr: coinData[index]['volumeUsd24Hr'],
                        priceUsd: coinData[index]['priceUsd'],
                        changePercent24Hr: coinData[index]['changePercent24Hr'],
                        vwap24Hr: coinData[index]['vwap24Hr']
                    );

                    return Container(
                      padding: const EdgeInsets.all(15),
                      color: Colors.pinkAccent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(coinPrice.name, style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,

                          ),),
                          SizedBox(height: 5,),
                          Text(coinData[index]['id'])

                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index){
                    return const Divider(
                      color: Colors.green,
                    );
                  },
              );
            }else if(snapshot.hasError){
              return Text('${snapshot.error}');
            }
            return Center(
              child: const CircularProgressIndicator(
                color: Colors.pink,
              ),
            );
          })

    );
}
}

import 'package:flutter/material.dart';
import 'package:rex_currency_app/components/anyToAny.dart';
import 'package:rex_currency_app/components/idrToAny.dart';
// import 'package:glassmorphism/glassmorphism.dart';
import 'package:rex_currency_app/functions/fetch_api.dart';
import 'package:rex_currency_app/models/rate_model.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  late Future<RateModel> rateModel;
  late Future<Map> currencyModel;

  Future<void> _fetchData() async {
    rateModel = fetchRate();
    currencyModel = fetchCurrency();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var setH = MediaQuery.of(context).size.height;
    var setW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 35, 35, 35),
        title: const Text(
          'Rex Currency Converter',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Aksi untuk menu overflow
            },
          ),
        ],
      ),
      body: Container(
        height: setH,
        width: setW,
        padding: const EdgeInsets.only(top: 65, left: 15, right: 15),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-dark.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: FutureBuilder<RateModel>(
                future: rateModel,
                builder: (context, rateSnapshot) {
                  if (rateSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(
                    child: FutureBuilder<Map>(
                        future: currencyModel,
                        builder: (context, currenSnapshot) {
                          if (currenSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Column(
                            children: [
                              IdrToAny(
                                  rate: rateSnapshot.data?.rate,
                                  currency: currenSnapshot.data!),
                              const SizedBox(
                                height: 75,
                              ),
                              AnyToAny(
                                  rate: rateSnapshot.data?.rate,
                                  currency: currenSnapshot.data!),
                            ],
                          );
                        }),
                  );
                  // if ()
                }),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
Color cobalt = const Color.fromRGBO(0, 71, 171, 10);
Color palePink = const Color.fromRGBO(250, 218, 221, 10);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int Allprice=0;

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;


  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = PET_DATA;
    List<Widget> listItems = [];

    responseList.forEach((post) {
      void _addValue() {
        setState(() {
          Allprice = Allprice+ post["price"] ;

        });
      }
      void _removeValue() {
        setState(() {
          Allprice = Allprice- post["price"] ;
          if (Allprice<=0){
            Allprice=0;
          }
        });
      }
      listItems.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post["name"],
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      " ${post["price"]} Baht",
                      style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: (){
                            _addValue();
                            print(Allprice);
                          },

                        ),

                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: (){
                            _removeValue();
                            print(Allprice);
                          },
                        ),
                      ],
                    )
                  ],
                ),
                Image.asset(
                  "assets/images/${post["image"]}",
                  height: 100,
                  
                )
              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //final double categoryHeight = size.height*0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor:palePink,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: cobalt,
          title: Text('Pet Store'),
          leading: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Menu",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text('All price = $Allprice baht',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              
              Expanded(
                  child: ListView.builder(
                    
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                    
                      return itemsData[index];
                      })),
            ],
          ),
        ),
      ),
    );
  }
}


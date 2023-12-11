import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import "package:latlong2/latlong.dart" as latLng;

enum SocialMedia { facebook, twitter, instagram, linkedIn, youtube }

final String mapUrl =
    'https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d244.73792688338006!2d77.06215858834325!3d11.053104845283647!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ba8574cc158acfd%3A0x8ac671e4d25b5d1c!2sDr.%20Kishor%E2%80%99s%20Dentistry%20%7C%20Diamond%20Invisalign%20Provider%20in%20Coimbatore!5e0!3m2!1sen!2sin!4v1702038735107!5m2!1sen!2sin';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,

      home: MyTile(),
    );
  }
}

class MyTile extends StatefulWidget {
  const MyTile({Key? key}) : super(key: key);

  @override
  State<MyTile> createState() => _MyTile();
}

class _MyTile extends State<MyTile> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  int step = 1;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController referController = TextEditingController();
  String selectedAge = '';
  String selectedGender = '';
  ByteData _img = ByteData(0);
  var color = Colors.black;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  final List<String> genderItems = [
    " ",
    "Male",
    "Female",
    "Others",
  ];
  List<String> ageItems = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "50",
    "51",
    "52",
    "53",
    "54",
    "55",
    "56",
    "57",
    "58",
    "59",
    "60",
    "61",
    "62",
    "63",
    "64",
    "65",
    "66",
    "67",
    "68",
    "69",
    "70",
    "71",
    "72",
    "73",
    "74",
    "75",
    "76",
    "77",
    "78",
    "79",
    "80",
    "81",
    "82",
    "83",
    "84",
    "85",
    "86",
    "87",
    "88",
    "89",
    "90",
    "91",
    "92",
    "93",
    "94",
    "95",
    "96",
    "97",
    "98",
    "99",
    "100"
  ];

  bool painChecked = false;
  bool alignChecked = false;
  bool missingChecked = false;
  bool othersChecked = false;
  bool checkboxesReadOnly = false;

  bool hasDiabetes = false;
  bool hasOthers = false;
  bool hasHighBP = false;
  bool hasAllergies = false;
  bool takesAspirin = false;
  bool isPregnant = false;
  bool hasCardiacProblem = false;
  bool hasGastricUlcer = false;
  bool hasThyroidProblem = false;
  bool hasHepatitis = false;
  bool hasAsthma = false;

  bool Implant = false;
  bool invisalign = false;
  bool Braces = false;
  bool rootcanaltreatement = false;
  bool teethwhitening = false;
  bool crownsandbridges = false;
  bool gvmsurgery = false;
  bool filling = false;
  bool wisdomtoothextraction = false;
  bool othertreatment = false;
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();

    // Initialize the camera controller
    availableCameras().then((cameras) {
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the camera controller when the widget is disposed
    _cameraController.dispose();
    super.dispose();
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

/*  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFFFAC455), // Color for the header
            accentColor: Color(0xFFFAC455), // Color for the buttons
            colorScheme: ColorScheme.light(
              primary: Color(0xFFFAC455), // Color for the selected date
              onPrimary: Colors.black, // Text color for the selected date
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }*/
  // DateTime _selectedDate = DateTime.now();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1956),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFFFAC455),
            accentColor: const Color(0xFFFAC455),
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFAC455),
              onPrimary: Colors.black,
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: Builder(
            builder: (BuildContext context) {
              return Transform.scale(
                scale: 4.00,
                child: child!,
              );
            },
          ),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /* String _formatDate(DateTime? date) {
    return date != null ? DateFormat('yyyy-MM-dd').format(date) : 'Select date';
  }*/

  Future<void> _selectDates(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1956),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFFFAC455), // Color for the header
            accentColor: const Color(0xFFFAC455), // Color for the buttons
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFAC455), // Color for the selected date
              onPrimary: Colors.black, // Text color for the selected date
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: Builder(
            builder: (BuildContext context) {
              return Transform.scale(
                scale: 4.00, // 33% bigger
                child: child!,
              );
            },
          ),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /* Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: 14000.0, // Set the desired width
          height: 18000.0, // Set the desired height
          child: Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(0xFFFAC455),
              accentColor: Color(0xFFFAC455),
              colorScheme: ColorScheme.light(
                primary: Color(0xFFFAC455),
                onPrimary: Colors.black,
              ),
              buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }*/

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";
  }

  void _handleCheckboxChange(bool? value, String checkboxType) {
    setState(() {
      switch (checkboxType) {
        case 'pain':
          painChecked = value ?? false;

          break;
        case 'align':
          alignChecked = value ?? false;

          break;
        case 'missing':
          missingChecked = value ?? false;

          break;
        case 'others':
          othersChecked = value ?? false;

          break;
        case 'bp':
          hasHighBP = value ?? false;

          break;
        case 'hepat':
          hasHepatitis = value ?? false;

          break;
        case 'asthma':
          hasAsthma = value ?? false;

          break;

        case 'diabetes':
          hasDiabetes = value ?? false;

          break;
        case 'cardiac':
          hasCardiacProblem = value ?? false;

          break;
        case 'ulcer':
          hasGastricUlcer = value ?? false;

          break;

        case 'diabetes':
          hasDiabetes = value ?? false;

          break;
        case 'cardiac':
          hasCardiacProblem = value ?? false;

          break;
        case 'ulcer':
          hasGastricUlcer = value ?? false;

          break;

        case 'thyroid':
          hasThyroidProblem = value ?? false;

          break;
        case 'otherproblem':
          hasOthers = value ?? false;

          break;

        case 'allergies':
          hasAllergies = value ?? false;

          break;
        case 'pregnant':
          isPregnant = value ?? false;

          break;
        case 'aspirin':
          takesAspirin = value ?? false;

          break;

        case 'implant':
          Implant = value ?? false;

          break;
        case 'invisalign':
          invisalign = value ?? false;

          break;
        case 'brace':
          Braces = value ?? false;

          break;
        case 'rootcanaltreatement':
          rootcanaltreatement = value ?? false;

          break;
        case 'teethwhitening':
          teethwhitening = value ?? false;

          break;
        case 'crownsandbridges':
          crownsandbridges = value ?? false;

          break;
        case 'gvmsurgery':
          gvmsurgery = value ?? false;

          break;
        case 'filling':
          filling = value ?? false;

          break;
        case 'wisdomtoothextraction':
          wisdomtoothextraction = value ?? false;

          break;
        case 'othertreatment':
          othertreatment = value ?? false;

          break;
      }

      checkboxesReadOnly = false; // Allow selecting at least one checkbox
    });
  }
/*
  Widget _buildCheckbox(String label, String imagePath, bool checked,
      void Function(bool?)? onChanged) {
    return GestureDetector(
      onTap: () {
        // Handle selection logic here
        if (onChanged != null) {
          onChanged(!checked);
        }
      },
      child: Container(
        color: Colors.black,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 50),
                Transform.scale(
                  scale: 4.0,
                  child: Checkbox(
                    value: checked,
                    onChanged: onChanged,
                    activeColor: Colors.indigo[500],
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(
                      (states) => states.contains(MaterialState.selected)
                          ? Colors.indigo[500]
                          : Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                    width: 40), // Adjust the space between checkbox and text
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 75.0, // Adjust the font size as needed
                    //fontFamily: "Noto",
                    color: Colors.yellow[500],
                  ),
                ),
              ],
            ),
            Container(
              child: Image.asset(
                imagePath.isEmpty ? 'images/pat3.jpg' : imagePath,
                alignment: Alignment.centerLeft,
                width: 275,
                height: 275,
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  Widget _buildCheckbox(String label, String imagePath, bool checked,
      void Function(bool?)? onChanged) {
    return GestureDetector(
      onTap: () {
        // Handle selection logic here
        if (onChanged != null) {
          onChanged(!checked);
        }
      },
      child: Container(
        color: Colors.black,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Container(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: checked ? Colors.white : Colors.transparent,
                  border: Border.all(
                    color: checked ? Colors.white : Colors.transparent,
                    width: checked
                        ? 4.0
                        : 0.0, // Adjust the width for the thicker border when checked
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // You can adjust the border radius as needed
                ),
                child: Image.asset(
                  imagePath.isEmpty ? 'images/pat3.jpg' : imagePath,
                  alignment: Alignment.centerLeft,
                  width: 300,
                  height: 300,
                ),
              ),
            ),*/
            /*Container(
              child: Stack(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: checked ? Colors.white : Colors.transparent,
                      border: Border.all(
                        color: checked ? Colors.white : Colors.transparent,
                        width: checked ? 4.0 : 0.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.asset(
                      imagePath.isEmpty ? 'images/pat3.jpg' : imagePath,
                      alignment: Alignment.centerLeft,
                      width: 300,
                      height: 300,
                    ),
                  ),
                  if (checked)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Icon(
                        Icons.check,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                ],
              ),
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Stack(
                    children: [
                      // Original photo with white border
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: checked ? Colors.white : Colors.transparent,
                          border: Border.all(
                            color:
                                checked ? Color(0xFFFAC455) : Color(0xFFFAC455),
                            width: checked ? 8.0 : 8.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image.asset(
                            imagePath.isEmpty ? 'images/pat3.jpg' : imagePath,
                            alignment: Alignment.centerLeft,
                            width: 400,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Yellow border
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(
                                0xFFFAC455), // Change to your preferred color
                            width: 300.0, // Adjust the border width as needed
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      // Additional attractive designs or decorations
                      // Add your own widgets or designs here as needed

                      // Check icon (positioned on top if checked)
                      if (checked)
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Icon(
                            Icons.check,
                            color: Color(0xFFFAC455),
                            size: 300,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*SizedBox(width: 50),
                Transform.scale(
                  scale: 4.0,
                  child: Checkbox(
                    value: checked,
                    onChanged: onChanged,
                    activeColor: Colors.indigo[500],
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(
                      (states) => states.contains(MaterialState.selected)
                          ? Colors.indigo[500]
                          : Colors.white,
                    ),
                  ),
                ),*/
                /*  SizedBox(
                    width: 60),*/ // Adjust the space between checkbox and text
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 90.0, // Adjust the font size as needed
                    //fontFamily: "Noto",
                    color: Color(0xFFFAC455),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /*Widget _buildCheckbox(String label, String imagePath, bool checked,
      void Function(bool?)? onChanged) {
    return GestureDetector(
      onTap: () {
        // Handle selection logic here
        if (onChanged != null) {
          onChanged(!checked);
        }
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 50),
                Container(
                  width: 275,
                  height: 275,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        imagePath.isEmpty ? 'images/pat3.jpg' : imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: checked ? Colors.black.withOpacity(0.5) : null,
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 75.0, // Adjust the font size as needed
                        //fontFamily: "Noto",
                        color: Colors.yellow[500],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Transform.scale(
              scale: 4.0,
              child: Checkbox(
                value: checked,
                onChanged: onChanged,
                activeColor: Colors.indigo[500],
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(
                  (states) => states.contains(MaterialState.selected)
                      ? Colors.indigo[500]
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  /*Widget _buildCheckbox(String label, String imagePath, bool checked,
      void Function(bool?)? onChanged) {
    return GestureDetector(
      onTap: () {
        // Handle selection logic here
        if (onChanged != null) {
          onChanged(!checked);
        }
      },
      child: Container(
        color: Colors.black,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 50),
                Transform.scale(
                  scale: 4.0,
                  child: Checkbox(
                    value: checked,
                    onChanged: onChanged,
                    activeColor: Colors.indigo[500],
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(
                      (states) => states.contains(MaterialState.selected)
                          ? Colors.indigo[500]
                          : Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 50),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 75.0,
                    //fontFamily: "Noto",
                    color: Colors.yellow[500],
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.purple,
              child: Image.asset(
                imagePath.isEmpty ? 'images/pat3.jpg' : imagePath,
                alignment: Alignment.centerLeft,
                width: 275,
                height: 275,
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  final String mapUrl =
      'https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d244.73792688338006!2d77.06215858834325!3d11.053104845283647!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ba8574cc158acfd%3A0x8ac671e4d25b5d1c!2sDr.%20Kishor%E2%80%99s%20Dentistry%20%7C%20Diamond%20Invisalign%20Provider%20in%20Coimbatore!5e0!3m2!1sen!2sin!4v1702038735107!5m2!1sen!2sin';

  /*void _showLocationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Dr. Kishor’s Dentistry'),
          content: Container(
            width: 300,
            height: 300,
            child: Image.asset(
              'images/qr_gold.png',
              alignment: Alignment.centerLeft,
              width: 275,
              height: 275,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }*/

  void _showLocationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Transform.scale(
          scale: 5,
          child: AlertDialog(
            backgroundColor: Colors.black,
            title: Text("DR. KISHOR'S INVISALIGN CENTRE- COIMBATORE"),
            content: Container(
              color: Color(0xFFFAC455),
              width: 450,
              height: 300,
              child: FlutterMap(
                options: MapOptions(
                  center: latLng.LatLng(11.052968, 77.062259),
                  zoom: 14.2,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 40,
                        height: 40,
                        point: latLng.LatLng(11.052968, 77.062259),
                        builder: (ctx) => Container(
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Color(0xFFFAC455),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  SocialMedia selectedSocialMedia = SocialMedia.facebook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                color: Colors.black,
                height: 530,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 180),
                    Image.asset(
                      'images/Kishore-Logo.png',
                      height: 500,
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                        width: 200), // Add some space between logo and text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "DR. KISHOR'S DENTISTRY",
                          style: TextStyle(
                            color: Color(0xFFFAC455),
                            fontSize: 150.0,
                            fontFamily: 'RozhaOne',
                          ),
                        ),
                        Text(
                          "India's Leading Diamond Invisalign Provider",
                          style: TextStyle(
                            color: Color(0xFFFAC455),
                            fontSize: 75.0,
                            fontFamily: 'RozhaOne',
                          ),
                        ),
                        Text(
                          '"One Stop Solution for all your Dental needs"',
                          style: TextStyle(
                            color: Color(0xFFFAC455),
                            fontSize: 50.0,
                            fontFamily: 'RozhaOne',
                          ),
                        ),
                        Text(
                          ' Bengaluru | Chennai | Coimbatore | Tiruppur',
                          style: TextStyle(
                            color: Color(0xFFFAC455),
                            fontSize: 60.0,
                            fontFamily: 'RozhaOne',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 120),

                    /*Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showLocationPopup(context);
                        },
                        icon: Icon(
                          Icons.location_on,
                          size: 200,
                          color: Color(0xFFFAC455),
                        ), // Replace 'icon' with the actual icon you want to use
                        label: Text(
                            ''), // Replace 'label' with the actual label you want to use
                      ),
                    )*/
                    Container(
                      width: 500,
                      height: 362,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFFACD), Color(0xFFFFE4B5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFFAC455),
                            spreadRadius: 12,
                            blurRadius: 7,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          'images/south_pin.png',
                          fit: BoxFit.cover,
                          height: 360,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),

                    SizedBox(width: 50),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add onPressed logic for Instagram button
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFFAC455),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Follow us ',
                                          style: TextStyle(
                                            fontSize: 60,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          SocialIconsFlutter.instagram,
                                          size: 60,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    'images/social.png',
                                    height: 300,
                                    alignment: Alignment.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    /*   Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Add onPressed logic for Instagram button
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFAC455),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Follow us on',
                                      style: TextStyle(
                                        fontSize: 100,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      SocialIconsFlutter.instagram,
                                      size: 100,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  // Add onPressed logic for Facebook button
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFAC455),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Follow us on',
                                      style: TextStyle(
                                        fontSize: 100,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      SocialIconsFlutter.facebook,
                                      size: 100,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  // Add onPressed logic for YouTube button
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFAC455),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Follow us on',
                                      style: TextStyle(
                                        fontSize: 100,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      SocialIconsFlutter.youtube,
                                      size: 100,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black,
                      Colors.black,
                    ],
                  ),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height - 580,
                  child: Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      transform: Matrix4.translationValues(
                        0.0,
                        -MediaQuery.of(context).size.height * (step - 1) +
                            100.0,
                        0.0,
                      )..translate(
                          0.0,
                          MediaQuery.of(context).size.height * (step - 1) -
                              100.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Dental-themed image or logo

                            // list of previous days
                            if (step == 1)
                              TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Your Full Name',
                                  icon: Icon(
                                    Icons.person,
                                    color: Color(0xFFFAC455),
                                    size: 175,
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 150,
                                    color: Color(0xFFFAC455),
                                  ), // Set the font size for the label
                                  /* hintStyle: TextStyle(
                                fontSize: 150,
                                color: Color(0xFFFAC455),
                              ),*/ // Set the font size for the input text
                                ),
                                style: TextStyle(
                                    //fontFamily: "Noto",
                                    color: Color(0xFFFAC455),
                                    fontSize:
                                        150), // Set the font size for the entered text
                              ),

                            if (step == 2)
                              TextFormField(
                                controller: mobileController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Enter Your Mobile No.',
                                  icon: Icon(
                                    Icons.phone,
                                    color: Color(0xFFFAC455),
                                    size: 175,
                                  ),
                                  /* labelStyle: TextStyle(
                                fontSize: 150,
                                //fontFamily: "Noto",
                                color: Color(0xFFFAC455),
                              ), */ // Set the font size for the label
                                  labelStyle: TextStyle(
                                    fontSize: 150,
                                    //fontFamily: "Noto",
                                    color: Color(0xFFFAC455),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 150,
                                  //fontFamily: "Noto",
                                  color: Color(0xFFFAC455),
                                ),
                              ),

                            if (step == 3)
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black45),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: Colors.black45,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 30, horizontal: 20),
                                    ),
                                    hint: Text(
                                      'Select Your Gender',
                                      style: TextStyle(
                                        fontSize: 125,
                                        //fontFamily: "Noto",
                                        color: Color(0xFFFAC455),
                                      ),
                                    ),
                                    items: genderItems
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 150,
                                                  //fontFamily: "Noto",
                                                  color: Color(0xFFFAC455),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select gender.';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      // Do something when selected item is changed.
                                    },
                                    onSaved: (value) {
                                      selectedGender = value.toString();
                                    },
                                    style: TextStyle(
                                      fontSize: 180,
                                      //fontFamily: "Noto",
                                      color: Color(0xFFFAC455),
                                    ),
                                  ),
                                ),
                              ),

                            if (step == 4)
                              /*DropdownButtonFormField<String>(
                                dropdownColor: Colors.black45,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  // Add Horizontal padding using menuItemStyleData.padding so it matches
                                  // the menu padding when the button's width is not specified.
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  // Add more decoration..
                                ),
                                hint: Text(
                                  'Select Your Age',
                                  style: TextStyle(
                                    fontSize: 125,
                                    //fontFamily: "Noto",
                                    color: Color(0xFFFAC455),
                                  ),
                                ),
                                items: ageItems
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: 150,
                                              //fontFamily: "Noto",
                                              color: Color(0xFFFAC455),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select Age';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // Do something when the selected item is changed.
                                },
                                onSaved: (value) {
                                  selectedAge = value.toString();
                                },
                                style: TextStyle(
                                  fontSize: 180,
                                  //fontFamily: "Noto",
                                  color: Color(0xFFFAC455),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFFFAC455),
                                  size: 125,
                                ),
                                menuMaxHeight:
                                    1200, // Set the maximum height of the dropdown menu
                                // You can customize more properties as needed.
                              ),*/
                              // Date of Birth TextFields
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  /*Text(
                                    _formatDate(_selectedDate),
                                    style: TextStyle(
                                      fontSize: 180,
                                      //fontFamily: "Noto",
                                      color: Color(0xFFFAC455),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),*/
                                  ElevatedButton(
                                    onPressed: () => _selectDate(context),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                    ),
                                    child: Text(
                                      'Date of Birth: ${_selectedDate == null ? '__/__/____' : _formatDate(_selectedDate!)}',
                                      style: TextStyle(
                                        fontSize: 180,
                                        color: Color(0xFFFAC455),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                            if (step == 5)
                              Text(
                                'Chief Complaint',
                                style: TextStyle(
                                    fontSize: 180.0,
                                    fontFamily: 'Noto',
                                    color: Color(0xFFFAC455),
                                    backgroundColor: Colors.black),
                              ),

                            if (step == 5)
                              Container(
                                width: 1200,
                                margin: EdgeInsets.only(
                                    top: 5.0), // Adjust the margin as needed
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(
                                          0xFFFAC455), // Same color as text
                                      width:
                                          12.0, // Adjust the width of the underline as needed
                                    ),
                                  ),
                                ),
                              ),
                            if (step == 5) SizedBox(height: 200.0),
                            if (step == 5)
                              CupertinoFormSection(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      null, // Set border to null for a borderless appearance
                                ),
                                backgroundColor: Colors.transparent,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildCheckbox(
                                          'Pain',
                                          'images/pain.jpg',
                                          painChecked,
                                          (value) {
                                            _handleCheckboxChange(
                                                value, 'pain');
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                          'Alignment Issue',
                                          'images/align.jpg',
                                          alignChecked,
                                          (value) {
                                            _handleCheckboxChange(
                                                value, 'align');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildCheckbox(
                                          'Missing Tooth',
                                          'images/miss.jpg',
                                          missingChecked,
                                          (value) {
                                            _handleCheckboxChange(
                                                value, 'missing');
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                          'Others',
                                          'images/otherpain.jpg',
                                          othersChecked,
                                          (value) {
                                            _handleCheckboxChange(
                                                value, 'others');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            if (step == 6)
                              Text(
                                'Medical History',
                                style: TextStyle(
                                    fontSize: 180.0,
                                    fontFamily: 'Noto',
                                    color: Color(0xFFFAC455),
                                    backgroundColor: Colors.black),
                              ),
                            if (step == 6)
                              Container(
                                width: 1200,
                                margin: EdgeInsets.only(
                                    top: 5.0), // Adjust the margin as needed
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(
                                          0xFFFAC455), // Same color as text
                                      width:
                                          12.0, // Adjust the width of the underline as needed
                                    ),
                                  ),
                                ),
                              ),
                            if (step == 6)
                              CupertinoFormSection(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      null, // Set border to null for a borderless appearance
                                ),
                                backgroundColor: Colors.transparent,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Diabetes',
                                            'images/h1.jpg',
                                            hasDiabetes, (value) {
                                          _handleCheckboxChange(
                                              value, 'diabetes');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Cardiac Problem',
                                            'images/h2.jpg',
                                            hasCardiacProblem, (value) {
                                          _handleCheckboxChange(
                                              value, 'cardiac');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Gastric Ulcer',
                                            'images/h3.jpg',
                                            hasGastricUlcer, (value) {
                                          _handleCheckboxChange(value, 'ulcer');
                                        }),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildCheckbox(
                                            'High Blood Pressure',
                                            'images/h4.jpg',
                                            hasHighBP, (value) {
                                          _handleCheckboxChange(value, 'bp');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Hepatitis',
                                            'images/h5.jpg',
                                            hasHepatitis, (value) {
                                          _handleCheckboxChange(value, 'hepat');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Asthma',
                                            'images/h6.jpg',
                                            hasAsthma, (value) {
                                          _handleCheckboxChange(
                                              value, 'asthma');
                                        }),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Allergies',
                                            'images/h7.jpg',
                                            hasAllergies, (value) {
                                          _handleCheckboxChange(
                                              value, 'allergies');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Takes Aspirin',
                                            'images/pat1.jpg',
                                            takesAspirin, (value) {
                                          _handleCheckboxChange(
                                              value, 'aspirin');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Pregnancy',
                                            'images/h9.jpg',
                                            isPregnant, (value) {
                                          _handleCheckboxChange(
                                              value, 'pregnant');
                                        }),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Thyroid Problem',
                                            'images/h8.jpg',
                                            hasThyroidProblem, (value) {
                                          _handleCheckboxChange(
                                              value, 'thyroid');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Others', '', hasOthers, (value) {
                                          _handleCheckboxChange(
                                              value, 'otherproblem');
                                        }),
                                      ),
                                      Expanded(
                                        child: Container(
                                            height: 395,
                                            color: Colors.black,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  backgroundColor:
                                                      Colors.black),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            if (step == 7)
                              Text(
                                'Treatment Required',
                                style: TextStyle(
                                    fontSize: 180.0,
                                    fontFamily: 'Noto',
                                    color: Color(0xFFFAC455),
                                    backgroundColor: Colors.black),
                              ),
                            if (step == 7)
                              Container(
                                width: 1200,
                                margin: EdgeInsets.only(
                                    top: 5.0), // Adjust the margin as needed
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(
                                          0xFFFAC455), // Same color as text
                                      width:
                                          12.0, // Adjust the width of the underline as needed
                                    ),
                                  ),
                                ),
                              ),
                            if (step == 7)
                              CupertinoFormSection(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      null, // Set border to null for a borderless appearance
                                ),
                                backgroundColor: Colors.transparent,
                                /*header: Text(
                              'Treatment Required',
                              style: TextStyle(
                                fontSize: 75.0,
                                fontFamily: 'RozhaOne',
                                color:  Color(0xFFFAC455),
                              ),
                            ),*/
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Implant',
                                            'images/trt4.jpg',
                                            Implant, (value) {
                                          _handleCheckboxChange(
                                              value, 'implant');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'invisalign',
                                            'images/trt1.jpg',
                                            invisalign, (value) {
                                          _handleCheckboxChange(
                                              value, 'invisalign');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Braces', 'images/trt6.jpg', Braces,
                                            (value) {
                                          _handleCheckboxChange(
                                              value, 'braces');
                                        }),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Filling',
                                            'images/trt10.jpg',
                                            filling, (value) {
                                          _handleCheckboxChange(
                                              value, 'filling');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Teeth Whitening',
                                            'images/trt12.jpg',
                                            teethwhitening, (value) {
                                          _handleCheckboxChange(
                                              value, 'teethwhitening');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Crowns and Bridges',
                                            'images/trt13.jpg',
                                            crownsandbridges, (value) {
                                          _handleCheckboxChange(
                                              value, 'crownsandbridges');
                                        }),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Gum Surgery',
                                            'images/trt16.jpg',
                                            gvmsurgery, (value) {
                                          _handleCheckboxChange(
                                              value, 'gvmsurgery');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Takes Aspirin',
                                            'images/pat1.jpg',
                                            takesAspirin, (value) {
                                          _handleCheckboxChange(
                                              value, 'aspirin');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Root Canal Repair',
                                            'images/trt18.jpg',
                                            rootcanaltreatement, (value) {
                                          _handleCheckboxChange(
                                              value, 'rootcanaltreatement');
                                        }),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Tooth Extraction',
                                            'images/trt20.jpg',
                                            wisdomtoothextraction, (value) {
                                          _handleCheckboxChange(
                                              value, 'wisdomtoothextraction');
                                        }),
                                      ),
                                      Expanded(
                                        child: _buildCheckbox(
                                            'Others', '', othertreatment,
                                            (value) {
                                          _handleCheckboxChange(
                                              value, 'othertreatment');
                                        }),
                                      ),
                                      Expanded(
                                        child: Container(
                                            height: 395,
                                            color: Colors.black,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  backgroundColor:
                                                      Colors.black),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            if (step == 8)
                              TextFormField(
                                controller: referController,
                                decoration: InputDecoration(
                                  labelText: 'Refered by...,',
                                  icon: Icon(
                                    Icons.document_scanner_rounded,
                                    color: Color(0xFFFAC455),
                                    size: 175,
                                  ),
                                  /* labelStyle: TextStyle(
                                fontSize: 150,
                                //fontFamily: "Noto",
                                color: Color(0xFFFAC455),
                              ), */ // Set the font size for the label
                                  labelStyle: TextStyle(
                                    fontSize: 150,
                                    //fontFamily: "Noto",
                                    color: Color(0xFFFAC455),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 150,
                                  //fontFamily: "Noto",
                                  color: Color(0xFFFAC455),
                                ),
                              ),
                            if (step == 8) SizedBox(height: 500.0),
                            if (step == 9)
                              /*Container(
                                // Add your code for capturing a photo here
                                // You can use a camera plugin or any other method to capture a photo
                                // For example, you can use the camera package:
                                // https://pub.dev/packages/camera
                                // or image_picker package:
                                // https://pub.dev/packages/image_picker
                                child: Text(
                                  'Capture a Photo',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )*/
                              Container(
                                color: Colors
                                    .black, // Adjust the background color as needed
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /*CameraPreview(
                                      // Set up the camera preview
                                      _cameraController, // You need to initialize a CameraController
                                    ),*/
                                    Text(
                                      'self-portrait',
                                      style: TextStyle(
                                        fontSize: 150,
                                        //fontFamily: "Noto",
                                        color: Color(0xFFFAC455),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      width: 1000,
                                      height: 800,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors
                                              .black, // You can adjust the border color as needed
                                          width:
                                              2.0, // You can adjust the border width as needed
                                        ),
                                      ),
                                      // Add child widgets or leave it empty based on your needs
                                    ),
                                    SizedBox(height: 16.0),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(20),
                                        textStyle: TextStyle(fontSize: 100),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                          ),
                                        ),
                                        elevation: 80,
                                        primary: Color(0xFFFAC455),
                                      ),
                                      onPressed: () {
                                        // Add logic to capture the photo here
                                        // You can use the takePicture method of the camera controller
                                      },
                                      child: Text(
                                        'Capture Photo',
                                        style: TextStyle(
                                          fontSize: 150,
                                          //fontFamily: "Noto",
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            if (step == 10)
                              Text(
                                'Signature',
                                style: TextStyle(
                                    fontSize: 150.0,
                                    fontFamily: 'RozhaOne',
                                    color: Color(0xFFFAC455),
                                    backgroundColor: Colors.black),
                              ),

                            if (step == 10)
                              Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                            height: 1020,
                                            child: SfSignaturePad(
                                                key: signatureGlobalKey,
                                                backgroundColor: Colors.black,
                                                strokeColor: Colors.white,
                                                minimumStrokeWidth: 10.0,
                                                maximumStrokeWidth: 40.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white)))),
                                    SizedBox(height: 10),
                                    Row(
                                        children: <Widget>[
                                          TextButton(
                                            child: Text('ToImage'),
                                            onPressed: _handleSaveButtonPressed,
                                          ),
                                          TextButton(
                                            child: Text('Clear'),
                                            onPressed:
                                                _handleClearButtonPressed,
                                          )
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly)
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center),

                            if (step == 11)
                              Column(
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: Colors.blueAccent,
                                    size: 150,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Thank You!',
                                    style: TextStyle(
                                      fontSize: 200,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(height: 40),
                            Container(
                              width:
                                  800, // Set a specific width for the container
                              child: Container(
                                width: 400,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (step < 11) {
                                        setState(() {
                                          step++;
                                        });
                                      } else {
                                        step = 0;
                                        // Handle the case when step is 9 (survey completed)
                                        // You can navigate to a new screen or perform any other action here.
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(20),
                                      textStyle: TextStyle(fontSize: 100),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      elevation: 80,
                                      primary: Color(0xFFFAC455),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          step == 11 ? 'Complete' : 'Next',
                                          style: TextStyle(
                                            fontSize:
                                                75, // Adjust the font size as needed
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          Icons
                                              .arrow_forward, // Replace with the icon of your choice
                                          size:
                                              75, // Adjust the icon size as needed
                                          color: Colors.black,
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLabelDialog(BuildContext context, String label) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Transform.scale(
          scale: 4.5, // Set the desired scale value
          child: AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              '$label',
              style: TextStyle(
                color: Color(0xFFFAC455),
              ),
            ),
            content: Container(
              width: 150,
              height: 150,
              child: Image.asset(
                'images/social.png',
                width: 15,
                height: 15,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Color(0xFFFAC455),
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

PopupMenuItem<SocialMedia> buildPopupMenuItem(SocialMedia media, String label) {
  return PopupMenuItem<SocialMedia>(
    value: media,
    child: Container(
      color: Colors.black, // Set the background color
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.transparent), // Set border color to transparent
            ),
            child: Icon(
              getIconForSocialMedia(media),
              color: Color(0xFFFAC455),
              size: 200,
            ),
          ),
          /*SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 150,
                color: Color(0xFFFAC455),
              ),
            ),*/
        ],
      ),
    ),
  );
}

IconData getIconForSocialMedia(SocialMedia media) {
  switch (media) {
    case SocialMedia.facebook:
      return Icons.facebook;
    case SocialMedia.twitter:
      return SocialIconsFlutter.twitter;
    case SocialMedia.instagram:
      return SocialIconsFlutter.instagram;
    case SocialMedia.linkedIn:
      return SocialIconsFlutter.linkedin_box;
    case SocialMedia.youtube:
      return SocialIconsFlutter.youtube;
  }
}

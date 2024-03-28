import 'package:csc_picker/csc_picker.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeservice_app/confirm_page.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

class bookingPage extends StatefulWidget {
  const bookingPage({super.key});

  @override
  State<bookingPage> createState() => _bookingPageState();
}

class _bookingPageState extends State<bookingPage> {
  final firstkey = GlobalKey<FormState>();
  final secondkey = GlobalKey<FormState>();
  final thirdkey = GlobalKey<FormState>();
  final fourthkey = GlobalKey<FormState>();
  final fifthkey = GlobalKey<FormState>();

  TextEditingController _datecontroller = TextEditingController();
  TimeOfDay selectedtime = TimeOfDay.now();

  Position? currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String _currentaddress = "";
  Future<Position> getcurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getaddressfromcordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocation!.latitude, currentLocation!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentaddress = '${place.locality}';
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: Text(
            'Add Booking details',
            style: GoogleFonts.aBeeZee(fontSize: 18, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: firstkey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please provide necessary details";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Full Name (Required)',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelStyle: GoogleFonts.aBeeZee(
                            color: const Color.fromARGB(255, 114, 114, 114))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: secondkey,
                  child: IntlPhoneField(
                    validator: (value) {
                      if (value == null || value.isValidNumber()) {
                        return "Please provide necessary details";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Phone Number (Required)',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelStyle: GoogleFonts.aBeeZee(
                            color: const Color.fromARGB(255, 114, 114, 114))),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CSCPicker(
                  layout: Layout.horizontal,
                  flagState: CountryFlag.ENABLE,
                  onCountryChanged: (Country) {
                    _currentaddress;
                  },
                  onStateChanged: (State) {},
                  onCityChanged: (City) {},
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: fifthkey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please provide necessary details";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Pincode',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelStyle: GoogleFonts.aBeeZee(
                            color: const Color.fromARGB(255, 114, 114, 114))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: thirdkey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please provide necessary details";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'House no, Building Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelStyle: GoogleFonts.aBeeZee(
                            color: const Color.fromARGB(255, 114, 114, 114))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: fourthkey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please provide necessary details";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Road name, Area,Colony ',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelStyle: GoogleFonts.aBeeZee(
                            color: const Color.fromARGB(255, 114, 114, 114))),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Location Cordinates",
                  style: GoogleFonts.aBeeZee(fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Latitude =${currentLocation?.latitude}; Longitude =${currentLocation?.longitude}",
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Location Address",
                  style: GoogleFonts.aBeeZee(fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${_currentaddress}",
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 160,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                      onPressed: () async {
                        currentLocation = await getcurrentLocation();
                        await _getaddressfromcordinates();
                        print("${currentLocation}");
                        print("${_currentaddress}");
                      },
                      icon: Icon(Icons.gps_fixed),
                      label: Text('Use my location')),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _datecontroller,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_month),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectdate();
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () async {
                          final TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: selectedtime,
                            initialEntryMode: TimePickerEntryMode.dial,
                          );
                          if (timeOfDay != null) {
                            setState(() {
                              selectedtime = timeOfDay;
                            });
                          }
                        },
                        child: Text(
                          "Choose time",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        )),
                    // Text(
                    //   "Time :",
                    //   style: GoogleFonts.montserrat(
                    //       fontSize: 18, fontWeight: FontWeight.bold),
                    // ),

                    Text(
                      ": ${selectedtime.hour}:${selectedtime.minute}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    height: 45,
                    width: 250,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 0,
                            side: BorderSide(color: Colors.black),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          if (firstkey.currentState!.validate()) {
                            if (secondkey.currentState!.validate()) {
                              if (thirdkey.currentState!.validate()) {
                                if (fourthkey.currentState!.validate()) {
                                  if (fifthkey.currentState!.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => nextpage(),
                                        ));
                                  }
                                }
                              }
                            }
                          }
                        },
                        child: Text(
                          'Confirm booking',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _selectdate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        _datecontroller.text = _picked.toString().split(" ")[0];
      });
    }
  }
}

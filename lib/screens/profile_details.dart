

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quickfix_project/profile_screen.dart';
import 'profile_details.dart'; // Make sure UserProfile class includes address field

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _user = UserProfile(
    name: '',
    username: '',
    dob: '',
    gender: '',
    email: '',
    phone: '',
    places: '',
    address: '',
  );

  DateTime? selectedDate;
  String selectedGender = 'Male';

  String? selectedCountry;
  String? selectedState;
  String? selectedDistrict;

  List<String> stateList = [];
  List<String> districtList = [];

  final Map<String, Map<String, List<String>>> countryStateDistrictMap = {
  'India': {
    'Andhra Pradesh': ['Anantapur','Sri Sathya Sai','Chittoor','Tirupati','Kadapa','Nandyal','Kurnool','Prakasam','Ongole','Nellore',
  'Sri Potti Sriramulu Nellore','Guntur','Palnadu','Bapatla','Krishna','NTR','Eluru','West Godavari','East Godavari','Kakinada',
  'Konaseema','Visakhapatnam','Anakapalli','Alluri Sitarama Raju','Vizianagaram','Srikakulam','Parvathipuram Manyam'
],
    'Telangana': [
  'Adilabad',
  'Bhadradri Kothagudem',
  'Hyderabad',
  'Jagtial',
  'Jangaon','Jayashankar Bhupalpally','Jogulamba Gadwal','Kamareddy','Karimnagar','Khammam','Komaram Bheem Asifabad','Mahabubabad','Mahabubnagar','Mancherial','Medak','Medchal Malkajgiri','Mulugu',
  'Nagarkurnool','Nalgonda','Nirmal','Nizamabad','Peddapalli','Rajanna Sircilla','Rangareddy','Sangareddy','Siddipet','Suryapet','Vikarabad','Wanaparthy','Warangal','Hanumakonda','Yadadri Bhuvanagiri','Narayanpet'
],
    'Maharashtra': [
      'Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad',
      'Solapur', 'Thane', 'Amravati', 'Kolhapur', 'Jalgaon'
    ],
    'Karnataka': [
      'Bengaluru', 'Mysuru', 'Hubli', 'Mangalore', 'Belgaum',
      'Davanagere', 'Tumkur', 'Ballari', 'Bidar', 'Shivamogga'
    ],
    'Tamil Nadu': [
      'Chennai', 'Coimbatore', 'Madurai', 'Salem', 'Tiruchirappalli',
      'Tirunelveli', 'Erode', 'Vellore', 'Thoothukudi', 'Dindigul'
    ],
  },

  'USA': {
    'California': [
      'Los Angeles', 'San Francisco', 'San Diego', 'Sacramento', 'San Jose',
      'Fresno', 'Long Beach', 'Oakland', 'Bakersfield', 'Anaheim'
    ],
    'Texas': [
      'Houston', 'Dallas', 'Austin', 'San Antonio', 'El Paso',
      'Fort Worth', 'Arlington', 'Plano', 'Lubbock', 'Irving'
    ],
    'New York': [
      'New York City', 'Buffalo', 'Rochester', 'Albany', 'Syracuse',
      'Yonkers', 'New Rochelle', 'Mount Vernon', 'Utica', 'Schenectady'
    ],
  },

  'Canada': {
    'Ontario': [
      'Toronto', 'Ottawa', 'Mississauga', 'Hamilton', 'London',
      'Brampton', 'Markham', 'Windsor', 'Kitchener', 'Vaughan'
    ],
    'British Columbia': [
      'Vancouver', 'Victoria', 'Surrey', 'Burnaby', 'Richmond',
      'Abbotsford', 'Kelowna', 'Coquitlam', 'Langley', 'Nanaimo'
    ],
  },

  'Australia': {
    'New South Wales': [
      'Sydney', 'Newcastle', 'Wollongong', 'Albury', 'Maitland',
      'Coffs Harbour', 'Tamworth', 'Dubbo', 'Orange', 'Bathurst'
    ],
    'Victoria': [
      'Melbourne', 'Geelong', 'Ballarat', 'Bendigo', 'Shepparton',
      'Warrnambool', 'Mildura', 'Traralgon', 'Wodonga', 'Melton'
    ],
  },

  'UK': {
    'England': [
      'London', 'Manchester', 'Birmingham', 'Liverpool', 'Leeds',
      'Sheffield', 'Bristol', 'Newcastle', 'Nottingham', 'Leicester'
    ],
    'Scotland': [
      'Edinburgh', 'Glasgow', 'Aberdeen', 'Dundee', 'Inverness',
      'Stirling', 'Perth', 'Ayr', 'Falkirk', 'Paisley'
    ],
  },

  'Germany': {
    'Bavaria': [
      'Munich', 'Nuremberg', 'Augsburg', 'Regensburg', 'Ingolstadt',
      'Würzburg', 'Bamberg', 'Passau', 'Bayreuth', 'Landshut'
    ],
    'North Rhine-Westphalia': [
      'Cologne', 'Düsseldorf', 'Dortmund', 'Essen', 'Bonn',
      'Bochum', 'Wuppertal', 'Bielefeld', 'Gelsenkirchen', 'Münster'
    ],
  },

  'France': {
    'Île-de-France': [
      'Paris', 'Versailles', 'Boulogne-Billancourt', 'Saint-Denis', 'Nanterre',
      'Créteil', 'Argenteuil', 'Montreuil', 'Aulnay-sous-Bois', 'Vitry-sur-Seine'
    ],
  },

  'Japan': {
    'Tokyo': [
      'Shinjuku', 'Shibuya', 'Minato', 'Chiyoda', 'Taito',
      'Setagaya', 'Toshima', 'Koto', 'Nerima', 'Meguro'
    ],
    'Osaka': [
      'Osaka City', 'Sakai', 'Hirakata', 'Takatsuki', 'Toyonaka',
      'Matsubara', 'Kadoma', 'Yao', 'Izumi', 'Suita'
    ],
  },

  'Brazil': {
    'São Paulo': [
      'São Paulo City', 'Campinas', 'Santos', 'Ribeirão Preto', 'São José dos Campos',
      'Guarulhos', 'Sorocaba', 'Bauru', 'Jundiaí', 'Mogi das Cruzes'
    ],
    'Rio de Janeiro': [
      'Rio de Janeiro City', 'Niterói', 'Petrópolis', 'Duque de Caxias', 'Nova Iguaçu',
      'Volta Redonda', 'Campos', 'Teresópolis', 'Angra dos Reis', 'Itaboraí'
    ],
  },

  'South Africa': {
    'Gauteng': [
      'Johannesburg', 'Pretoria', 'Soweto', 'Benoni', 'Boksburg',
      'Randburg', 'Sandton', 'Roodepoort', 'Midrand', 'Germiston'
    ],
  },
};

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  InputDecoration _boxInputDecoration(String label, double fontSize) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black87, fontSize: fontSize),
      floatingLabelStyle: TextStyle(
        color: Colors.indigo,
        fontWeight: FontWeight.bold,
        fontSize: fontSize + 2,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      contentPadding:
          EdgeInsets.symmetric(horizontal: fontSize, vertical: fontSize * 0.9),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.indigo, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.indigo, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.04;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.only(top: 40),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, size: 30, color: Colors.grey[700]),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildBoxField("Full Name", (val) => _user.name = val, fontSize),
                        _buildBoxField("Username", (val) => _user.username = val, fontSize),
                        _buildDatePicker(fontSize),
                        _buildGenderSelector(fontSize),
                        _buildBoxField("Email", (val) => _user.email = val, fontSize),
                        _buildBoxField("Phone", (val) => _user.phone = val, fontSize),
                        _buildCountryDropdown(fontSize),
                        _buildStateDropdown(fontSize),
                        _buildDistrictDropdown(fontSize),
                        _buildBoxField("Address", (val) => _user.address = val, fontSize), // ✅ Address field
                        SizedBox(height: size.height * 0.04),
                        _buildSaveButton(fontSize),
                      ],
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

  Widget _buildBoxField(String label, Function(String) onChanged, double fontSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: fontSize * 1.2),
      child: TextFormField(
        keyboardType: label == 'Phone' ? TextInputType.number : TextInputType.text,
        inputFormatters: label == 'Phone' ? [FilteringTextInputFormatter.digitsOnly] : [],
        style: TextStyle(fontSize: fontSize),
        decoration: _boxInputDecoration(label, fontSize),
        onChanged: onChanged,
        maxLength: label == 'Phone' ? 10 : null,
        validator: (val) {
          if (val == null || val.isEmpty) return 'Required';
          if (label == 'Full Name' && !RegExp(r"^[a-zA-Z\s]+$").hasMatch(val)) {
            return 'Only letters allowed';
          }
          if (label == 'Phone' && !RegExp(r"^\d{10}$").hasMatch(val)) {
            return 'Enter 10-digit phone number';
          }
          if (label == 'Address' && val.length < 5) {
            return 'Enter a valid address';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDatePicker(double fontSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: fontSize * 1.2),
      child: InkWell(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: selectedDate!,
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.indigo,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) setState(() => selectedDate = picked);
        },
        child: InputDecorator(
          decoration: _boxInputDecoration('Date of Birth', fontSize),
          child: Text(
            selectedDate != null
                ? DateFormat('dd MMM yyyy').format(selectedDate!)
                : 'Select your date of birth',
            style: TextStyle(
              fontSize: fontSize,
              color: selectedDate != null ? Colors.black : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector(double fontSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: fontSize * 1.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Gender", style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
          ...['Male', 'Female', 'Other'].map((gender) {
            return RadioListTile<String>(
              title: Text(gender, style: TextStyle(fontSize: fontSize)),
              value: gender,
              groupValue: selectedGender,
              onChanged: (value) => setState(() => selectedGender = value!),
              activeColor: Colors.indigo,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCountryDropdown(double fontSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: fontSize * 1.2),
      child: DropdownButtonFormField<String>(
        decoration: _boxInputDecoration("Country", fontSize),
        value: selectedCountry,
        items: countryStateDistrictMap.keys.map((country) {
          return DropdownMenuItem(value: country, child: Text(country));
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCountry = value;
            selectedState = null;
            selectedDistrict = null;
            stateList = countryStateDistrictMap[selectedCountry!]!.keys.toList();
            districtList = [];
          });
        },
        validator: (val) => val == null ? 'Required' : null,
      ),
    );
  }

  Widget _buildStateDropdown(double fontSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: fontSize * 1.2),
      child: DropdownButtonFormField<String>(
        decoration: _boxInputDecoration("State", fontSize),
        value: selectedState,
        items: stateList.map((state) {
          return DropdownMenuItem(value: state, child: Text(state));
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedState = value;
            selectedDistrict = null;
            districtList = countryStateDistrictMap[selectedCountry!]![selectedState!]!;
          });
        },
        validator: (val) => val == null ? 'Required' : null,
      ),
    );
  }

  Widget _buildDistrictDropdown(double fontSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: fontSize * 1.2),
      child: DropdownButtonFormField<String>(
        decoration: _boxInputDecoration("District", fontSize),
        value: selectedDistrict,
        items: districtList.map((district) {
          return DropdownMenuItem(value: district, child: Text(district));
        }).toList(),
        onChanged: (value) => setState(() => selectedDistrict = value),
        validator: (val) => val == null ? 'Required' : null,
      ),
    );
  }

  Widget _buildSaveButton(double fontSize) {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.save, color: Colors.white),
        label: Text(
          "Save",
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          padding: EdgeInsets.symmetric(horizontal: fontSize * 2, vertical: fontSize * 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 10,
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _user.gender = selectedGender;
            _user.dob = DateFormat('dd MMM yyyy').format(selectedDate!);
            _user.places = '$selectedDistrict, $selectedState, $selectedCountry';
            Navigator.pop(context, _user);
          }
        },
      ),
    );
  }
}
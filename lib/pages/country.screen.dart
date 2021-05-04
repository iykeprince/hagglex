import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hagglex/view_models/app_data.model.dart';
import 'package:provider/provider.dart';

class CountryScreen extends StatelessWidget {
  List<String> items = List.generate(20, (index) => "(+234) Nigeria");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF271160),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.indigo.shade300,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for country',
                          hintStyle: GoogleFonts.lato(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.white54,
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) =>
                      CountryItem(country: items[index]),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryItem extends StatefulWidget {
  final String country;
  CountryItem({
    this.country = '',
  });
  @override
  _CountryItemState createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem> {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    return InkWell(
      onTap: () {
        appData.setCountry(widget.country);
        Navigator.pushNamed(context, '/register');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 24,
            child: Image.asset(
              'assets/flag.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Text(
            '${widget.country}',
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constants/style.dart';

class JobSeekerSearchPage extends StatefulWidget {
  @override
  State<JobSeekerSearchPage> createState() => _JobSeekerSearchPageState();
}

class _JobSeekerSearchPageState extends State<JobSeekerSearchPage> {


  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      width: double.maxFinite,
      child: Column(
        children: [
          SizedBox(height: 13),
          Text("JobKart", style: kSmallLogoTextStyle),
          SizedBox(height: 13),

          //search box with search icon in a row
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _searchController,
                  decoration: kTextFieldInputDecoration.copyWith(
                      labelText: "Search"),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.search, size: 30),
                onPressed: ()  {
                },
              ),
            ],
          ),

          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Search Results", style: kGreyoutHeading3Style),
              //create a dropdown menu to select the sort order of the search results
              Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: kThemeColor1,
                ),
                child: DropdownButton(
                  style: kAppTextBoldWhiteStyle,
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  dropdownColor: kThemeColor1,
                  underline: Container(),
                  value: "Categories",
                  items: [
                    DropdownMenuItem(
                      child: Text("Categories"),
                      value: "Categories",
                    ),
                    DropdownMenuItem(
                      child: Text("Relevance"),
                      value: "Relevance",
                    ),
                    DropdownMenuItem(
                      child: Text("Distance"),
                      value: "Distance",
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SizedBox(height: 40),

          //Search Results List view will be here


        ],
      ),
    );
  }
}

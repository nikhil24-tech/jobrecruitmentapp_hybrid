import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../models/job_profile.dart';
import '../../../services/job_kart_db_service.dart';
import '../../../widgets/job_listing_widget.dart';

class JobSeekerSearchPage extends StatefulWidget {
  @override
  State<JobSeekerSearchPage> createState() => _JobSeekerSearchPageState();
}

class _JobSeekerSearchPageState extends State<JobSeekerSearchPage> {
  List<JobProfile>? jobProfileSearchResults;

  final _searchController = TextEditingController();

  @override
  var dropdownValue = 'salary ascending';
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
                  decoration:
                  kTextFieldInputDecoration.copyWith(labelText: "Search"),
                  onChanged: (String t) async {
                    jobProfileSearchResults = await JobsDBService.searchJobs(
                        _searchController.text.trim());

                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.search, size: 30),
                onPressed: () async {
                  // jobProfileSearchResults = await JobsDBService.searchJobs(
                  //     _searchController.text.trim());

                  // setState(() {});
                },
              ),
            ],
          ),

          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Search Results", style: kGreyoutHeading3Style),
            ],
          ),
          SizedBox(height: 40),

          //Search Results List view

          jobProfileSearchResults == null
              ? Text("")
              : Flexible(
            child: ListView.builder(
              itemCount: jobProfileSearchResults!.length,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    JobListingWidget(
                      isAdmin: true,
                      jobProfile: jobProfileSearchResults![index],
                    ),
                    SizedBox(height: 15),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class SalaryDownLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Salary", style: TextStyle(fontSize: 16)),
        Icon(Icons.arrow_downward, color: Colors.white)
      ],
    );
  }
}

class SalaryUpLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Salary", style: TextStyle(fontSize: 16)),
        Icon(Icons.arrow_upward, color: Colors.white)
      ],
    );
  }
}

class JobNameUpLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Name", style: TextStyle(fontSize: 16)),
        Icon(Icons.arrow_upward, color: Colors.white)
      ],
    );
  }
}

class JobNameDownLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Name", style: TextStyle(fontSize: 16)),
        Icon(Icons.arrow_downward, color: Colors.white)
      ],
    );
  }
}

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
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.search, size: 30),
                onPressed: () async {
                  jobProfileSearchResults = await JobsDBService.searchJobs(
                      _searchController.text.trim());

                  setState(() {});
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
                  value: dropdownValue,
                  items: [
                    DropdownMenuItem(
                      child: SalaryUpLabel(),
                      value: "salary ascending",
                    ),
                    DropdownMenuItem(
                      child: SalaryDownLabel(),
                      value: "salary descending",
                    ),
                    DropdownMenuItem(
                      child: JobNameUpLabel(),
                      value: "name ascending",
                    ),
                    DropdownMenuItem(
                      child: JobNameDownLabel(),
                      value: "name descending",
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                    if (jobProfileSearchResults != null) {
                      switch (dropdownValue) {
                        case "salary ascending":
                          jobProfileSearchResults!.sort((a, b) =>
                              a.salaryPerHr!.compareTo(b.salaryPerHr!));
                          break;

                        case "salary descending":
                          jobProfileSearchResults!.sort((a, b) =>
                              b.salaryPerHr!.compareTo(a.salaryPerHr!));
                          break;

                        case "name ascending":
                          jobProfileSearchResults!
                              .sort((a, b) => a.jobName!.compareTo(b.jobName!));
                          break;
                        case "name descending":
                          jobProfileSearchResults!
                              .sort((a, b) => b.jobName!.compareTo(a.jobName!));
                          break;
                      }
                      setState(() {});
                    }
                  },
                ),
              ),
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

import 'package:brilloconnetz/colors.dart';
import 'package:brilloconnetz/model/db_models.dart';
import 'package:brilloconnetz/services/user.services.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userService = UserService();

  User? user;
  List<String> interests = [];

  Future<void> init() async {
    user = await _userService.getCurrentUser();

    interests = splitInterests(user?.interests);

    setState(() {});
  }

  List<String> splitInterests(String? interest) {
    final interestList = interest?.split(',');

    return interestList ?? [];
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              width: size.width,
              height: size.height / 2.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/dp.jpg'),
                          radius: 70,
                        ),
                        GestureDetector(
                          child: const CircleAvatar(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      user?.email ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user?.phone ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(15),
              child: interests.isEmpty
                  ? const Text(
                      'No Interests',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Row(
                      children: [
                        const Text(
                          'Interests: ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: interests.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2,
                                crossAxisCount: 4,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 3,
                              ),
                              itemBuilder: (_, index) {
                                final interest = interests[index];
                                return Chip(
                                  padding: EdgeInsets.zero,
                                  label: Text(
                                    interest.titleCase,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

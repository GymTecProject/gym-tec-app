import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_protected.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/pages/user/profile/dialogs/edit_medical_conditions.dart';
import 'package:gym_tec/services/dependency_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PageBody(),
    );
  }
}

class PageBody extends StatefulWidget {
  const PageBody({super.key});
  @override
  _PageBody createState() => _PageBody();
}
class _PageBody extends State<PageBody> {
  final DatabaseInterface dbService = DependencyManager.databaseService;
  final AuthInterface authService = DependencyManager.authService;

  UserPublicData? userPublicData;
  UserProtectedData? userProtectedData;

  void _fetchUserData() async {
    final user = authService.currentUser;

    if (user == null) return;
    try {
      final UserPublicData? publicData =
          await dbService.getUserPublicData(user.uid);
      final UserProtectedData? protectedData =
          await dbService.getUserProtectedData(user.uid);
      if (publicData == null || protectedData == null) {
        return;
      }
      setState(() {
        userPublicData = publicData;
        userProtectedData = protectedData;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  void _openEditMedicalConditions() {
    showDialog(context: context, builder: (context) => EditMedicalConditions(medicalConditions: userProtectedData!.medicalConditions, onSave: _updateMedicalConditions));
  }

  void _updateMedicalConditions(List<String> medicalConditions) async{
    final user = authService.currentUser;
    if (user == null) return;
    try{
      final res = await dbService.updateUserMedicalConditions(user.uid, medicalConditions);
      if(res != null){
      setState(() {
        userProtectedData!.medicalConditions = medicalConditions;
      });
      }
    }catch(e){
      throw Exception(e);

    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        automaticallyImplyLeading: false,
      ),
      body: ContentPadding(
        child: Card(
          child: ContentPadding(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(userPublicData?.name ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 28))),
                  const ContextSeparator(),
                  Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: ContentPadding(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Información personal',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            const ContextSeparator(),
                            RichText(
                                text: TextSpan(children: [
                              const WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.phone)),
                              const WidgetSpan(child: ItemSeparator()),
                              TextSpan(
                                text: userProtectedData?.phoneNumber ?? '',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                                )
                            ])),
                            const ItemSeparator(),
                            RichText(
                                text: TextSpan(children: [
                              const WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.email)),
                              const WidgetSpan(child: ItemSeparator()),
                              TextSpan(text: userProtectedData?.email ?? '',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface)
                              )
                            ]))
                          ]),
                    ),
                  ),
                  const ContextSeparator(),
                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: ContentPadding(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Condiciones médicas',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                IconButton(
                                    onPressed: _openEditMedicalConditions,
                                    icon: const Icon(Icons.edit))
                              ],
                            ),
                            const ContextSeparator(),
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: userProtectedData?.medicalConditions.length ?? 0,
                                separatorBuilder: (context, index) =>
                                    Divider(color: Theme.of(context).colorScheme.onSurface),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      title: Text(userProtectedData?.medicalConditions[index] ?? ''));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

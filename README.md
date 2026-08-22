### How to use hive

#### Generate adapter

- To generate a `TypeAdapter` for a class, annotate it with `@HiveType` and provide a `typeId` (between 0 and 223)
- Annotate all fields which should be stored with `@HiveField`
- Run build task `dart run build_runner build`
- Register the generated adapter `Hive.registerAdapter(MyObjectAdapter());` in main.

#### Flutter web

- https://congoprodapp.azurewebsites.net/#/login
- Build web app `flutter build web`
- Run to 4200 port `flutter run -d chrome --web-port 4200`

#### Branching Guideline

![Git Branch](branching_structure.png)

flutter build apk --release

flutter build apk --debug

flutter devices

flutter run -d 23124RN87I
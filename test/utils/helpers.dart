class MockStorage extends Mock implements Storage {}

late Storage hydratedStorage;

void initHydratedStorage() {
    TestWidgetsFlutterBinding.ensureInitialized();
    hydratedStorage = MockStorage();

    when(() => hydratedStorage.write(any(), any<dynamic>())).thenAnswer((_) async {});

    HydratedBloc.storage = hydratedStorage;
}
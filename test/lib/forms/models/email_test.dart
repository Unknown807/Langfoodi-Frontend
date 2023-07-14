
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/forms/models/models.dart';

void main() {
  late Email email;

  setUp(() {
    email = const Email.pure();
  });

  group("Email model tests", () {
    group("validator method tests", () {
      test("valid emails", () {
        // Act
        final resultArr = [
          email.validator("john.doe@example.com"),
          email.validator("jane_smith@example.com"),
          email.validator("johndoe123@example.com"),
          email.validator("jane.smith123@example.com"),
          email.validator("john-doe@example.com"),
          email.validator("jane_smith@example.co.uk"),
          email.validator("johndoe123@example.net"),
          email.validator("jane.smith123@example.org"),
          email.validator("john-doe@example.io"),
          email.validator("jane_smith@example.xyz"),
          email.validator("johndoe123@example.tech"),
          email.validator("jane.smith123@example.online"),
          email.validator("john-doe@example.store"),
          email.validator("jane_smith@example.shop"),
          email.validator("j@sd.df"),
          email.validator("a@a.a"),
          email.validator("hello@world.c")
        ];

        // Assert
        expect(resultArr.every((e) => e == null), isTrue);
      });

      test("invalid emails", () {
        // Act
        final resultArr = [
          email.validator(null),
          email.validator(""),
          email.validator("email@domain"),
          email.validator("email@domain."),
          email.validator("email@-domain.com"),
          email.validator("email@domain-.com"),
          email.validator("email@dom_ain.com"),
          email.validator("email@domain..com"),
          email.validator("email@doma!n.com"),
          email.validator("email@[127.0.0.1]"),
          email.validator("email@[IP Address]"),
          email.validator("email@[IPv6 Address]"),
          email.validator("email@[::1]"),
          email.validator("email@[localhost]"),
          email.validator("email@[example.]com"),
          email.validator("email@[example].com"),
          email.validator("email@[example].co.m"),
          email.validator("email@[example].com.........."),
          email.validator(".email@example.com."),
          email.validator("email@"),
          email.validator("@"),
          email.validator("."),
          email.validator("email@example.com.........."),
        ];

        // Assert
        expect(resultArr.every((e) => e == FormValidationError.emailInvalid), isTrue);
      });
    });
  });
}
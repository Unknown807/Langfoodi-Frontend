import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_social_media/forms/models/form_models.dart';

void main() {
  late Password password;

  setUp(() {
    password = const Password.pure();
  });

  group("Password model tests", () {
    group("validator method tests", () {
      test("valid passwords", () {
        // Act
        final resultArr = [
          password.validator("aP55w0!~"),
          password.validator("Password1!"),
          password.validator("SecureP@ssword9"),
          password.validator("Flutt3r#Pass"),
          password.validator("p@ssw0rD!"),
          password.validator("Str0ngP@ss~"),
          password.validator("Passw0rd#Flt"),
          password.validator("P@55w0rd!"),
          password.validator("Flutter#2022"),
          password.validator("P@ssword123!"),
          password.validator("S3cur3P@ss~"),
          password.validator("FltRocks#2022"),
          password.validator("P@ssw0rd&Flt"),
          password.validator("1234P@ssword!"),
          password.validator("Flt!2022Pass"),
          password.validator("P@55word~"),
          password.validator("Flutter#Pwd1"),
          password.validator("S3cur3P@55!"),
          password.validator("FltRocks2022#"),
          password.validator("P@ssw0rd&Flut"),
          password.validator("12345P@ssword~~~~~~~~~~~~~~~~~~~~~~~~"),
          password.validator("Pa44!a    ")
        ];

        // Assert
        expect(resultArr.every((e) => e == null), isTrue);
      });

      test("invalid passwords", () {
        // Act
        final resultArr = [
          password.validator(null),
          password.validator(""),
          password.validator(" "),
          password.validator("   "),
          password.validator("Pa44a      "),
          password.validator("password123"),
          password.validator("abcdefg"),
          password.validator("12345678"),
          password.validator("qwertyui"),
          password.validator("!@#\$%^&*"),
          password.validator("987654321"),
          password.validator("abcd1234"),
          password.validator("p@ssw0rd"),
          password.validator("iloveyou"),
          password.validator("1234567890"),
          password.validator("password!"),
          password.validator("qwerty123"),
          password.validator("abcdef123"),
          password.validator("1qaz2wsx"),
          password.validator("letmein!"),
          password.validator("sunshine1"),
          password.validator("welcome1"),
          password.validator("passw0rd!"),
          password.validator("123abc456"),
          password.validator("!@#\$%123"),
        ];

        // Assert
        expect(resultArr.every((e) => e == FormValidationError.passwordInvalid), isTrue);
      });
    });
  });
}
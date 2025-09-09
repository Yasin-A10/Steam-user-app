import 'package:dartz/dartz.dart';
import 'package:steam/features/contact_way/data/model/contact_model.dart';
import 'package:steam/features/contact_way/data/source/update_contact.dart';

class UpdateContactRepositoryImpl {
  final UpdateContactApiProvider apiProvider;

  UpdateContactRepositoryImpl({required this.apiProvider});

  Future<Either<String, ContactModel>> updateContact(
    ContactModel contact,
  ) async {
    try {
      final result = await apiProvider.updateContact(contact);

      return Right(result);
    } catch (e) {
      return Left('Please try again later...${e.toString()}');
    }
  }
}

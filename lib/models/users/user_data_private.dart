enum AccountType { administrator, trainer, client }

class UserPrivateData {
  final AccountType accountType;

  UserPrivateData({required this.accountType});

  factory UserPrivateData.fromMap(Map<String, dynamic> map) {
    switch (map['accountType']) {
      case 'administrator':
        return UserPrivateData(accountType: AccountType.administrator);
      case 'trainer':
        return UserPrivateData(accountType: AccountType.trainer);
      case 'client':
        return UserPrivateData(accountType: AccountType.client);
      default:
        throw Exception('Invalid account type');
    }
  }

  Map<String, dynamic> toJson() => {
        'accountType': accountType.name,
      };

  String getAccountTypeString() {
    switch (accountType) {
      case AccountType.client:
        return 'Cliente';
      case AccountType.trainer:
        return 'Entrenador';
      case AccountType.administrator:
        return 'Admin';
      default:
        return 'Desconocido';
    }
  }
}

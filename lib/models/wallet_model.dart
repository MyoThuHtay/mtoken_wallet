const String walletTables = 'Wallets';

class WalletFields {
  static final List<String> values = [
    id,isCreated,wallets,private,public,phrase,xpud
  ];
  static const String id = '_id';
  static const String isCreated = '_isCreated';
  static const String wallets = '_wallets';
  static const String private = '_private';
  static const String public = '_public';
  static const String phrase = '_phrase';
  static const String xpud = '_xpud';
}

class Wallets {
  final int? id;
  final bool isCreated;
  final String wallets, private, public, phrase, xpud;

 const Wallets({
    this.id,
    required this.isCreated,
    required this.wallets,
    required this.private,
    required this.public,
    required this.phrase,
    required this.xpud,
  });

  static Wallets fromJson(Map<String, dynamic> json) {
    return Wallets(
      id: json[WalletFields.id] as int?,
      isCreated: json[WalletFields.isCreated] == 1,
      private: json[WalletFields.private] as String,
      public: json[WalletFields.public] as String,
      xpud: json[WalletFields.xpud] as String,
      wallets: json[WalletFields.wallets] as String,
      phrase: json[WalletFields.phrase] as String,
    );
  }

  Map<String,Object?> toJson() => {
    WalletFields.id : id,
    WalletFields.isCreated: isCreated ? 1 :0,
    WalletFields.wallets : wallets,
    WalletFields.private : private,
    WalletFields.public : public,
    WalletFields.phrase : phrase,
    WalletFields.xpud : xpud
  };

  Wallets copy ({
    int? id,
    bool? isCreated,
    String? wallets,
    String? private,
    String? public,
    String? phrase,
    String? xpud,
  }) => Wallets(
    id: id ?? this.id,
    isCreated: isCreated ?? this.isCreated,
    wallets: wallets ?? this.wallets,
    private: private ?? this.private,
    public: public ?? this.public,
    phrase: phrase ?? this.phrase,
    xpud: xpud ?? this.xpud
  );

//   static Map<String, dynamic> toMap(Wallet wallet) => {
//         'id': wallet.id,
//         'private': wallet.private,
//         'public': wallet.public,
//         'phrase': wallet.phrase,
//         'xpud': wallet.xpud,
//         'wallet': wallet.wallets,
//       };
//
//   static String encode(List<Wallet> wallets) => json.encode(
//         wallets
//             .map<Map<String, dynamic>>((wallet) => Wallet.toMap(wallet))
//             .toList(),
//       );
//
//   static List<Wallet> decode(String wallets) =>
//       (json.decode(wallets) as List<dynamic>)
//           .map<Wallet>((item) => Wallet.fromJson(item))
//           .toList();
}

class Policy {
  final String id;
  final Customer customer;
  final Contract contract;

  Policy({required this.id, required this.customer, required this.contract});

  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      id: json['_id'],
      customer: Customer.fromJson(json['policy']['customer']),
      contract: Contract.fromJson(json['policy']['contract']),
    );
  }
}

class Customer {
  final String customerId;
  final String name;
  final Address address;
  final Contact contact;
  final String dateOfBirth;
  final String gender;

  Customer({
    required this.customerId,
    required this.name,
    required this.address,
    required this.contact,
    required this.dateOfBirth,
    required this.gender,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['customer_id'],
      name: json['name'],
      address: Address.fromJson(json['address']),
      contact: Contact.fromJson(json['contact']),
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
    );
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zip_code'],
      country: json['country'],
    );
  }
}

class Contact {
  final String phone;
  final String email;

  Contact({required this.phone, required this.email});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      phone: json['phone'],
      email: json['email'],
    );
  }
}

class Contract {
  final String contractId;
  final Premium premium;
  final Distributor distributor;
  final String campaign;
  final PaymentDetails paymentDetails;
  final String planSelection;
  final String startDate;
  final String endDate;
  final String coverageType;

  Contract({
    required this.contractId,
    required this.premium,
    required this.distributor,
    required this.campaign,
    required this.paymentDetails,
    required this.planSelection,
    required this.startDate,
    required this.endDate,
    required this.coverageType,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      contractId: json['contract_id'],
      premium: Premium.fromJson(json['premium']),
      distributor: Distributor.fromJson(json['distributor']),
      campaign: json['campaign'],
      paymentDetails: PaymentDetails.fromJson(json['payment_details']),
      planSelection: json['plan_selection'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      coverageType: json['coverage_type'],
    );
  }
}

class Premium {
  final double amount;
  final String currency;
  final String billingType;

  Premium({
    required this.amount,
    required this.currency,
    required this.billingType,
  });

  factory Premium.fromJson(Map<String, dynamic> json) {
    return Premium(
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      billingType: json['billing_type'],
    );
  }
}

class Distributor {
  final String type;
  final String name;
  final double commission;

  Distributor({
    required this.type,
    required this.name,
    required this.commission,
  });

  factory Distributor.fromJson(Map<String, dynamic> json) {
    return Distributor(
      type: json['type'],
      name: json['name'],
      commission: (json['commission'] as num).toDouble(),
    );
  }
}

class PaymentDetails {
  final String paymentMethod;
  final String cardNumber;
  final String expirationDate;
  final Address billingAddress;

  PaymentDetails({
    required this.paymentMethod,
    required this.cardNumber,
    required this.expirationDate,
    required this.billingAddress,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      paymentMethod: json['payment_method'],
      cardNumber: json['card_number'],
      expirationDate: json['expiration_date'],
      billingAddress: Address.fromJson(json['billing_address']),
    );
  }
}

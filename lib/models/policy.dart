class Policy {
  final String policyNumber;
  final Customer customer;
  final Contract contract;
  final List<Risk> risks;
  final Underwriting underwriting;

  Policy({
    required this.policyNumber,
    required this.customer,
    required this.contract,
    required this.risks,
    required this.underwriting,
  });

  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      policyNumber: json['contract']['contract_id'],
      customer: Customer.fromJson(json['customer']),
      contract: Contract.fromJson(json['contract']),
      risks: (json['risk'] as List).map((i) => Risk.fromJson(i)).toList(),
      underwriting: Underwriting.fromJson(json['underwriting']),
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

  Contact({
    required this.phone,
    required this.email,
  });

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
      amount: json['amount'].toDouble(),
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
      commission: json['commission'].toDouble(),
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

class Risk {
  final String riskId;
  final List<Insured> insured;
  final List<Benefit> benefits;
  final List<OptionalBenefit> optionalBenefits;
  final String planType;
  final Premium premium;

  Risk({
    required this.riskId,
    required this.insured,
    required this.benefits,
    required this.optionalBenefits,
    required this.planType,
    required this.premium,
  });

  factory Risk.fromJson(Map<String, dynamic> json) {
    return Risk(
      riskId: json['risk_id'],
      insured: (json['insured'] as List).map((i) => Insured.fromJson(i)).toList(),
      benefits: (json['benefits'] as List).map((i) => Benefit.fromJson(i)).toList(),
      optionalBenefits: (json['optional_benefits'] as List).map((i) => OptionalBenefit.fromJson(i)).toList(),
      planType: json['plan_type'],
      premium: Premium.fromJson(json['premium']),
    );
  }
}

class Insured {
  final String insuredId;
  final String name;
  final int age;
  final String relationship;
  final String gender;
  final bool smoker;
  final bool preExistingConditions;

  Insured({
    required this.insuredId,
    required this.name,
    required this.age,
    required this.relationship,
    required this.gender,
    required this.smoker,
    required this.preExistingConditions,
  });

  factory Insured.fromJson(Map<String, dynamic> json) {
    return Insured(
      insuredId: json['insured_id'],
      name: json['name'],
      age: json['age'],
      relationship: json['relationship'],
      gender: json['gender'],
      smoker: json['smoker'],
      preExistingConditions: json['pre_existing_conditions'],
    );
  }
}

class Benefit {
  final String benefitId;
  final String name;
  final Limit limit;
  final Deductible deductible;

  Benefit({
    required this.benefitId,
    required this.name,
    required this.limit,
    required this.deductible,
  });

  factory Benefit.fromJson(Map<String, dynamic> json) {
    return Benefit(
      benefitId: json['benefit_id'],
      name: json['name'],
      limit: Limit.fromJson(json['limit']),
      deductible: Deductible.fromJson(json['deductible']),
    );
  }
}

class OptionalBenefit {
  final String benefitId;
  final String name;
  final bool selected;
  final AdditionalPremium additionalPremium;

  OptionalBenefit({
    required this.benefitId,
    required this.name,
    required this.selected,
    required this.additionalPremium,
  });

  factory OptionalBenefit.fromJson(Map<String, dynamic> json) {
    return OptionalBenefit(
      benefitId: json['benefit_id'],
      name: json['name'],
      selected: json['selected'],
      additionalPremium: AdditionalPremium.fromJson(json['additional_premium']),
    );
  }
}

class Limit {
  final double amount;
  final String currency;

  Limit({
    required this.amount,
    required this.currency,
  });

  factory Limit.fromJson(Map<String, dynamic> json) {
    return Limit(
      amount: json['amount'].toDouble(),
      currency: json['currency'],
    );
  }
}

class Deductible {
  final double amount;
  final String currency;

  Deductible({
    required this.amount,
    required this.currency,
  });

  factory Deductible.fromJson(Map<String, dynamic> json) {
    return Deductible(
      amount: json['amount'].toDouble(),
      currency: json['currency'],
    );
  }
}

class AdditionalPremium {
  final double amount;
  final String currency;

  AdditionalPremium({
    required this.amount,
    required this.currency,
  });

  factory AdditionalPremium.fromJson(Map<String, dynamic> json) {
    return AdditionalPremium(
      amount: json['amount'].toDouble(),
      currency: json['currency'],
    );
  }
}

class Underwriting {
  final List<Question> questions;
  final String results;

  Underwriting({
    required this.questions,
    required this.results,
  });

  factory Underwriting.fromJson(Map<String, dynamic> json) {
    return Underwriting(
      questions: (json['questions'] as List).map((i) => Question.fromJson(i)).toList(),
      results: json['results'],
    );
  }
}

class Question {
  final String questionId;
  final String question;
  final String answer;

  Question({
    required this.questionId,
    required this.question,
    required this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['question_id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}

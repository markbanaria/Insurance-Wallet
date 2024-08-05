class Policy {
  final Customer? customer;
  final Contract? contract;
  final List<Risk>? risks;
  final Underwriting? underwriting;

  Policy({
    this.customer,
    this.contract,
    this.risks,
    this.underwriting,
  });

  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      contract: json['contract'] != null ? Contract.fromJson(json['contract']) : null,
      risks: json['risk'] != null ? List<Risk>.from(json['risk'].map((x) => Risk.fromJson(x))) : null,
      underwriting: json['underwriting'] != null ? Underwriting.fromJson(json['underwriting']) : null,
    );
  }
}

class Customer {
  final String? customerId;
  final String? name;
  final Address? address;
  final Contact? contact;
  final String? dateOfBirth;
  final String? gender;

  Customer({
    this.customerId,
    this.name,
    this.address,
    this.contact,
    this.dateOfBirth,
    this.gender,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['customer_id'],
      name: json['name'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      contact: json['contact'] != null ? Contact.fromJson(json['contact']) : null,
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
    );
  }
}

class Address {
  final String? street;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;

  Address({
    this.street,
    this.city,
    this.state,
    this.zipCode,
    this.country,
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
  final String? phone;
  final String? email;

  Contact({
    this.phone,
    this.email,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      phone: json['phone'],
      email: json['email'],
    );
  }
}

class Contract {
  final String? contractId;
  final Premium? premium;
  final Distributor? distributor;
  final String? campaign;
  final PaymentDetails? paymentDetails;
  final String? planSelection;
  final String? startDate;
  final String? endDate;
  final String? coverageType;

  Contract({
    this.contractId,
    this.premium,
    this.distributor,
    this.campaign,
    this.paymentDetails,
    this.planSelection,
    this.startDate,
    this.endDate,
    this.coverageType,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      contractId: json['contract_id'],
      premium: json['premium'] != null ? Premium.fromJson(json['premium']) : null,
      distributor: json['distributor'] != null ? Distributor.fromJson(json['distributor']) : null,
      campaign: json['campaign'],
      paymentDetails: json['payment_details'] != null ? PaymentDetails.fromJson(json['payment_details']) : null,
      planSelection: json['plan_selection'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      coverageType: json['coverage_type'],
    );
  }
}

class Premium {
  final double? amount;
  final String? currency;
  final String? billingType;

  Premium({
    this.amount,
    this.currency,
    this.billingType,
  });

  factory Premium.fromJson(Map<String, dynamic> json) {
    return Premium(
      amount: json['amount'] != null ? json['amount'].toDouble() : null,
      currency: json['currency'],
      billingType: json['billing_type'],
    );
  }
}

class Distributor {
  final String? type;
  final String? name;
  final double? commission;

  Distributor({
    this.type,
    this.name,
    this.commission,
  });

  factory Distributor.fromJson(Map<String, dynamic> json) {
    return Distributor(
      type: json['type'],
      name: json['name'],
      commission: json['commission'] != null ? json['commission'].toDouble() : null,
    );
  }
}

class PaymentDetails {
  final String? paymentMethod;
  final String? cardNumber;
  final String? expirationDate;
  final Address? billingAddress;

  PaymentDetails({
    this.paymentMethod,
    this.cardNumber,
    this.expirationDate,
    this.billingAddress,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      paymentMethod: json['payment_method'],
      cardNumber: json['card_number'],
      expirationDate: json['expiration_date'],
      billingAddress: json['billing_address'] != null ? Address.fromJson(json['billing_address']) : null,
    );
  }
}

class Risk {
  final String? riskId;
  final List<Insured>? insured;
  final List<Benefit>? benefits;
  final List<OptionalBenefit>? optionalBenefits;
  final String? planType;
  final Premium? premium;

  Risk({
    this.riskId,
    this.insured,
    this.benefits,
    this.optionalBenefits,
    this.planType,
    this.premium,
  });

  factory Risk.fromJson(Map<String, dynamic> json) {
    return Risk(
      riskId: json['risk_id'],
      insured: json['insured'] != null ? List<Insured>.from(json['insured'].map((x) => Insured.fromJson(x))) : null,
      benefits: json['benefits'] != null ? List<Benefit>.from(json['benefits'].map((x) => Benefit.fromJson(x))) : null,
      optionalBenefits: json['optional_benefits'] != null ? List<OptionalBenefit>.from(json['optional_benefits'].map((x) => OptionalBenefit.fromJson(x))) : null,
      planType: json['plan_type'],
      premium: json['premium'] != null ? Premium.fromJson(json['premium']) : null,
    );
  }
}

class Insured {
  final String? insuredId;
  final String? name;
  final int? age;
  final String? relationship;
  final String? gender;
  final bool? smoker;
  final bool? preExistingConditions;

  Insured({
    this.insuredId,
    this.name,
    this.age,
    this.relationship,
    this.gender,
    this.smoker,
    this.preExistingConditions,
  });

  factory Insured.fromJson(Map<String, dynamic> json) {
    return Insured(
      insuredId: json['insured_id'],
      name: json['name'],
      age: json['age'] != null ? json['age'] : null,
      relationship: json['relationship'],
      gender: json['gender'],
      smoker: json['smoker'],
      preExistingConditions: json['pre_existing_conditions'],
    );
  }
}

class Benefit {
  final String? benefitId;
  final String? name;
  final Limit? limit;
  final Deductible? deductible;

  Benefit({
    this.benefitId,
    this.name,
    this.limit,
    this.deductible,
  });

  factory Benefit.fromJson(Map<String, dynamic> json) {
    return Benefit(
      benefitId: json['benefit_id'],
      name: json['name'],
      limit: json['limit'] != null ? Limit.fromJson(json['limit']) : null,
      deductible: json['deductible'] != null ? Deductible.fromJson(json['deductible']) : null,
    );
  }
}

class OptionalBenefit {
  final String? benefitId;
  final String? name;
  final bool? selected;
  final AdditionalPremium? additionalPremium;

  OptionalBenefit({
    this.benefitId,
    this.name,
    this.selected,
    this.additionalPremium,
  });

  factory OptionalBenefit.fromJson(Map<String, dynamic> json) {
    return OptionalBenefit(
      benefitId: json['benefit_id'],
      name: json['name'],
      selected: json['selected'],
      additionalPremium: json['additional_premium'] != null ? AdditionalPremium.fromJson(json['additional_premium']) : null,
    );
  }
}

class AdditionalPremium {
  final double? amount;
  final String? currency;

  AdditionalPremium({
    this.amount,
    this.currency,
  });

  factory AdditionalPremium.fromJson(Map<String, dynamic> json) {
    return AdditionalPremium(
      amount: json['amount'] != null ? json['amount'].toDouble() : null,
      currency: json['currency'],
    );
  }
}

class Limit {
  final double? amount;
  final String? currency;

  Limit({
    this.amount,
    this.currency,
  });

  factory Limit.fromJson(Map<String, dynamic> json) {
    return Limit(
      amount: json['amount'] != null ? json['amount'].toDouble() : null,
      currency: json['currency'],
    );
  }
}

class Deductible {
  final double? amount;
  final String? currency;

  Deductible({
    this.amount,
    this.currency,
  });

  factory Deductible.fromJson(Map<String, dynamic> json) {
    return Deductible(
      amount: json['amount'] != null ? json['amount'].toDouble() : null,
      currency: json['currency'],
    );
  }
}

class Underwriting {
  final List<Question>? questions;
  final String? results;

  Underwriting({
    this.questions,
    this.results,
  });

  factory Underwriting.fromJson(Map<String, dynamic> json) {
    return Underwriting(
      questions: json['questions'] != null ? List<Question>.from(json['questions'].map((x) => Question.fromJson(x))) : null,
      results: json['results'],
    );
  }
}

class Question {
  final String? questionId;
  final String? question;
  final String? answer;

  Question({
    this.questionId,
    this.question,
    this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['question_id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}

using { sap.common.CodeList, Currency } from '@sap/cds/common';
namespace sap.cap.schema;

type Numc5 : String(5) @assert.format : '[0-9]+';
type Numc3 : String(3) @assert.format : '[0-9]+';

type EMail : String(100) @assert.format : '^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$';

@cds.autoexpose entity Gender {
    key code : String(1);
}

@fiori.draft.enabled
entity Employee {
    key ID : Numc5;
    name : String;
    gender : Association to Gender;
    email : String;
    joinedDate : Date;
    department : Association to one Department; 
    projects : Association to many Projects on projects.involvedEmployee = $self;
}

entity Department {
    key ID : Numc3;
    title : String;
    description : String;
    employees : Association to many Employee on employees.department = $self;
}

@cds.autoexpose entity ProjectDifficulty {
    key code : String;
}

entity Projects : CodeList {
    key ID : Numc5;
    difficulty : Association to one ProjectDifficulty;
    involvedEmployee : Association to one Employee;
    @Aggregation.default: #SUM
    @Measures.ISOCurrency: currency_code
    price : Decimal(25,2);
    @Semantics.currencyCode
    currency : Currency;
}

@cds.persistence.skip
entity AllEntities {
  key entityName  : String(150);
      Description : String(150);
      service     : String(150);
      namespace   : String(150);
}
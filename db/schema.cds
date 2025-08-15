namespace sap.cap.schema;

type Numc5 : String(5) @assert.format : '[0-9]+';
type Numc3 : String(3) @assert.format : '[0-9]+';

type EMail : String(100) @assert.format : '^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$';

@cds.autoexpose entity Gender {
    key code : String(1);
}

entity Employee {
    key ID : Numc5;
    name : String;
    gender : Association to Gender;
    email : String;
    joinedDate : Date;
    department : Association to one Department; 
}

entity Department {
    key ID : Numc3;
    title : String;
    description : String;
    employees : Association to many Employee on employees.department = $self;
}
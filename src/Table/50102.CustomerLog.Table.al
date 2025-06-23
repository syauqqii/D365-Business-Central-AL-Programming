table 50102 "Customer Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Time Stamp"; DateTime) { }
        field(3; "Action"; Text[20]) { }
        field(4; "Customer Name"; Text[100]) { }
        field(5; "User ID"; Code[50]) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }
}
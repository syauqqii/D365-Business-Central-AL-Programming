table 50100 "HV Inquiry Table"
{
    Caption = 'Hutang Vendor Inquiry';

    fields
    {
        field(1; "No."; Integer)
        {

        }
    
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
        }

        field(3; "Vendor Name"; Text[100])
        {

        }

        field(4; "Posting Date"; Date)
        {
            
        }

        field(5; "External Document No."; Code[35])
        {

        }

        field(6; "Due Date"; Date)
        {

        }

        field(7; "Debit Amount (LCY)"; Decimal)
        {

        }

        field(8; "Credit Amount (LCY)"; Decimal)
        {

        }

        field(9; "Original Amount"; Decimal)
        {

        }
    }

    keys{
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}
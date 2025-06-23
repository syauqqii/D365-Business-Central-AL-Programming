page 50105 "Set Position Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Set Position Page Card';

    actions
    {
        area(Processing)
        {
            action(setcurrentkey)
            {
                ApplicationArea = All;
                Caption = 'Set Current Key';

                trigger OnAction()
                begin
                    if Customer.SetCurrentKey("Salesperson Code") then
                        Message(Text001)
                    else
                        Message(Text002);
                end;
            }

            action(setposition)
            {
                ApplicationArea = All;
                Caption = 'Set Position';

                trigger OnAction()
                begin
                    InputString := 'No.=Const(20001)';
                    MyRecordRef.Open(23);
                    MyFieldRef := MyRecordRef.Field(1);
                    MyFieldRef.SetFilter('10000..20000');
                    MyRecordRef.FindLast();
                    Message(Text004, MyRecordRef.RecordId, MyRecordRef.Field(2));
                    MyRecordRef.SetPosition(InputString);
                    Message(Text005, MyRecordRef.RecordId, MyRecordRef.Field(2));
                    InputString := MyRecordRef.GetPosition(true);
                    Message(Text003, InputString);
                end;
            }
        }

        area(Promoted)
        {
            actionref(button1; setcurrentkey) { }
            actionref(button2; setposition) { }
        }
    }

    var
        Customer: Record Customer;
        Text001: Label 'Key selected sucessfully';
        Text002: Label 'Key not found';
        RecRef: RecordRef;
        varPrimaryKey: Text;
        Text003: Label 'The primary key is: %1';

        MyRecordRef: RecordRef;
        InputString: Text;
        MyFieldRef: FieldRef;
        Text004: Label 'The record No. before the primary key was changed is %1.\\ The vendor name before the primary key was changed %2.';
        Text005: Label 'The record No. after the primary key was changed is %1.\\ The vendor name after the primary key was changed %2.';
}
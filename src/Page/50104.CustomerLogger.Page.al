page 50104 "Customer Logger"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    PageType = Card;
    Caption = 'Customer Logger';
    SourceTable = "Customer Log";
    InsertAllowed = false;
    DeleteAllowed = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Time Stamp"; Rec."Time Stamp")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Action"; Rec."Action")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(Hello)
            {
                Caption = 'Print';
                Image = PrintDocument;
                
                trigger OnAction()
                begin
                    Message('Hello World!');
                end;
            }
        }

        area(Promoted)
        {
            actionref("Print"; Hello) { }
        }
    }
    
    var
        myInt: Integer;
}
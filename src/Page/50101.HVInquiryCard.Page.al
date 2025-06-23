page 50101 "HV Inquiry Card"
{
    PageType = ListPart;
    Caption = 'Details';
    SourceTable = "HV Inquiry Table";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(VendorNo; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(VendorName; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(ExtDocNo; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(DueDate; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(DebitAmountLCY; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(CreditAmountLCY; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(OriginalAmount; Rec."Original Amount")
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
            action(Process)
            {
                Caption = 'Process';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Message('Process');
                end;
            }

            action(Reset)
            {
                Caption = 'Reset';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Message('Reset');
                end;
            }
        }
    }

    procedure ApplyFilter(StartDate: Date; EndDate: Date)
    var
        HVISetup: Record "Vendor Ledger Entry";
        HVITemp: Record "HV Inquiry Table";
    begin
        Rec.DeleteAll();

        HVITemp.Reset();
        HVISetup.SetRange(HVISetup."Posting Date", StartDate, EndDate);
        if HVISetup.FindSet() then
            repeat
                Clear(HVITemp);
                HVITemp.Init();
                HVITemp."No." := HVISetup."Entry No.";
                HVITemp."Vendor No." := HVISetup."Vendor No.";
                HVITemp."Vendor Name" := HVISetup."Vendor Name";
                HVITemp."Posting Date" := HVISetup."Posting Date";
                HVITemp."External Document No." := HVISetup."External Document No.";
                HVITemp."Due Date" := HVISetup."Due Date";
                HVITemp."Debit Amount (LCY)" := HVISetup."Debit Amount (LCY)";
                HVITemp."Credit Amount (LCY)" := HVISetup."Credit Amount (LCY)";
                HVITemp."Original Amount" := HVISetup."Original Amount";
                HVITemp.Insert();
            until HVISetup.Next() = 0;
    end;
}
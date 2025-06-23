page 50102 "List Testing Dialog"
{
    ApplicationArea = All;
    Caption = 'List Testing Dialog';
    PageType = List;
    SourceTable = "HV Inquiry Table";
    UsageCategory = Lists;

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
                Caption = 'Filter';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowFilter(1);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ShowFilter(0);
    end;

    procedure ShowFilter(isListAlreadyOpen: integer)
    var
        FilterDialog: Page "Filter Testing Dialog";
        HVISetup: Record "Vendor Ledger Entry";
        HVITemp: Record "HV Inquiry Table";
    begin
        if FilterDialog.RunModal() = Action::OK then begin
            StartDate := FilterDialog.getStartDate();
            EndDate := FilterDialog.getEndDate();
        end else
            if isListAlreadyOpen = 0 then begin
                Error('Action cancelled');
                CurrPage.Close();
            end;

        if StartDate = 0D then StartDate := Today;
        if EndDate = 0D then EndDate := Today;

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
        
        CurrPage.Update();
    end;

    var
        StartDate: Date;
        EndDate: Date;
}
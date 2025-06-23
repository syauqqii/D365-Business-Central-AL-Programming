pageextension 50101 "Cash Receipt Journal Extension" extends "Cash Receipt Journal"
{
    layout
    { }

    actions
    {
        addafter("P&osting")
        {
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;

                trigger OnAction()
                var
                    GenJournalLine : Record "Gen. Journal Line";
                begin
                    GenJournalLine := Rec;
                    CurrPage.SetSelectionFilter(GenJournalLine);

                    Report.RunModal(50102, true, false, GenJournalLine);
                end;
            }
        }
    }
}
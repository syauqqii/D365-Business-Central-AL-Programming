pageextension 50104 "XML Export Item" extends "Item List"
{
    actions
    {
        addlast(History)
        {
            action(ExportItem)
            {
                Caption = 'Export';
                ApplicationArea = All;
                Image = Export;

                trigger OnAction()
                begin
                    Xmlport.Run(50100, true, false);
                end;
            }
        }

        addafter(Category_Report)
        {
            actionref(ExportItems; ExportItem) { }
        }
    }
}
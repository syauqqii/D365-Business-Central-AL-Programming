pageextension 50103 "Customer Page Extension" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(shoesize; Rec.shoesize)
            {
                ApplicationArea = All;
                Caption = 'Shoe Size';

                trigger OnValidate()
                begin
                    CalculateSize();
                end;
            }

            field(remshoes; Rec.remshoes)
            {
                ApplicationArea = All;
                Caption = 'Remaining Shoes';

                trigger OnValidate()
                begin
                    CalculateStock();
                end;
            }
        }
    }

    local procedure CalculateSize()
    begin
        if (Rec.shoesize < 5) then
            Error('The size is too small')
        else
            Message('Saved sucessfully');
    end;

    local procedure CalculateStock()
    begin
        if (Rec.remshoes < 3) then
            Error('Refill the stock')
    end;
}
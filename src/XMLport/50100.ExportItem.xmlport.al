xmlport 50100 ExportItem
{
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    TableSeparator = '';

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'ItemHeader';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));

                textelement(ItemNoTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemNoTitle := Item.FieldCaption("No.");
                    end;
                }

                textelement(ItemDescTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemDescTitle := Item.FieldCaption(Description);
                    end;
                }
            }

            tableelement(Item; Item)
            {
                XmlName = 'Item';
                RequestFilterFields = "No.";

                fieldelement(No; Item."No.") { }
                fieldelement(Description; Item.Description) { }
            }
        }
    }
}
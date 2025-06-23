pageextension 50102 "My Job" extends "Job Card"
{
    layout
    {
        addlast(General)
        {
            field(MyProgress; Rec.MyProgress)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    CurrPage.bar.SetProgress(Rec.MyProgress);
                end;
            }
            
            usercontrol(bar; ProgressBarAddIn)
            {
                ApplicationArea = All;

                trigger StartUp()
                begin
                    CurrPage.bar.SetProgress(Rec.MyProgress);
                end;
            }
        }
    }
}
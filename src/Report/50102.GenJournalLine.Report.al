report 50102 "Gen Journal Line Report"
{
    DefaultLayout = "RDLC";
    RDLCLayout = './src/Report/50102.GenJournalLine.Report.rdlc';
    Caption = 'Gen Journal Line Report ';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    
    dataset
    {
        dataitem(GJL; "Gen. Journal Line")
        {
            column(Journal_Template_Name; "Journal Template Name")
            { }
        }
    }
    
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Input)
                {
                    field("Journal Template Name"; JTL)
                    { }
                }
            }
        }
    }
    
    var
        JTL: Code[10];
}
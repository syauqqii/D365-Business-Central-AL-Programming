page 50103 "Filter Testing Dialog"
{
    PageType = StandardDialog;
    Caption = 'Filter start date and end date';
    ApplicationArea = All;
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            group(Parameter)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                }

                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = All;   
                }
            }
        }
    }

    procedure getStartDate() : Date
    begin
       exit(StartDate);
    end;

    procedure getEndDate() : Date
    begin
        exit(EndDate);
    end;
    
    var
        StartDate: Date;
        EndDate: Date;
}
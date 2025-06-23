page 50100 "HV Inquiry List"
{
    PageType = Document;
    Caption = 'Hutang Vendor Inquiry List';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Filter Date';

                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }

                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
            }

            part(Details; "HV Inquiry Card")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
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
                var
                    Details: Page "HV Inquiry Card";
                begin
                    Details.ApplyFilter(StartDate, EndDate);
                    Details.Update();
                    CurrPage.Update();
                end;
            }

            action(Reset)
            {
                Caption = 'Reset';
                ApplicationArea = All;

                trigger OnAction()
                var
                    Details: Record "HV Inquiry Table";
                begin
                    StartDate := 0D;
                    EndDate := 0D;

                    Details.DeleteAll();
                    CurrPage.Update();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var 
        HVITemp : Record "HV Inquiry Table";
    begin
        if HVITemp.FindSet() then
            HVITemp.DeleteAll();
    end;

    var
        StartDate: Date;
        EndDate: Date;
}
pageextension 50100 CustomerListExt extends "Customer List"
{
    actions
    {
        addbefore("Sales Journal")
        {
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;

                trigger OnAction()
                begin
                    Message('Hello World');
                end;
            }
        }
    }
    
    trigger OnOpenPage()
    var
        EN: Codeunit "Email Notification";
        // SMSN: Codeunit "SMS Notification";
        Success: Boolean;
    begin
        Success := NotifyUser(EN);
        if not Success then
            Message('Notify gagal tapi aplikasi aman');
    end;

    [TryFunction]
    procedure NotifyUser(Notification: Interface "INotification")
    begin
        Notification.SendNotification('Hello!');
    end;
}
codeunit 50102 "SMS Notification" implements "INotification"
{
    procedure SendNotification(Message: Text)
    begin
        Message('SMS Sent: %1', Message);
    end;
}
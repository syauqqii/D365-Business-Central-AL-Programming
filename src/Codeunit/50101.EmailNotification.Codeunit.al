codeunit 50101 "Email Notification" implements "INotification"
{
    procedure SendNotification(Message: Text)
    begin
        Message('Email sent: %1', Message);
    end;
}
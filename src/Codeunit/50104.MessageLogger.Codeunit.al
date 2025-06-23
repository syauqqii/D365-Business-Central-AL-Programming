codeunit 50104 "Message Logger" implements ILogger
{
    procedure Log(Action: Text; CustName: Text)
    begin
        Message('[%1] %2 oleh %3', Action, CustName, UserId());
    end;
}
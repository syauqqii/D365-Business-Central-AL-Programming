codeunit 50106 "Customer Activity Handler"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnInsert(var Rec: Record Customer)
    begin
        requestor.sendMessage(number, StrSubstNo(msg_create, Rec."No.", Rec.Name));
        LogSafe('Create', Rec.Name);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', true, true)]
    local procedure OnModify(var Rec: Record Customer)
    begin
        // requestor.sendMessage(number, StrSubstNo(msg_modify, Rec."No.", Rec.Name));
        LogSafe('Modify', Rec.Name);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnDelete(var Rec: Record Customer)
    begin
        requestor.sendMessage(number, StrSubstNo(msg_delete, Rec."No.", Rec.Name));
        LogSafe('Delete', Rec.Name);
    end;

    local procedure LogSafe(Action: Text; CustName: Text)
    var
        Manager: Codeunit "Logger Manager";
        Success: Boolean;
    begin
        Success := TryLog(Action, CustName, Manager);
        if not Success then
            Message('Log Gagal! Tapi aplikasi aman.');
    end;

    [TryFunction]
    local procedure TryLog(Action: Text; CustName: Text; Manager: Codeunit "Logger Manager")
    begin
        Manager.RunLogger(Action, CustName);
    end;

    var
        requestor: Codeunit "Whatsapp Sender";
        number: Label '62xxx';
        msg_create: Label 'Create Customer | %1 | %2';
        msg_modify: Label 'Modify Customer | %1 | %2';
        msg_delete: Label 'Delete Customer | %1 | %2';
}
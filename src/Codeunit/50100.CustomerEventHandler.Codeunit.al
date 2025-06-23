codeunit 50100 "Customer Event Handler"
{
    // [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', true, true)]
    // local procedure HandleCustomerModify(var Rec: Record Customer)
    // begin
    //     Message('Customer %1 berhasil di edit!', Rec.Name);
    // end;

    // [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterDeleteEvent', '', true, true)]
    // local procedure HandleCustomerDeleted(var Rec: Record Customer)
    // begin
    //     Message('Customer berhasil di hapus!');
    // end;
}
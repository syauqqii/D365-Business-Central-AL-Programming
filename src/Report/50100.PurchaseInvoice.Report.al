report 50100 "Purchase Invoice Report"
{
    DefaultLayout = "RDLC";
    RDLCLayout = './src/Report/50100.PurchaseInvoice.report.rdlc';
    Caption = 'Purchase Invoice Monthly Report';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        // dataitem(PH; "Purchase Header")
        // {
        //     column(Document_Date; PH."Document Date") { }
        //     column(Vendor_Name; PH."Buy-from Vendor Name") { }
        //     column(No_PO; PH."No.") { }
        //     dataitem(PL; "Purchase Line")
        //     {
        //         DataItemLinkReference = PH;
        //         DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");

        //         column(Qty; PL."Quantity") { }

        //         dataitem(I; "Item")
        //         {
        //             DataItemLinkReference = PL;
        //             DataItemLink = "No." = field("No.");

        //             column(Nama_Barang; I."Description") { }

        //             dataitem(IC; "Item Category")
        //             {
        //                 DataItemLinkReference = I;
        //                 DataItemLink = "Code" = field("Item Category Code");

        //                 column(Description; IC."Description") { }
        //             }
        //         }
        //     }
        //     column(Amount; PH."Amount") { }
        //     column(Invoice_Receipt_Date; PH."Invoice Received Date") { }
        //     column(StartDate; StartDate) { }
        //     column(EndDate; EndDate) { }

        //     trigger OnPreDataItem()
        //     begin
        //         if (StartDate <> 0D) and (EndDate <> 0D) then
        //             SetRange("Document Date", StartDate, EndDate);
        //     end;
        // }

        dataitem(PH; "Purchase Header")
        {
            column(Document_Date; PH."Document Date") {}
            column(Vendor_Name; PH."Buy-from Vendor Name") {}
            column(No_PO; PH."No.") {}
            dataitem(PL; "Purchase Line")
            {
                DataItemLinkReference = PH;
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");

                column(Qty; PL."Quantity") { }

                trigger OnAfterGetRecord()
                var
                    I: Record "Item";
                    IC: Record "Item Category";
                begin
                    I.Get("No.");
                    I_DESCRIPTION := I.Description;

                    IC.Get(I."Item Category Code");
                    IC_DESCRIPTION := IC.Description;
                end;
            }
            column(Amount; PH."Amount") {}
            column(Invoice_Receipt_Date; PH."Invoice Received Date") {}
            column(StartDate; StartDate) {}
            column(EndDate; EndDate) {}

            trigger OnPreDataItem()
            begin
                if (StartDate <> 0D) and (EndDate <> 0D) then
                    SetRange("Document Date", StartDate, EndDate);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
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
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        IC_DESCRIPTION: Text[100];
        I_DESCRIPTION: Text[100];
}
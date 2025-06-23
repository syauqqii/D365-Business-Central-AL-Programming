report 50101 "Hutang Vendor Report"
{
    DefaultLayout = "RDLC";
    RDLCLayout = './src/Report/50101.HutangVendor.report.rdlc';
    Caption = 'Hutang Vendor Report';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(VLE; "Vendor Ledger Entry")
        {
            column(Kode_Vendor; VLE."Vendor No.") { }
            column(Nama_Vendor; VLE."Vendor Name") { }
            column(Posting_Date; VLE."Posting Date") { }
            column(Invoice; VLE."External Document No.") { }
            column(Tanggal_Jatuh_Tempo; VLE."Due Date") { }
            column(Debit; VLE."Debit Amount (LCY)") { }
            column(Kredit; VLE."Credit Amount (LCY)") { }
            column(Saldo_Akhir; VLE."Original Amount") { }

            trigger OnPreDataItem()
            begin
                if (DateFrom <> 0D) and (DateTo <> 0D) then
                    SetRange("Posting Date", DateFrom, DateTo);

                if (VendorNo <> '') then
                    SetRange("Vendor No.", VendorNo);
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
                    field(DateFrom; DateFrom)
                    {
                        ApplicationArea = All;
                        Caption = 'Date From';
                    }

                    field(DateTo; DateTo)
                    {
                        ApplicationArea = All;
                        Caption = 'Date To';
                    }

                    field("Vendor Name"; VendorName)
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            VendorTable: Record "Vendor";
                            VendorPage: Page "Vendor List";
                        begin
                            VendorPage.LookupMode(true);
                            if VendorPage.RunModal() = Action::LookupOK then
                                VendorPage.SetSelectionFilter(VendorTable);
                            if VendorTable.FindFirst() then
                                VendorName := VendorTable.Name;
                        end;
                    }
                }
            }
        }
    }

    var
        DateFrom: Date;
        DateTo: Date;
        VendorNo: Code[20];
        VendorName: Text[100];
}
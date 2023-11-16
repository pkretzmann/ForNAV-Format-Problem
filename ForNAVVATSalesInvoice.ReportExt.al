/// <summary>
/// Unknown ForNAV VAT Sales Invoice (ID 50100) extends Record ForNAV VAT Sales Invoice.
/// </summary>
reportextension 50100 "ForNAV VAT Sales Invoice" extends "ForNAV VAT Sales Invoice"
{
    dataset
    {
        modify(Header)
        {
            trigger OnBeforeAfterGetRecord()
            var
                LanguageSelection: Record "Language Selection";
                Language: Codeunit Language;
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                LanguageSelection.SetFilter("Language ID", Format(CurrReport.Language));
                if LanguageSelection.FindFirst() then
                    CurrReport.FormatRegion := LanguageSelection."Language Tag";

                // Insert Export Information
                ExportDeclarationBuffer.Reset();
                ExportDeclarationBuffer.DeleteAll();

                ExportDeclarationBuffer.Init();
                ExportDeclarationBuffer."Country of Origin Code" := 'DE';
                ExportDeclarationBuffer."Total Net Weight" := 5;
                ExportDeclarationBuffer."Currency Code" := 'DKK';
                ExportDeclarationBuffer."Total Amount" := 16;
                ExportDeclarationBuffer."Format Region" := CopyStr(CurrReport.FormatRegion, 1, MaxStrLen("Format Region"));
                ExportDeclarationBuffer.Insert();

                ExportDeclarationBuffer.Init();
                ExportDeclarationBuffer."Country of Origin Code" := 'DE';
                ExportDeclarationBuffer."Total Net Weight" := 5;
                ExportDeclarationBuffer."Currency Code" := 'EUR';
                ExportDeclarationBuffer."Total Amount" := 5.20;
                ExportDeclarationBuffer."Format Region" := CopyStr(CurrReport.FormatRegion, 1, MaxStrLen("Format Region"));
                ExportDeclarationBuffer.Insert();
            end;
        }
        addlast(Header)
        {
            dataitem(ExportDeclarationBuffer; "Export Declaration Buffer")
            {
                UseTemporary = true;
                DataItemTableView = sorting("Tariff No.", "Country of Origin Code", "Currency Code");

                column(CountryofOriginCode; "Country of Origin Code") { }
                column(TariffNo; "Tariff No.") { }
                column(TotalNetWeight; "Total Net Weight") { }
                column(CurrencyCode; "Currency Code") { }
                column(TotalAmount; "Total Amount") { }
                column(TotalQuantity; "Total Quantity") { }
                column(FormatRegion; "Format Region") { }
            }
        }
    }
}
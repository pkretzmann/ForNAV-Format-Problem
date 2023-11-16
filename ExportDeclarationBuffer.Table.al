/// <summary>
/// Table Export Declaration Buffer (ID 50100).
/// </summary>
table 50100 "Export Declaration Buffer"
{
    DataClassification = SystemMetadata;
    Caption = 'Export Declaration Buffer';
    TableType = Temporary;

    fields
    {
        field(1; "Country of Origin Code"; Code[10])
        {
            Caption = 'Country of Origin';
            TableRelation = "Country/Region";
        }
        field(2; "Tariff No."; Code[20])
        {
            Caption = 'Tariff No.';
            TableRelation = "Tariff Number";
            ValidateTableRelation = false;
        }
        field(4; "Total Net Weight"; Decimal)
        {
            Caption = 'Total Net Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7; "Currency Code"; Code[10])
        {
            Caption = 'Currency';
            Editable = false;
            TableRelation = Currency;
        }
        field(8; "Total Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(10; "Total Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            Caption = 'Quantity';
        }
        field(15; "Format Region"; Text[80])
        {
            Caption = 'Format Region';
        }
    }

    keys
    {
        key(Key1; "Tariff No.", "Country of Origin Code", "Currency Code")
        {
            Clustered = true;
            SumIndexFields = "Total Amount", "Total Quantity";
        }
    }
}
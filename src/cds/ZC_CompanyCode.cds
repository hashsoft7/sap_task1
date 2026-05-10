@Metadata.allowExtensions: true
@EndUserText.label: 'Discovery Extract – Company Code (OData projection)'
define view entity ZC_CompanyCode
  as projection on ZI_CompanyCode_R
{
  key CompanyCode,
      Country,
      Currency,
      ChartOfAccounts,
      FiscalYearVariant,
      CompanyName
}

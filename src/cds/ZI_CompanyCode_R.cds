@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Discovery Extract – Company Code (abstract root)'
define root view entity ZI_CompanyCode_R
  as select from I_CompanyCode
{
  key CompanyCode,
      Country,
      Currency,
      ChartOfAccounts,
      FiscalYearVariant,
      CompanyName
}

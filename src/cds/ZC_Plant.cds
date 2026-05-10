@Metadata.allowExtensions: true
@EndUserText.label: 'Discovery Extract – Plant (OData projection)'
define view entity ZC_Plant
  as projection on ZI_Plant_R
{
  key Plant            as Plantid,
      CompanyCode,
      PlantName,
      _CompanyCode : redirected to ZC_CompanyCode
}

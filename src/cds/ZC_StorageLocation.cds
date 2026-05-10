@Metadata.allowExtensions: true
@EndUserText.label: 'Discovery Extract – Storage Location (OData projection)'
define view entity ZC_StorageLocation
  as projection on ZI_StorageLocation_R
{
  key Plant            as Plantid,
  key StorageLocation,
      CompanyCode,
      StorageLocationName,
      _Plant : redirected to ZC_Plant
}

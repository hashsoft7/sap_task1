@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Discovery Extract – Storage Location (abstract root)'
define root view entity ZI_StorageLocation_R
  as select from I_StorageLocation as Sloc
  association [1..1] to I_Plant as _Plant on Sloc.Plant = _Plant.Plant
{
  key Sloc.Plant,
  key Sloc.StorageLocation,
      _Plant.CompanyCode as CompanyCode,
      StorageLocationName,
      _Plant
}

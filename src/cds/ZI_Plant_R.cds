@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Discovery Extract – Plant (abstract root)'
define root view entity ZI_Plant_R
  as select from I_Plant as Plant
  association [0..1] to I_CompanyCode as _CompanyCode on Plant.CompanyCode = _CompanyCode.CompanyCode
{
  key Plant,
      Plant.CompanyCode,
      PlantName,
      _CompanyCode
}

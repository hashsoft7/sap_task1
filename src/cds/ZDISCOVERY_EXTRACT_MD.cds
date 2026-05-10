annotate view ZC_CompanyCode with
{
  @UI.headerInfo : {
    typeName       : 'Company Code',
    typeNamePlural : 'Company Codes',
    title          : { type : #STANDARD, value : 'CompanyCode' }
  }

  @UI.lineItem : [{ position : 10, importance : #HIGH, label : 'Company Code' }]
  CompanyCode;

  @UI.lineItem : [{ position : 20, importance : #HIGH, label : 'Country' }]
  Country;

  @UI.lineItem : [{ position : 30, importance : #LOW, label : 'Currency' }]
  Currency;
}

annotate view ZC_Plant with
{
  @UI.headerInfo : {
    typeName       : 'Plant',
    typeNamePlural : 'Plants',
    title          : { type : #STANDARD, value : 'Plantid' }
  }

  @UI.lineItem : [{ position : 10, importance : #HIGH, label : 'Plant' }]
  Plantid;

  @UI.lineItem : [{ position : 20, importance : #HIGH, label : 'Company Code' }]
  CompanyCode;

  @UI.lineItem : [{ position : 30, importance : #LOW, label : 'Plant name' }]
  PlantName;
}

annotate view ZC_StorageLocation with
{
  @UI.headerInfo : {
    typeName       : 'Storage Location',
    typeNamePlural : 'Storage Locations',
    title          : { type : #STANDARD, value : 'StorageLocation' }
  }

  @UI.lineItem : [{ position : 10, importance : #HIGH, label : 'Plant' }]
  Plantid;

  @UI.lineItem : [{ position : 20, importance : #HIGH, label : 'Storage Location' }]
  StorageLocation;

  @UI.lineItem : [{ position : 30, importance : #LOW, label : 'Name' }]
  StorageLocationName;
}

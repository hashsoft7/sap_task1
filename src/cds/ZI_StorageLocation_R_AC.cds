@EndUserText.label: 'Access control – Storage location by company code'
define access control for ZI_StorageLocation_R
{
  grant select on ZI_StorageLocation_R
    where ( CompanyCode ) = aspect pfcg_auth(
      F_BKPF_BUK,
      BUKRS,
      CompanyCode
    );
}

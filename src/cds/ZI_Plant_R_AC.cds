@EndUserText.label: 'Access control – Plant by company code'
define access control for ZI_Plant_R
{
  grant select on ZI_Plant_R
    where ( CompanyCode ) = aspect pfcg_auth(
      F_BKPF_BUK,
      BUKRS,
      CompanyCode
    );
}

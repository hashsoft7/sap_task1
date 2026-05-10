@EndUserText.label: 'Access control – Company Code (F_BKPF_BUK.BUKRS)'
define access control for ZI_CompanyCode_R
{
  grant select on ZI_CompanyCode_R
    where ( CompanyCode ) = aspect pfcg_auth(
      F_BKPF_BUK,
      BUKRS,
      CompanyCode
    );
}

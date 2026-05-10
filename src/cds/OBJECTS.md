# CDS/RAP object inventory (technical names)

Create these ABAP repository objects in ADT with names matching the filenames (adjust namespaces per your customer prefix rules).

| Technical name | ADT object type | Source file |
|----------------|-----------------|-------------|
| `ZI_CompanyCode_R` | CDS Data Definition – View Entity | `ZI_CompanyCode_R.cds` |
| `ZI_Plant_R` | CDS Data Definition – View Entity | `ZI_Plant_R.cds` |
| `ZI_StorageLocation_R` | CDS Data Definition – View Entity | `ZI_StorageLocation_R.cds` |
| *(access)* `ZI_CompanyCode_R` | Access Control | `ZI_CompanyCode_R_AC.cds` |
| *(access)* `ZI_Plant_R` | Access Control | `ZI_Plant_R_AC.cds` |
| *(access)* `ZI_StorageLocation_R` | Access Control | `ZI_StorageLocation_R_AC.cds` |
| `ZC_CompanyCode` | CDS Data Definition – Projection View | `ZC_CompanyCode.cds` |
| `ZC_Plant` | CDS Data Definition – Projection View | `ZC_Plant.cds` |
| `ZC_StorageLocation` | CDS Data Definition – Projection View | `ZC_StorageLocation.cds` |
| `ZDISCOVERY_EXTRACT_BDEF` | Behavior Definition | `ZDISCOVERY_EXTRACT_BDEF.bdef.cds` |
| `ZDISCOVERY_EXTRACT_SRV` | Service Definition | `ZDISCOVERY_EXTRACT_SRV.srvd.cds` |
| *(optional UI)* | Metadata Extension(s) on `ZC_*` | `ZDISCOVERY_EXTRACT_MD.cds` |

Access control objects share the entity name; ADT stores them as separate **Access Control** sources attached to each root entity.

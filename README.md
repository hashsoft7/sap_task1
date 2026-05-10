# Discovery Extract – OData V4 (ABAP Cloud Trial)

Read-only OData V4 service exposing **Company Code**, **Plant**, and **Storage Location** master data for downstream discovery/sync scenarios. Data comes only from **released** CDS views (`I_CompanyCode`, `I_Plant`, `I_StorageLocation`). No custom database tables.

## Repository layout

| Area | Files |
|------|--------|
| Abstract roots (auth + reuse) | `src/cds/ZI_*_R.cds` |
| OData projections (public names) | `src/cds/ZC_*.cds` |
| Access control (DCL) | `src/cds/ZI_*_R_AC.cds` |
| Behavior (read-only RAP) | `src/cds/ZDISCOVERY_EXTRACT_BDEF.bdef.cds` |
| Service definition | `src/cds/ZDISCOVERY_EXTRACT_SRV.srvd.cds` |
| UI metadata (Fiori Elements preview) | `src/cds/ZDISCOVERY_EXTRACT_MD.cds` |

Create matching ABAP objects in ADT (same technical names), copy the sources, and activate in the order below.

## Prerequisites

- SAP BTP ABAP environment **Trial** (or compatible ABAP Cloud stack).
- ADT with ABAP Development Tools.
- A transportable package (example: `ZDISCOVERY_EXTRACT`).

## Activation sequence

1. **Released APIs** – In ADT, use **Open ABAP Development Object** (F8) and confirm `I_CompanyCode`, `I_Plant`, and `I_StorageLocation` exist and activate in your release. Use **View Browser** if you need to align field names with your stack.
2. **Root views** – Activate `ZI_CompanyCode_R`, `ZI_Plant_R`, `ZI_StorageLocation_R`.
3. **Access control** – Activate `ZI_CompanyCode_R_AC`, `ZI_Plant_R_AC`, `ZI_StorageLocation_R_AC` (objects of type access control for the respective root entities).
4. **Projections** – Activate `ZC_CompanyCode`, `ZC_Plant`, `ZC_StorageLocation`.
5. **Behavior** – Create a **behavior definition** `ZDISCOVERY_EXTRACT_BDEF` (or use the provided source). Activate.
6. **Service definition** – Create **service definition** `ZDISCOVERY_EXTRACT_SRV`, paste `define service` source, activate.
7. **Metadata extension** – Create metadata extensions from `ZDISCOVERY_EXTRACT_MD.cds` or paste into three MD extension objects bound to `ZC_*` (ADT may split annotate blocks).
8. **Service binding**
   - New **Service Binding** → select `ZDISCOVERY_EXTRACT_SRV`.
   - Binding type: **OData V4 – UI** (Fiori preview) or **OData V4 – Web API** (browser tests).
   - Publish local service once activation is green.

### Page size cap (100)

RAP/OData V4 uses server-side paging. Set the **maximum page size** to **100** on the **service binding** (binding editor → OData version / paging settings; wording varies by ADT release). That satisfies “cap default page size at 100” together with clients using `$top` / paging preferences.

If your UI metadata supports it, you can also mirror the same limit in published OData annotations; the binding setting is the usual enforcement point.

### Authorization for tests (screenshot 3)

1. Use authorization object **`F_BKPF_BUK`** (fields **`BUKRS`**, **`ACTVT`**). For display-oriented checks, activity **`03`** is typical.
2. Role **A (wide)** – e.g. `*` or all company codes needed for the demo.
3. Role **B (restricted)** – only specific `BUKRS` values.
4. Assign roles to two dialog users. Log on as each and open the same entity set: the restricted user must see **fewer rows** (DCL + `pfcg_auth`).

If DCL activation fails (syntax differs by release), open `ZI_*_R_AC` and adjust the `aspect pfcg_auth` list to your keyword documentation. Some releases require a literal for **`ACTVT`** (for example display) inside the aspect; others expect **`ACTVT`** only in the **PFCG** role for `F_BKPF_BUK`.

### Company code on `I_Plant`

This solution assumes **`I_Plant`** exposes **`CompanyCode`** (direct or equivalent). If activation fails, open **View Browser** on `I_Plant` and resolve company code via the documented association (often valuation-area–based). Keep the abstract root pattern and map **`CompanyCode`** in `ZI_Plant_R` accordingly so DCL still filters on **`CompanyCode`**.

## Proof screenshots (capture locally)

Store exports under `screenshots/` (not committed if they contain hostnames).

1. **Fiori Elements preview** – Service binding → **Preview** on an entity (e.g. **CompanyCode**) with visible rows.
2. **Browser / REST client** – GET similar to:  
   `/sap/opu/odata4/<namespace>/ZDISCOVERY_EXTRACT_SRV/<Version>/CompanyCode?$filter=Country eq 'DE'&$select=CompanyCode,Country&$top=5`  
   Adjust `<namespace>` and `<Version>` from the published binding metadata. Response **200** with JSON `value` array.
3. **DCL** – Same URL as user with restricted **F_BKPF_BUK** vs wide role; fewer or no rows for restricted user (typically **200** with smaller `value`).

See `screenshots/README.md` for a short checklist.

## OData capabilities

After publish, validate **`$filter`**, **`$select`**, **`$expand`** (e.g. **Plant** with **`_CompanyCode`**, **StorageLocation** with **`_Plant`** / nested expand per projection).

## Related documentation

- DECISIONS.md – design answers required by the brief.

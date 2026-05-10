# Decisions (Discovery OData)

## 1. CDS source: released views vs tables

Source entities: `I_CompanyCode`, `I_Plant`, `I_StorageLocation` (not `T001`, `T001W`, `T001L`).

Technical rationale:

- Public semantic models for integration; fewer breaks on physical schema changes.
- Works with DCL and authorization-relevant fields.
- Matches constraint: no custom DB tables, no direct DDIC SELECT, released APIs only.

Verification (repeat on your system):

- ADT / View Browser: entity marked released (or API-enabled per your release).
- SAP Business Accelerator Hub / API docs: entity consumable for your edition (Cloud vs on-prem).
- Custom layer: `ZI_*` / `ZC_*` only consume these interfaces; no table exposure or Z-append tables.

Upgrade: if an interface changes, activation or ATC should surface issues; fix projections rather than reverting to tables.

## 2. DCL when user has no S_TABU_DIS

`S_TABU_DIS` is generic table access; this service reads CDS with `@AccessControl.authorizationCheck: #CHECK`. Row access is enforced by CDS access control (e.g. `pfcg_auth` on company code), not by `S_TABU_DIS`.

- Missing `S_TABU_DIS` alone does not determine OData row visibility for this design.
- Missing company-code auth (e.g. `F_BKPF_BUK` / `BUKRS` as modeled) excludes rows in the result set.
- Typical OData: HTTP 200 with empty or partial `value` array; HTTP 403 only if another layer rejects the request.

Troubleshoot with SACM / auth trace for PFCG vs DCL, not table auth alone.

## 3. Scale: ~40,000 plants

Main bottleneck: unfiltered or “load all” list requests. The stack must execute SQL, build large result sets, serialize OData, and transfer data—high CPU, memory, latency, and client cost. Paging helps per page but not if the consumer must scan the entire set.

Also watch: OData max skip limits, gateway timeouts, clients that ignore paging and buffer full results.

## 4. S/4HANA on-premise vs cloud (differences)

- Gateway: embedded or hub Gateway; service activation, system alias, HTTPS/reverse proxy differ from BTP ABAP Trial-style setup.
- API surface: confirm same CDS names and fields exist on target on-prem release; replace abstract roots (`ZI_*_R`) with the documented on-prem released equivalent if names differ.
- Lifecycle: ATC/CVA/readiness for custom code; transports for objects and PFCG roles (e.g. `F_BKPF_BUK`); cross-client and auth distribution as required by the customer.

Optional hardening for large extracts: stronger `$filter` contracts, delta or batch patterns instead of full scans—still without Z-tables.

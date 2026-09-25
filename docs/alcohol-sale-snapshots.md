# Alcohol sale snapshots

POS and website checkouts use `SaleItemModel.fromProduct` and
`toCommerceLedgerJson`. Measurements are captured in millilitres and fractional
ABV when pricing the sale, never reconstructed during reporting.

`isAlcohol` is nullable for backwards compatibility:

- `true`: an alcohol product; valid size, ABV, per-unit and total LAL are required.
- `false`: a catalog-classified non-alcoholic product; no LAL snapshot is needed.
- absent/null: unknown historical classification; missing snapshots remain visible.

Positive ABV takes precedence over category. Alcohol categories also require a
snapshot even if their ABV is missing. An absent category with zero ABV remains
unknown. Shipping and custom sale lines remain excluded from missing warnings.

Website `OrderModel.saleItems` contains server-owned checkout snapshots. Changes
to the ordered quantities invalidate these snapshots; address-only changes do
not. Paid/shipped/delivered orders must preserve snapshots and prices rather than
recapture today's product configuration. Older orders without this field remain
readable and require an explicit, evidence-backed migration to repair snapshots.

Repairs must update source orders/sales and their commerce ledger projections,
preserve prices and transaction state, and use compare-and-set writes so a
concurrent sale or fulfilment update is not overwritten. Only confirmed product
measurements or non-alcohol classifications may be backfilled. Record before and
after values, verify the resulting report, and keep customer data out of logs.

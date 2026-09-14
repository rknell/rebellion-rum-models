# Storefront retail prices

`ProductModel.storefrontRetailPrices` maps storefront IDs to public retail prices
in AUD, using the same GST-inclusive convention as `websitePrice`.
Missing maps default to empty; missing storefront IDs fall back to `websitePrice`.
Existing products require no migration. Wholesale, mates rates and POS prices
remain separate fields and are not overridden by this map.

The website owns price selection for the active storefront. Catalogue clients
must preserve this field when editing shared product records. Public product
responses should expose only the active storefront's retail price, not the map.

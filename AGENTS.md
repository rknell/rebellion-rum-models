# Rebellion Rum Models Agent Guidance

## Engineering Standard

- Build like the next request is the beginning of a larger feature set, not a one-off patch.
- Prefer modular, named models, services, helpers, tests, and generators over large inline blocks or copy-pasted logic.
- Keep business rules testable outside UI or transport glue.
- When adding shared model surface area, design typed APIs that can be consumed cleanly by the website, POS, and distillery apps.
- Avoid coding the repo into a corner: preserve backwards compatibility where needed, document migrations, and leave clear extension points for the next consumer.
- If existing code is not modular, keep the immediate change compatible but identify the smallest sensible extraction path before the feature grows.
- Put data shape changes behind explicit migrations or compatibility code. Record assumptions about legacy fields and defaults.
- Prefer typed request/response shapes and named serializers over loose maps once an API or model has more than one caller.
- Add tests at the lowest useful level first, then integration tests for cross-package behavior.

## Common Commands

```powershell
dart pub get
dart analyze --fatal-infos --fatal-warnings
dart test
dart run build_runner build --delete-conflicting-outputs
```

## Null Safety and Persisted Data Policy

- Avoid `late` in new or touched code. Prefer constructor/field initialization, definitely assigned local `final` variables, or explicit nullable loading state. Any unavoidable lifecycle exception needs a comment explaining initialization before every read and a lifecycle test.
- Non-nullable Dart types do not validate JSON, MongoDB documents, or other `dynamic` inputs. Validate required values and nested objects at the serialization boundary, including numeric type and finiteness, before generated casts.
- Document legacy shapes and explicit fallback precedence. Never default missing stock, alcohol measurements, or money to zero merely to avoid an exception. Preserve valid zero values.
- Reject unrecoverable persisted records with a field-specific error and record identifier before writes. Do not skip broken register entries or infer measurements from vessel totals.
- Do not rely on assertions for runtime input validation or edit generated serializers by hand. Regenerate and test the source model changes.
- Serialization changes require tests for missing keys, explicit nulls, wrong types, invalid numbers, supported legacy records, and valid round trips. Exercise the consuming workflow for regressions.

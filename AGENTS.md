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

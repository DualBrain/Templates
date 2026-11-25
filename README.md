# Templates

`dotnet new` templates for Visual Basic projects, from yours truly.

```bash
dotnet new install DualBrain.Templates
dotnet new list qb
```

## QB.Compatibility

Programs that use [QB.Compatibility](https://github.com/DualBrain/QB.Compatibility), the QuickBASIC 4.5 / QBasic compatibility library for Visual Basic (.NET):

| Template | Short name | |
|---|---|---|
| QB.Compatibility text program | `qb-text` | a console program: `PRINT`, `INPUT`, `LOCATE`, files, sound |
| QB.Compatibility graphics program | `qb-graphics` | draws in an SDL2 window: `SCREEN`, `PSET`, `LINE`, `CIRCLE`, `PAINT` |

```bash
dotnet new qb-text -n Hello
dotnet run --project Hello
```

The templates reference the newest stable QB.Compatibility when a project is restored, so a new library release needs no new version of the templates.

## Building and testing

```bash
dotnet pack -c Release -o artifacts
./test-templates.sh artifacts         # installs the package in a scratch location, creates each template and builds it
```

Pushing a tag such as `v0.1.1` publishes the package to nuget.org (trusted publishing; see `.github/workflows/release.yml`).

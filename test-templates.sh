#!/usr/bin/env bash
# Installs the packed templates into a scratch hive, creates a project from each one and builds it.
# usage: test-templates.sh <folder with DualBrain.Templates.*.nupkg> [extra NuGet source]
set -euo pipefail
packages="$(cd "$1" && { pwd -W 2>/dev/null || pwd; })"
extra_source="${2:-}"
work="$(mktemp -d)"
work="$(cd "$work" && { pwd -W 2>/dev/null || pwd; })"
trap 'rm -rf "$work"' EXIT
hive="$work/hive"

package="$(ls "$packages"/DualBrain.Templates.*.nupkg | head -n 1)"
dotnet new install "$package" --debug:custom-hive "$hive"

for template in qb-text qb-graphics; do
  echo "=== $template"
  dotnet new "$template" -n "Test_${template//-/_}" -o "$work/$template" --debug:custom-hive "$hive"
  if [ -n "$extra_source" ]; then
    dotnet build "$work/$template" -p:RestoreAdditionalProjectSources="$extra_source"
  else
    dotnet build "$work/$template"
  fi
done
echo "All templates built."

# perlcritic as a GitHub Action

This repository is for the GitHub Action that runs perlcritic.

The main difference between what's provided in this action and
super-linter, is that super-linter includes only a vanilla
installation of perlcritic with only policies that comes with
`Perl::Critic` itself, and this action include all policies available
on CPAN.

To use this action, a profile is needed. Conventionally it is asummed
that the profile is named `.perlcriticrc`.

Additionally, it is strongly recommended to include flag `only`
in `.perlcriticrc`, such as:

```
only = 1
include = RequireUseStrict ProhibitUnusedVariables
```

With that example, only 2 listed policies are enabled. If more are needed,
they need to be expilicitly listed as one of the values ins the `include`.

If you have a working config without `only` flag, you could see the
full list of enabled policies by running:

```
perlcritic -p .perlcriticrc --list-enabled
```

The main reason this is strongly recommended is that once policies are
installed, they are basically enabled. If vanilla perlcritic is not
enough for your project, that means either you need to tailer a
`perlcritic` GitHub Action with the exact policies for that one
project, or go with the approach provided in this GitHub Action.

## Inputs

There are two optional input, one is `paths`, the other is `options`.

The default value  is `--quiet -p .perlrcriticrc`  for `options`, `.` for `paths`.

That means the default `perlcritic` command is:

    perlcritic --quiet -p .perlcriticrc .

... which means it scans current directory for perl source code and
report only violations, based on the profile written in
`.perlcriticrc` in the current directory.

## Example

This minimum setup should be enough as a starter.

```yaml
  - name: perlcritic
    uses: gugod/actions-perlcritic@v1.0
```

For working with typical CPAN module, this should be better, as we generally do not need to critic `Build.PL` or `Makefile.PL`:

```yaml
  - name: perlcritic
    uses: gugod/actions-perlcritic@v1.0
    with:
      paths: "lib t"
```

Remove `--quiet` in the case case when you prefer to see those
`source OK` messages.
  
```yaml
  - name: perlcritic
    uses: gugod/actions-perlcritic@v1.0
    with:
      paths: "lib t"
      options: "-p .perlcriticrc"
```

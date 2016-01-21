# NWU Reborn Version

Dota2 Reborn Naruto MOBA.

# Releasing

## Develop branch has a release candidate

```shell
git checkout master
git merge develop
git tag -a vx.y.z-beta "Version x.y.z-Beta"
git push origin master --tags
```

Example:

```shell
git checkout master
git merge develop
git tag -a v1.0.4-beta "Version 1.0.4-Beta"
git push origin master --tags
```

## Develop branch has a release candidate at COMMIT

```shell
git checkout master
git merge COMMIT
git tag -a vx.y.z-beta "Version x.y.z-Beta"
git push origin master --tags
```

Example:

Given this commit: https://github.com/muZk/NWU_Reborn/commit/1e5e775f40239a84f7388370bb85896308af0bea

Commit SHA is 1e5e775f40239a84f7388370bb85896308af0bea

```shell
git checkout master
git merge 1e5e775f40239a84f7388370bb85896308af0bea
git tag -a v1.0.4-beta "Version 1.0.4-Beta"
git push origin master --tags
```

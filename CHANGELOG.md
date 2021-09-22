# 0.0.x / Unreleased

# 0.0.16 / 2021-09-21

## Fixed

- Fixed bug when reference to prev node was not set correctly аfter using `shift`.

[Compare v0.0.15...v0.0.16](https://github.com/spectator/linked-list/compare/v0.0.15...v0.0.16)

# 0.0.15 / 2020-05-26

## Fixed

- Fixed bug when deleting the last node of the list. The @tail value was not updated if the @head value was updated.

[Compare v0.0.14...v0.0.15](https://github.com/spectator/linked-list/compare/v0.0.14...v0.0.15)

# 0.0.14 / 2020-04-17

## Fixed

Forced minimal rake version in gemspec to skip rake versions with security issues.

[Compare v0.0.13...v0.0.14](https://github.com/spectator/linked-list/compare/v0.0.13...v0.0.14)

# 0.0.13 / 2018-11-27

## Fixed

- Delete duplicate method definitions (nex3 in [#7](https://github.com/spectator/linked-list/pull/7))

## Added

- Allow `List#delete` to delete a `Node` in O(1) time (nex3 in [#6](https://github.com/spectator/linked-list/pull/6))

[Compare v0.0.12...v0.0.13](https://github.com/spectator/linked-list/compare/v0.0.12...v0.0.13)

# 0.0.12 / 2018-09-04

## Added

- Added `insert`, `insert_before` and `insert_after` methods (mpospelov in [#3](https://github.com/spectator/linked-list/pull/3))
- Added `reverse_each` and `reverse_each_node` methods (mpospelov in [#4](https://github.com/spectator/linked-list/pull/4))

[Compare v0.0.11...v0.0.12](https://github.com/spectator/linked-list/compare/v0.0.11...v0.0.12)

# 0.0.11 / 2018-08-23

## Added

- Added `delete` and `delete_all` methods (mpospelov in [#2](https://github.com/spectator/linked-list/pull/2))

[Compare v0.0.10...v0.0.11](https://github.com/spectator/linked-list/compare/v0.0.10...v0.0.11)

# 0.0.10 / 2018-04-02

## Fixed

- Fixed bug when `@tail.prev` was mistekenly set to `nil` instead of `@tail.next` when popping elements off the list (Sonna in [#1](https://github.com/spectator/linked-list/pull/1))

[Compare v0.0.9...v0.0.10](https://github.com/spectator/linked-list/compare/v0.0.9...v0.0.10)

# 0.0.9 / 2013-12-11

Initial release.

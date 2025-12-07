# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     YodelStudio.Repo.insert!(%YodelStudio.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

YodelStudio.Repo.insert!(%YodelStudio.Catalog.Video{
  title: "2.5+ Hours of Boppin NES Music",
  slug: "J3w0acXJeRE",
  active: true,
  channel_name: "Balticsalmon",
  channel_id: "UCRAtYRe8tPynWadDbAu30TQ"
})

YodelStudio.Repo.insert!(%YodelStudio.Catalog.Video{
  title: "SNES Music Nostalgia Mix",
  slug: "Flm4byJT5og",
  active: true,
  channel_name: "Mysterious Zim",
  channel_id: "UCb86Gv7SIIoiKDSIrpEDQQQ"
})

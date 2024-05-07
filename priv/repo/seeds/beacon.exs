# Script for populating sites data. You can run it as:
#
#     mix run priv/repo/seeds/beacon.exs

alias Beacon.Content

template = fn path ->
  [__DIR__, path]
  |> Path.join()
  |> File.read!()
end

layout = Content.get_layout_by(:demo, title: "Default")

home_page =
  Content.create_page!(%{
    site: "demo",
    layout_id: layout.id,
    path: "/",
    title: "Landing Page - CMS Platform",
    template: template.("home.html.heex")
  })

Beacon.MediaLibrary.UploadMetadata.new(
  :demo,
  Path.join([:code.priv_dir(:beacon_demo), "static", "images", "narwin.png"]),
  name: "narwin.png",
  size: 153_000,
  extra: %{"alt" => "logo"}
)
|> Beacon.MediaLibrary.upload()

%{site: "demo", path: "/"}
|> Beacon.Content.create_live_data!()
|> Beacon.Content.create_assign_for_live_data(%{
  format: :elixir,
  key: "current_year",
  value: """
  Date.utc_today().year
  """
})

Content.create_event_handler_for_page(home_page, %{
  name: "join",
  code: ~S"""
  %{"waitlist" => %{"email" => email}} = event_params
  IO.puts("#{email} joined the waitlist")
  {:noreply, socket}
  """
})

{:ok, _} = Content.publish_page(home_page)
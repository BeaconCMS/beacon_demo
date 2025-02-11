# Script for populating sites data. You can run it as:
#
#     mix run priv/repo/seeds/beacon.exs

alias Beacon.Content

template = fn path ->
  [__DIR__, path]
  |> Path.join()
  |> File.read!()
end

# -- LAYOUTS

default_layout = Content.get_layout_by(:demo, title: "Default")

{:ok, default_layout} =
  Content.update_layout(default_layout, %{
    template: template.("default_layout.html.heex")
  })

Content.publish_layout(default_layout)

{:ok, blog_layout} =
  %{
    site: "demo",
    title: "Blog",
    template: template.("blog_layout.html.heex")
  }
  |> Content.create_layout!()
  |> Content.publish_layout()

# -- HOME PAGE

home_page = Content.get_page_by(:demo, path: "/")

{:ok, home_page} =
  Content.update_page(home_page, %{
    title: "CMS Platform",
    template: template.("home.html.heex"),
    meta_tags: [
      %{"property" => "og:title", "content" => "{{ page.title }}"}
    ],
    extra: %{"type" => "page"}
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

Content.create_event_handler(%{
  site: "demo",
  name: "join",
  code: ~S"""
  %{"waitlist" => %{"email" => email}} = event_params
  IO.puts("#{email} joined the waitlist")
  {:noreply, assign(socket, :joined, true)}
  """
})

Content.create_js_hook(%{
  site: "demo",
  name: "tippy",
  code: ~S"""
  export const tippy = {
    mounted() {
      window.tippy(this.el, {content: 'Get in first!'})
    }
  }
  """
})

{:ok, _} = Content.publish_page(home_page)

# -- BLOG INDEX

blog_index_page =
  Content.create_page!(%{
    site: "demo",
    layout_id: default_layout.id,
    path: "/blog",
    title: "Blog - CMS Platform",
    template: template.("blog_index.html.heex"),
    extra: %{"type" => "page"}
  })

blog_index_live_data = Beacon.Content.create_live_data!(%{site: "demo", path: "/blog"})

Beacon.Content.create_assign_for_live_data(blog_index_live_data, %{
  format: :elixir,
  key: "current_year",
  value: """
  Date.utc_today().year
  """
})

Beacon.Content.create_assign_for_live_data(blog_index_live_data, %{
  format: :elixir,
  key: "latest_blog_post",
  value: """
  # Beacon.Content will be extended to provide better APIs to manage and fetch content

  :demo
  |> Beacon.Content.list_published_pages()
  |> Enum.filter(& &1.extra["type"] == "blog_post")
  |> Enum.sort_by(&(&1.updated_at), DateTime)
  |> List.first()
  """
})

Beacon.Content.create_assign_for_live_data(blog_index_live_data, %{
  format: :elixir,
  key: "recent_blog_posts",
  value: """
  # Beacon.Content will be extended to provide better APIs to manage and fetch content

  {_, recent_blog_posts} =
  :demo
  |> Beacon.Content.list_published_pages()
  |> Enum.filter(& &1.extra["type"] == "blog_post")
  |> Enum.sort_by(&(&1.updated_at), DateTime)
  |> List.pop_at(0, [])

  recent_blog_posts
  """
})

{:ok, _} = Content.publish_page(blog_index_page)

# -- BLOG POSTS

blog_post_1 =
  Content.create_page!(%{
    site: "demo",
    layout_id: blog_layout.id,
    path: "/blog/exploring-the-power-of-elixir-a-functional-approach-to-web-development",
    title: "Exploring the Power of Elixir: A Functional Approach to Web Development - Blog - CMS Platform",
    format: :markdown,
    template: template.("blog_post_1.md"),
    extra: %{"type" => "blog_post"}
  })

{:ok, _} = Content.publish_page(blog_post_1)

blog_post_2 =
  Content.create_page!(%{
    site: "demo",
    layout_id: blog_layout.id,
    path: "/blog/the-future-of-web-development-embracing-the-power-of-serverless",
    title: "The Future of Web Development: Embracing the Power of Serverless - Blog - CMS Platform",
    format: :markdown,
    template: template.("blog_post_2.md"),
    extra: %{"type" => "blog_post"}
  })

{:ok, _} = Content.publish_page(blog_post_2)

blog_post_3 =
  Content.create_page!(%{
    site: "demo",
    layout_id: blog_layout.id,
    path: "/blog/unveiling-the-Phoenix-a-ramework-for-elixir-rising",
    title: "Unveiling the Phoenix: A Framework for Elixir Rising",
    format: :markdown,
    template: template.("blog_post_3.md"),
    extra: %{"type" => "blog_post"}
  })

{:ok, _} = Content.publish_page(blog_post_3)

# Script for populating sites data. You can run it as:
#
#     mix run priv/repo/beacon_seeds.exs

alias Beacon.Content

# Demo site

Content.create_stylesheet!(%{
  site: "demo",
  name: "sample_stylesheet",
  content: "body {cursor: zoom-in;}"
})

Content.create_component!(%{
  site: "demo",
  name: "sample_component",
  body: """
  <li>
    <%= @val %>
  </li>
  """
})

layout =
  Content.create_layout!(%{
    site: "demo",
    title: "Sample Home Page",
    meta_tags: [%{"description" => "Demo site"}],
    stylesheet_urls: [],
    template: """
    <header>
      <p class="text-2xl text-red-500">Header</p>
    </header>
    <%= @inner_content %>

    <footer>
      Page Footer
    </footer>
    """
  })

Content.publish_layout(layout)

page = Content.create_page!(%{
  site: "demo",
  layout_id: layout.id,
  path: "home",
  title: "My Home Page",
  template: """
  <main>
    <h2>Some Values:</h2>
    <ul>
      <%= for val <- @beacon_live_data[:vals] do %>
        <%= my_component("sample_component", val: val) %>
      <% end %>
    </ul>

    <.simple_form :let={f} for={%{}} as={:greeting} phx-submit="hello">
      <.input field={f[:name]} />
      <.button>Submit</.button>
    </.simple_form>

    <%= if assigns[:message], do: assigns.message %>

    <%= dynamic_helper("upcase", "Beacon") %>
  </main>
  """,
  helpers: [
    %{
      name: "upcase",
      args: "name",
      code: """
        String.upcase(name)
      """
    }
  ]
})


Content.create_event_handler_for_page(page, %{
  name: "hello",
  code: """
    {:noreply, assign(socket, :message, "Hello \#{event_params["greeting"]["name"]}!")}
  """
})

Content.publish_page(page)

# Blog site

Content.create_stylesheet!(%{
  site: "blog",
  name: "sample_stylesheet",
  content: "body {cursor: zoom-in;}"
})


layout =
  Content.create_layout!(%{
    site: "blog",
    title: "Sample Blog",
    meta_tags: [%{"description" => "Demo blog"}],
    stylesheet_urls: [],
    template: """
    <header>
      <p class="text-2xl text-red-500">Header</p>
    </header>
    <%= @inner_content %>

    <footer>
      Page Footer
    </footer>
    """
  })

Content.publish_layout(layout)

%{
  site: "blog",
  layout_id: layout.id,
  path: "posts/:post_slug",
  title: "Post",
  template: """
  <main>
    <h2>A blog</h2>
    <ul>
      <li>Path Params Blog Slug: <%= @beacon_path_params["post_slug"] %></li>
      <li>Live Data post_slug_uppercase: <%= @beacon_live_data.post_slug_uppercase %></li>
    </ul>
  </main>
  """
}
|> Content.create_page!()
|> Content.publish_page()

defmodule BeaconDemo.Beacon.PageFields.Type do
  @moduledoc false
  @behaviour Beacon.Content.PageField

  use Phoenix.Component

  import Beacon.Web.CoreComponents
  import Ecto.Changeset

  @impl true
  def name, do: :type

  @impl true
  def type, do: :string

  @impl true
  def default, do: "page"

  @impl true
  def render(assigns) do
    assigns = Map.put(assigns, :opts, [{"Page", "page"}, {"Blog Post", "blog_post"}])

    ~H"""
    <.input type="select" label="Type" prompt="Choose type" options={@opts} field={@field} />
    """
  end

  @impl true
  def changeset(data, attrs, %{page_changeset: _page_changeset}) do
    cast(data, attrs, [:type])
  end
end

defmodule LearntListWeb.PageControllerTest do
  use LearntListWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Like to Learn?"
  end
end

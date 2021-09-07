defmodule Gscraper.Account.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :gscraper,
    error_handler: Gscraper.Account.ErrorHandler,
    module: Gscraper.Account.Authentications

  # If there is a session token, restrict it to an access token and validate it
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}

  # Load the user, adds it to the private section of the `%Plug.Conn{}` if the verifications works
  # allow the user to be nil rather than raise an exception if the user isn't found.
  plug Guardian.Plug.LoadResource, allow_blank: true
end

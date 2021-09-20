defmodule Gscraper.UserFactory do
  alias Gscraper.Account.Schemas.User

  defmacro __using__(_opts) do
    quote do
      alias Gscraper.Account.Passwords

      def user_factory(attrs) do
        password = attrs[:password] || Faker.Util.format("%6b%3d")

        user = %User{
          username: Faker.Internet.user_name(),
          password: password,
          password_confirmation: password,
          encrypted_password: Passwords.hash(password)
        }

        merge_attributes(user, attrs)
      end
    end
  end
end

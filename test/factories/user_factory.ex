defmodule Gscraper.Accounts.UserFactory do
  alias Gscraper.Accounts.User

  defmacro __using__(_opts) do
    quote do
      def user_factory(attrs) do
        password = attrs[:password] || Faker.Util.format("%6b%3d")

        user = %User{
          username: Faker.Internet.user_name(),
          password: password,
          password_confirmation: password
        }

        merge_attributes(user, attrs)
      end
    end
  end
end

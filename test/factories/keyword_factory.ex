defmodule Gscraper.KeywordFactory do
  alias Gscraper.Search.Schemas.Keyword

  defmacro __using__(_opts) do
    quote do
      def keyword_factory do
        %Keyword{
          keyword: Faker.Lorem.word(),
          status: :pending,
          user: build(:user)
        }
      end
    end
  end
end

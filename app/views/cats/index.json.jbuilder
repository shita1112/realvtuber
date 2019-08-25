# frozen_string_literal: true

json.array! @cats, partial: "cats/cat", as: :cat

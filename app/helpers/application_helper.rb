# frozen_string_literal: true

module ApplicationHelper
  def display_meta_tags_default
    display_meta_tags(
      site: "リアルバーチャルYoutuber",
      separator: "|",
      reverse: true,
    )
  end
end

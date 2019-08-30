# frozen_string_literal: true

class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  def error_messages
    return if object.errors.none?

    @template.tag.div(
      error_messages_h2 + error_messages_ul,
      class: "error_messages alert alert-danger",
    )
  end

  def collection_select_mdb(attribute, options)
    collection_select attribute, options, :to_s, :humanize, {}, class: "js-works-search-select browser-default custom-select custom-select-sm"
  end

  private

  def error_messages_h2
    @template.tag.h2("エラー")
  end

  def error_messages_ul
    @template.tag.ul do
      object.errors
            .full_messages
            .map {|msg| @template.tag.li(msg) }
            .join
            .html_safe
    end
  end
end

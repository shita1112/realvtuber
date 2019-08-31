# frozen_string_literal: true

module ApplicationHelper
  def display_meta_tags_default
    display_meta_tags(
      site: "リアルバーチャルYoutuber",
      separator: "|",
      reverse: true,
    )
  end

  def render_navbar
    render "navbar"
  end

  def icon(*classes)
    tag.i(class: classes.join(" "))
  end

  def smartphone?
    browser.device.mobile?
  end

  def tablet_pc?
    !!smartphone?
  end
end

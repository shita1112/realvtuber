# frozen_string_literal: true

module ApplicationHelper
  def display_meta_tags_default
    display_meta_tags(
      site: "リアルバーチャルYoutuber",
      separator: "|",
      reverse: true,
    )
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

  def ago(time)
    TimeDifference.ago(time)
  end

  def ago_if_datetime(val)
    val.is_a?(Time) ? ago(val) : val
  end

  def render_navbar
    login_page            = current_page?(controller: "devise/sessions",      action: "new")
    signup_page           = current_page?(controller: "devise/registrations", action: "new")
    forgot_password_page  = current_page?(controller: "devise/passwords",     action: "new")
    change_password_page  = current_page?(controller: "devise/passwords",     action: "edit")

    if login_page || signup_page || forgot_password_page || change_password_page
      render "unobtrusive_navbar"
    else
      render "navbar"
    end
  end

  def h1(title)
    content_for(:h1, title)
  end

  def h1_text_only(title)
    content_for(:h1_text_only, title)
  end

  def z_depth_0_if_h1
    "z-depth-0" if content_for?(:h1) || content_for?(:h1_text_only)
  end
end

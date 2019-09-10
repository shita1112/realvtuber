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
end

# frozen_string_literal: true

TimeDifference.class_eval do
  JA_MAPPING = {
    years: "年",
    months: "ヶ月",
    weeks: "週間",
    days: "日",
    hours: "時間",
    minutes: "分",
    seconds: "秒",
  }.freeze

  def self.ago(time)
    between(Time.current, time).about_time
                               .then {|t| "#{t}前" }
  end

  def about_time
    text_value = in_general.find {|_text, value| value != 0 }
    text_value ? "#{text_value[1]}#{JA_MAPPING[text_value[0]]}" : "0秒"
  end
end

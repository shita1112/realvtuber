# frozen_string_literal: true

# 参考: https://y-yagi.tumblr.com/post/164308066365/railsデプロイ時にwebpackerが生成したassetsもs3に配置する
if Rake::Task.task_defined?("webpacker:compile")
  Rake::Task['webpacker:compile'].enhance do
    Rake::Task["assets:sync"].invoke
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Works", type: :system do
  let!(:user) { create(:user) }
  let!(:trained_model) { create(:trained_model) }
  before { sign_in(user) }

  describe "visit the index" do
    before { create(:work, user: user, trained_model: trained_model) }

    it 'displays "作成した動画"' do
      visit works_path
      expect(page).to have_content "作成した動画"
    end
  end

  describe "show a work" do
    let!(:work) { create(:work, user: user, trained_model: trained_model) }

    it 'displays "動画のダウンロード"' do
      visit work_path(work)
      expect(page).to have_content "動画のダウンロード"
    end
  end

  describe "create a work" do
    # TODO: CreateVideosJob.perform_later(@work)がtestだとDB保存してくれないのでワークアラウンド。ちゃんと調査して対応する。
    before do
      allow(CreateVideosJob).to receive(:perform_later) do |work|
        work.delay.create_videos
        job = double
        allow(job).to receive(:provider_job_id) { Delayed::Job.last.id }
        job
      end
    end

    it 'displays "動画作成を受け付けました。"' do
      visit new_work_path
      attach_file "work_original_video", support("df.mp4"), visible: false
      find("label[for=work_trained_model_id_#{trained_model.id}]").click
      click_on "動画を作る"
      expect(page).to have_content "動画作成を受け付けました。"
    end
  end

  describe "destroy a work", js: true do
    let!(:work) { create(:work, user: user, trained_model: trained_model) }

    it 'displays "動画を削除しました。"' do
      visit work_path(work)
      page.accept_confirm do
        click_on "動画を削除する"
      end
      expect(page).to have_content "動画を削除しました。"
    end
  end
end

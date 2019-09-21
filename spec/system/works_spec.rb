# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Works", type: :system do
  include_context "sign in"

  describe "visit the index" do
    before do
      create(:work, user: current_user)
      visit works_path
    end

    it 'shows "作成した動画"' do
      expect(page).to have_content "作成した動画"
    end
  end

  describe "show a work" do
    context "when current_user owns the work" do
      let!(:work) { create(:work, user: current_user) }
      before do
        visit work_path(work)
      end

      it 'shows "動画のダウンロード"' do
        expect(page).to have_content "動画のダウンロード"
      end
    end

    context "when current_user doesn't own the work" do
      let!(:work) { create(:work, user: create(:user)) }
      before do
        visit work_path(work)
      end

      it 'shows "権限がありません。' do
        expect(page).to have_content "権限がありません。"
      end
    end
  end

  describe "create a work" do
    let!(:trained_model) { create(:trained_model) }

    before do
      # TODO: CreateVideosJob.perform_later(@work)がtestだとDB保存してくれないのでワークアラウンド。ちゃんと調査して対応する。
      allow(CreateVideosJob).to receive(:perform_later) do |work|
        work.delay.create_videos
        job = double
        allow(job).to receive(:provider_job_id) { Delayed::Job.last.id }
        job
      end

      visit new_work_path
      attach_file "work_original_video", support("df.mp4"), visible: false
      find("label[for=work_trained_model_id_#{trained_model.id}]").click
      click_on "動画を作る"
    end

    it 'shows "動画作成を受け付けました。"' do
      expect(page).to have_content "動画作成を受け付けました。"
    end
  end

  describe "destroy a work" do
    let!(:work) { create(:work, user: current_user) }

    before do
      visit work_path(work)
      page.accept_confirm do
        click_on "動画を削除する"
      end
    end

    it 'shows "動画を削除しました。"', js: true do
      expect(page).to have_content "動画を削除しました。"
    end
  end
end

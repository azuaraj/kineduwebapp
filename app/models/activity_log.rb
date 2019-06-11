class ActivityLog < ApplicationRecord
  belongs_to :baby
  belongs_to :assistant
  belongs_to :activity

  scope :with_baby_id, ->(baby) { where("baby_id LIKE ?", baby) }
  scope :with_assistant_id, -> (assistant) {where "assistant_id LIKE ?", assistant}
  scope :in_progress, -> {where("duration is ?", nil)}
  scope :finished, -> {where("duration is not NULL")}



  def self.search(params, status)
    if status == 0
      with_baby_id(params[:baby_id]).or(with_assistant_id(params[:assistant_id])).in_progress.includes(:baby, :assistant, :activity)
    elsif status == 1
      with_baby_id(params[:baby_id]).or(with_assistant_id(params[:assistant_id])).finished.includes(:baby, :assistant, :activity)
    end
  end

  def start_time
    attributes['start_time'].strftime("%Y-%m-%d %H:%M")
  end
end

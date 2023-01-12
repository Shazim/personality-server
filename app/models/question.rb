class Question < ApplicationRecord
  validates :question_text, presence: true
  
  has_many :answers, dependent: :destroy

  def total_points
    answers.map(&:point).max
  end
end

class Question < ApplicationRecord
  validates :question_text, presence: true
  
  has_many :answers, dependent: :destroy
end

class Answer < ApplicationRecord
  validates :answer_text, presence: true
  validates :point, presence: true
  
  belongs_to :question, optional: true
end

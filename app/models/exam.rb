class Exam < ApplicationRecord
  enum kind: %i[analisys clinical image]

  validates_presence_of :name, :kind
  validates :kind, inclusion: { in: kinds.keys, message: "%{value} is not a valid kind" }

  has_many :exam_laboratories, dependent: :destroy
  has_many :laboratories,  through: :exam_laboratories

  default_scope { where(status: true) }

  def disable!
    self.status = false
    save
  end
end

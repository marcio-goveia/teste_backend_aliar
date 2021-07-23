class Laboratory < ApplicationRecord
  validates_presence_of :name, :address

  has_many :exam_laboratories, dependent: :destroy
  has_many :exams, through: :exam_laboratories

  default_scope { where(status: true) }

  def disable!
    self.status = false
    save
  end
end

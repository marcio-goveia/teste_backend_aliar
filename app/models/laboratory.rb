class Laboratory < ApplicationRecord
  validates_presence_of :name, :address
  has_and_belongs_to_many :exams

  default_scope { where(status: true) }

  def disable!
    self.status = false
    save
  end
end

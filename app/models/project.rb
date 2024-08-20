class Project < ApplicationRecord
  belongs_to :user
# caution !!!!!
  has_many :drops, dependent: :destroy
  has_many :inboxes, dependent: :destroy
  has_many :tasks, dependent: :destroy
# caution !!!!!

  has_many :project_admins, dependent: :destroy

  def owned_by?(user)
    self.user == user
  end
  


end


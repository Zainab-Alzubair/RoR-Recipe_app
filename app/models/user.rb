class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :recipes, dependent: :destroy
  has_many :inventories, dependent: :destroy
  has_many :foods, dependent: :destroy

  validates :name, presence: true
  def admin?
    role == 'admin'
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  validates :name, presence: true, length: { maximum: 100 }       
  validates :company, presence: true, length: { maximum: 200 }

  has_many :posts, dependent: :destroy
end

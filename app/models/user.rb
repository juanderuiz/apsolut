class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Added by me
  #VALIDATIONS
  validates :name, :presence => true, :length => {:minimum => 3}
  #validates :bio, :length => {:maximum => 140}
  validates :email, :uniqueness => true
  #validates :datebirth, :presence => true


  #RELATIONSHIPS
  has_many :photos,  dependent: :destroy
  has_many :meetings
  has_many :quarters, dependent: :destroy
end

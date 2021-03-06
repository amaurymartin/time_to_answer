class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile
  accepts_nested_attributes_for :user_profile, reject_if: :all_blank

  # callback
  after_create :increment_total

  # validations
  validates :first_name, presence: true, length: { minimum: 3 }, on: :update, unless: :reset_password_token_present?

  # virtual attributes
  def full_name
    [first_name, last_name].join(' ')
  end

  private

  def increment_total
    AdminStat.increment_total(AdminStat::CONSTS[:users_total])
  end

  def reset_password_token_present?
    !$global_params[:user][:reset_password_token].nil?
  end
end

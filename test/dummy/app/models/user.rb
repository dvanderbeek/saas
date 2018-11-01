class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :owned_account, class_name: "Saas::Account", inverse_of: :owner, foreign_key: :owner_id

  # delegate :name, to: :account, prefix: true, allow_nil: true

  def account_name; owned_account&.name; end

  def account_name=(name)
    build_owned_account(name: name)
    # self.account = owned_account
  end
end

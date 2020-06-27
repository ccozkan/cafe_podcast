# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :subscriptions, dependent: :destroy
  has_many :podcasts, through: :subscriptions

  has_many :interactions, dependent: :destroy
  has_many :episodes, through: :interactions

  has_many :added_podcasts, class_name: 'Podcast', foreign_key: 'adder_id'
end

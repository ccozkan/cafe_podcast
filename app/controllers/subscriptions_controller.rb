# frozen_string_literal: true

require 'will_paginate/array'

class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @subscriptions = current_user.subscriptions.paginate(page: params[:page])
  end

  def create
    podcast = PodcastUpdater.call(url: subscription_params[:url]).first
    @subscription = Subscription.new(user_id: current_user.id, podcast_id: podcast.id)

    if @subscription.save
      redirect_to subscriptions_path
    else
      render json: @subscription.errors
    end
  end

  def new
    @subscription = Subscription.new
  end

  def destroy
    @subscription = current_user.subscriptions.friendly.find_by_slug(params[:slug])
    @subscription.destroy
    redirect_to subscriptions_path
  end

  def show
    # TODO:
    # add pagination
    @subscription = current_user.subscriptions.friendly.find_by_slug(params[:slug])
    @contents = @subscription.contents.reverse
    @contents = @contents.paginate(page: params[:page])
  end

  private

  def subscription_params
    params.permit(:url)
  end

  def user_subscribed?(podcast_id)
    current_user.subscriptions.find_by(podcast_id: podcast_id).nil?
  end
end

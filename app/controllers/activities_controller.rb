class ActivitiesController < ApplicationController
  before_filter :authenticate_user!, only: [:index]
  require 'will_paginate/array'

  def index
    @all_activities = PublicActivity::Activity.all

    set_1 = @all_activities.where(recipient_id: current_user.construction_site_ids, recipient_type: "ConstructionSite")
    set_2 = @all_activities.where(recipient_id: user_task_ids, recipient_type: "Task")
    @activities = PublicActivity::Activity.where(id: set_1.ids + set_2.ids).order('created_at DESC')
    @activities = @activities.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def user_task_ids
    cs = current_user.construction_sites
    all_tasks = []
    cs.each do |cs|
      all_tasks = all_tasks + cs.task_ids
    end
    all_tasks
  end
end

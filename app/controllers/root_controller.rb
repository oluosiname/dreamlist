class RootController < ApplicationController
  skip_before_action :authenticate_user, only: :index

  def index
    redirect_to "http://docs.dreamlist.apiary.io/"
  end
end

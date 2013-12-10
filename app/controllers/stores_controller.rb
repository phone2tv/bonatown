class StoresController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:show, :tagged]

  def show
  end

  def tagged
  end
end

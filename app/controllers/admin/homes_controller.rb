class Admin::HomesController < ApplicationController
  # 管理者以外はアクセスできないように
  before_action :authenticate_admin!

  def top
  end
end

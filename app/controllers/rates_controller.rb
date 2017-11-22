class RatesController < ApplicationController

  def create
    @comment = Comment.find(params[:rate][:comment])
    if @comment
      @rate = Rate.find_by(comment: @comment, user: current_user)
      unless @rate
        @rate = current_user.rates.new(comment: @comment)
      end
      if @rate.update_attributes(value: params[:rate][:value].to_i)
        respond_to do |format|
          format.html {redirect_to @comment.post}
          format.js
        end
      end
    end

  end
end

class StaticPagesController < ApplicationController
    def top
        @parks = Park.all
        Rails.logger.debug "DEBUG: parks = #{@parks}"
    end
end

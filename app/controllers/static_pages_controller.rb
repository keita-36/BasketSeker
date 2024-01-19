class StaticPagesController < ApplicationController
    def top
        @parks = Park.all
    end
end

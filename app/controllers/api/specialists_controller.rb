module API
  class SpecialistsController < ApplicationController
    def index
      render json: {
        specialists: Specialist.all.as_json(only: [:id, :name])
      }
    end
  end
end

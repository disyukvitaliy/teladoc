class AppointmentsQuery
  def initialize(params, scope = Appointment.all)
    @scope = scope
    @params = params
  end

  def call
    if @params[:date]
      date = Date.parse(@params[:date])
      @scope = @scope.where(time: [date.beginning_of_day..date.end_of_day])
    end

    if @params[:specialist_id]
      @scope = @scope.where(specialist_id: @params[:specialist_id])
    end

    if @params[:patient_id]
      @scope = @scope.where(patient_id: @params[:patient_id])
    end

    @scope
  end
end

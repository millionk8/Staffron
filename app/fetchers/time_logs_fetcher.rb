class TimeLogsFetcher < BaseFetcher

  def initialize(entities, params)
    modules = {
        scope: true,
    }

    # Date
    if params[:mode] == 'day'
      day = Date.parse(params[:day])
      start = day.beginning_of_day
      stop = day.end_of_day
    elsif params[:mode] == 'week'
      week = params[:week].to_i
      year = params[:year].to_i
      start = (Date.commercial(year, week, 1) - 1.day).beginning_of_day
      stop = (Date.commercial(year, week, 7) - 1.day).end_of_day
    elsif params[:mode] == 'custom'
      start = Date.parse(params[:start_date]).beginning_of_day
      stop = Date.parse(params[:end_date]).end_of_day
    else
      today = Time.current
      start = today.beginning_of_day
      stop = today.end_of_day
    end

    entities = entities.where('(started_at BETWEEN :start AND :stop) OR (stopped_at BETWEEN :start AND :stop)', start: start, stop: stop) if start.present? && stop.present?

    super(entities, params, modules)
  end

end
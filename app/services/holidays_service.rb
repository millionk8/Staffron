class HolidaysService
  def call
    params = {
      country: 'US',
      year: Date.today.year,
      type: 'national',
      api_key: ENV['HOLIDAY_API']
    }

    response = HTTP.get("https://calendarific.com/api/v2/holidays", params: params)
    repsonse = JSON.parse response.body.to_s
    
    repsonse['response']['holidays']
  end
end
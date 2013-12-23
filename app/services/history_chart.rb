class HistoryChart

  attr_reader :user

  def initialize user
    @user = user
  end

  def data
    days.inject({}) do |sum, day|
      sum[day] = {
        :impressions => favorites_for(day),
        :conversions => conversions_for(day)
      }
      sum
    end
  end

  def days
    ((Time.zone.now - 1.week).to_date..Time.zone.now.to_date).map { |a| a.strftime('%Y-%m-%d') }
  end

  def favorites
    @favorites ||= Favorite.where('term_id IN (?)', term_ids).last_week.group('DATE(favorited_at)').count
  end

  def conversions
    @conversions ||= Conversion.where('term_id IN (?)', term_ids).last_week.group('DATE(created_at)').count
  end

  def favorites_for day
    favorites[day] ? favorites[day] : 0
  end

  def conversions_for day
    conversions[day] ? conversions[day] : 0
  end

  def term_ids
    @term_ids ||= user.term_ids
  end

end
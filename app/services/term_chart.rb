class TermChart

  attr_reader :user

  def initialize user
    @user = user
  end

  def data
    term_ids.inject({}) do |sum, term|
      name = user.terms.find(term).term
      sum[name] = {
        :impressions => favorites[term],
        :conversions => conversions[term]
      }
      sum
    end
  end

  def days
    ((Time.zone.now - 1.week).to_date..Time.zone.now.to_date).map { |a| a.strftime('%Y-%m-%d') }
  end

  def favorites
    @favorites ||= Favorite.where('term_id IN (?)', term_ids).last_week.group('term_id').count
  end

  def conversions
    @conversions ||= Conversion.where('term_id IN (?)', term_ids).last_week.group('term_id').count
  end

  def term_ids
    @term_ids ||= user.term_ids
  end

end
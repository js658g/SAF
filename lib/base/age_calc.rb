# encoding: UTF-8
# $Id
require 'date'

module Base
  ##
  # Given a birth date, calculate their age today, for example,
  #   AgeCalculator.new('06/17/2000').age_calculate => 16
  # Assumes US time zone, and if future date, age = 0
  class AgeCalculator
    # Error messages raised
    INVALID_DATE_ERR_MSG = "Invalid date. \#{@date_err}".freeze

    def initialize(birth_date)
      @birth_date = birth_date
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable PerceivedComplexity
    # rubocop:disable CyclomaticComplexity
    # rubocop:disable RegexpLiteral

    # birth_date format must be mm/dd/yy{YY} or {YY}yy/mm/dd
    def age_calculate
      return unless @birth_date
      st_date = @birth_date.to_s.strip
      # parse date string provided and split into year, month, and day
      year, month, day = \
        case st_date
        # 22/1/16, 22\1\06 or 22.1.16
        when /\A(\d{1,2})[\\\/\.-](\d{1,2})[\\\/\.-](\d{2}|\d{4})\Z/
          [Regexp.last_match[3], Regexp.last_match[1], Regexp.last_match[2]]
        # 22 Feb 16 or 1 jun 2016
        when /\A(\d{1,2}) (\w{3,9}) (\d{2}|\d{4})\Z/
          [Regexp.last_match[3], Regexp.last_match[2], Regexp.last_match[1]]
        # July 1 2016
        when /\A(\w{3,9}) (\d{1,2})\,? (\d{2}|\d{4})\Z/
          [Regexp.last_match[3], Regexp.last_match[1], Regexp.last_match[2]]
        # 2016-01-01
        when /\A(\d{4})-(\d{2})-(\d{2})\Z/
          [Regexp.last_match[1], Regexp.last_match[2], Regexp.last_match[3]]
        # 2016-01-01T10:10:10+13:00
        when /\A(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})\Z/
          [Regexp.last_match[1], Regexp.last_match[2], Regexp.last_match[3]]
        # Not a valid date string
        else
          raise ArgumentError.new(INVALID_DATE_ERR_MSG
                                    .sub("\#{@date_err}",
                                         "#{@birth_date}: unknown formatting \
                                          of date string"))
        end

      # perform some minimal sanity checks on year, month, and day
      if year.to_i == 0 || month.to_i == 0 || day.to_i == 0
        raise ArgumentError.new(INVALID_DATE_ERR_MSG
                                    .sub("\#{@date_err}",
                                         "#{@birth_date}: zero not allowed"))
      end

      if year.length > 4 || year.length < 2
        raise ArgumentError.new(INVALID_DATE_ERR_MSG
                                    .sub("\#{@date_err}",
                                         "#{@birth_date}: invalid year \
                                          #{year}"))
      end

      if month.to_i > 13
        raise ArgumentError.new(INVALID_DATE_ERR_MSG
                         .sub("\#{@date_err}",
                              "#{@birth_date}: invalid month #{month}"))
      end

      if day.to_i > 32
        raise ArgumentError.new(INVALID_DATE_ERR_MSG
                .sub("\#{@date_err}",
                     "#{@birth_date}: invalid day #{day}"))
      end

      # parse the date_to_use and get a Date object, also checks for invalide date
      date_to_use = "#{year}/#{month}/#{day}"
      begin
        b_day = Date.parse(date_to_use)
      rescue => err
        # likely an invalid date
        raise err
      end

      # calculate age
      today = Date.today
      result = (today.strftime('%Y%m%d').to_i - b_day.strftime('%Y%m%d').to_i)/10000
      result < 0 ? result == 0 : result
    end
  end
end

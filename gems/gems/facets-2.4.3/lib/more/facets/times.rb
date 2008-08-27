# = Times
#
# WARNING: Use Rich Units package for future compatibilty!
#
# == Synopsis
#
# Plain-English convenience methods for dealing with dates and times.
#
# == HISTORY
#
# Thanks to Richard Kilmer for the orignal work and Alexander Kellett
# for suggesting it for Facets.
#
# Thanks to Dave Hoover and Ryan Platte for the Weekdays implementation.
#
# == AUTHORS
#
# * Rich Kilmer
# * Thomas Sawyer
# * Dave Hoover
# * Ryan Platte
# * George Moschovitis
#
# == NOTES
#
# * This library is not compatible with STICK's units.rb (an spin-off
#   of Facets old units.rb library). Do not attempt to use both at the same time.
#
# == TODOs
#
# * Extra Add in_* methods, like in_days, in_hours, etc.
#
# == COPYRIGHT
#
#   Copyright (c) 2005 Rich Kilmer, Thomas Sawyer
#
# == LICENSE
#
#   Ruby License
#
#   This module is free software. You may use, modify, and/or redistribute this
#   software under the same terms as Ruby.
#
#   This program is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#   FITNESS FOR A PARTICULAR PURPOSE.

require 'facets/time/change'
require 'facets/time/set'
require 'facets/time/ago'
require 'facets/time/hence'

class Time

  NEVER = Time.mktime(2038)
  ZERO  = Time.mktime(1972)

  # This method calculates the days extrema given two time objects.
  #   start time is the given time1 at 00:00:00
  #   end time is the given time2 at 23:59:59:999
  #
  # Input:
  # - the two times (if only time1 is provided then you get an extrema
  #   of exactly one day extrema.
  #
  # Output:
  # - the time range. you can get the start/end times using
  #   range methods.
  #
  #  CREDIT George Moschovitis

  def self.days_extrema(time1, time2=nil)
    time2 = time1 if (not time2.valid? Time)
    time2 = NEVER if (time2 <= time1)
    start_time = Time.self.start_of_day(time1)
    end_time = self.end_of_day(time2)
    return (start_time..end_time)
  end

  # Seconds since midnight: Time.now.seconds_since_midnight

  def seconds_since_midnight
    self.hour.hours + self.min.minutes + self.sec + (self.usec/1.0e+6)
  end

  # Returns a new Time representing the time a number of seconds ago.
  # Do not use this method in combination with x.months, use months_ago instead!
  #def ago(seconds)
  #  # This is basically a wrapper around the Numeric extension.
  #  #seconds.until(self)
  #  self - seconds
  #end

  # Returns a new Time representing the time
  # a number of minutes ago.

  def minutes_ago(minutes)
    self - (minutes * 60)
  end

  # Returns a new Time representing the time
  # a number of hours ago.

  def hours_ago(hours)
    self - (hours * 3600)
  end

  # Returns a new Time representing the time
  # a number of days ago.

  def days_ago(days)
    self - (days * 86400)
  end

  # Returns a new Time representing the time
  # a number of weeks ago.

  def weeks_ago(weeks)
    self - (weeks * 604800)
  end

  # Returns a new Time representing the time
  # a number of months ago.

  def months_ago(months)
    years = (month - months / 12).to_i
    set(:year=>(year - years), :month=>(month - months) % 12)
  end

  # Returns a new Time representing the time a number of specified
  # months ago.
  #def months_ago(months)
  #  if months >= self.month
  #    change(:year => self.year - 1, :month => 12).months_ago(months - self.month)
  #  else
  #    change(:year => self.year, :month => self.month - months)
  #  end
  #end

  # Returns a new Time representing the time
  # a number of years ago.

  def years_ago(years)
    set(:year=>(year - years))
  end

  # Returns a new Time representing the time a number of specified
  # years ago.
  #def years_ago(years)
  #  change(:year => self.year - years)
  #end

  # Returns a new Time representing the time
  # a number of minutes hence.

  def minutes_hence(minutes)
    self + (minutes * 60)
  end

  # Returns a new Time representing the time
  # a number of hours hence.

  def hours_hence(hours)
    self + (hours * 3600)
  end

  # Returns a new Time representing the time
  # a number of days hence.

  def days_hence(days)
    self + (days * 86400)
  end

  # Returns a new Time representing the time
  # a number of weeks hence.

  def weeks_hence(weeks)
    self + (weeks * 604800)
  end

  # Returns a new Time representing the time
  # a number of months hence.

  def months_hence(months)
    years = (month + months / 12).to_i
    set(:year=>(year + years), :month=>(month + months) % 12)
  end

  #def months_hence(months)
  #  if months + self.month > 12
  #    change(:year => self.year + 1, :month => 1).months_since(months - (self.month == 1 ? 12 : (self.month + 1)))
  #  else
  #    change(:year => self.year, :month => self.month + months)
  #  end
  #end

  # Returns a new Time representing the time
  # a number of years hence.

  def years_hence(years)
    set(:year=>(year + years))
  end

  # Returns a new Time representing the time a number of seconds
  # since the instance time. Do not use this method in combination
  # with x.months, use months_since instead!
  alias_method :since, :hence

  alias_method :minutes_since, :minutes_hence
  alias_method :days_since, :days_hence
  alias_method :weeks_since, :weeks_hence
  alias_method :months_since, :months_hence
  alias_method :years_since, :years_hence

  #def years_since(years)
  #  change(:year => self.year + years)
  #end

  # Short-hand for years_ago(1)
  def last_year
    years_ago(1)
  end

  # Short-hand for years_since(1)
  def next_year
    years_since(1)
  end

  # Short-hand for months_ago(1)
  def last_month
    months_ago(1)
  end

  # Short-hand for months_since(1)
  def next_month
    months_since(1)
  end

  # Returns a new Time representing the "start" of this week (Monday, 0:00)
  def beginning_of_week
    (self - self.wday.days).midnight + 1.day
  end
  alias :monday :beginning_of_week
  alias :at_beginning_of_week :beginning_of_week

  # Returns a new Time representing the start of the given
  # day in next week (default is Monday).
  def next_week(day = :monday)
    days_into_week = { :monday => 0, :tuesday => 1, :wednesday => 2,
                       :thursday => 3, :friday => 4, :saturday => 5,
                       :sunday => 6 }
    since(1.week).beginning_of_week.since(days_into_week[day].day).change(:hour => 0)
  end

  # Set time to end of day
  #def end_of_day
  #  return Time.mktime(year, month, day, 23, 59, 59, 999)
  #end

  # Returns a new Time representing the start of the day (0:00)
  def beginning_of_day
    self - self.seconds_since_midnight
  end
  alias :midnight :beginning_of_day
  alias :at_midnight :beginning_of_day
  alias :at_beginning_of_day :beginning_of_day
  alias :start_of_day :beginning_of_day

  # Returns a new Time representing the start of the month
  # (1st of the month, 0:00)
  def beginning_of_month
    #self - ((self.mday-1).days + self.seconds_since_midnight)
    change(:day => 1,:hour => 0, :min => 0, :sec => 0, :usec => 0)
  end
  alias_method :at_beginning_of_month, :beginning_of_month

  # Returns  a new Time representing the start of the year (1st of january, 0:00)
  def beginning_of_year
    change(:month => 1,:day => 1,:hour => 0, :min => 0, :sec => 0, :usec => 0)
  end
  alias :at_beginning_of_year :beginning_of_year

  # Convenience method which returns a new Time representing
  # the time 1 day ago
  def yesterday
    self.ago(1.day)
  end

  # Convenience method which returns a new Time representing
  # the time 1 day since the instance time
  def tomorrow
    self.since(1.day)
  end

  # Returns a new time at start of day
  def to_start_of_day
    return Time.mktime(year, month, day, 0, 0, 0, 0)
  end

  # Returns a new time at end of day
  def to_end_of_day
    Time.mktime(year, month, day, 23, 59, 59, 999)
  end

  # Returns true only if day of time is included in the
  # range (stime..etime). Only year days are checked.
  def in_day_range?(stime=ZERO, etime=NEVER)
    if (etime <= stime)
      warn "invalid end time (#{etime} < #{stime})" if $DEBUG
      etime = NEVER
    end

    stime = stime.to_start_of_day
    etime = etime.to_end_of_day

    return (stime..etime).include?(time)
  end
end


class Numeric

  # Enables the use of time calculations and declarations,
  # like 45.minutes + 2.hours + 4.years. The base unit for
  # all of these Numeric time methods is seconds.
  def seconds ; self ; end
  alias_method :second, :seconds
  #def as_seconds ; self ; end

  # Converts minutes into seconds.
  def minutes ; self * 60 ; end
  alias_method :minute, :minutes
  #def as_minutes ; self.to_f / 60 ; end

  # Converts hours into seconds.
  def hours ; self * 60.minutes ; end
  alias_method :hour, :hours
  #def as_hours ; self / 60.minutes ; end

  # Converts days into seconds.
  def days ; self * 24.hours ; end
  alias_method :day, :days
  #def as_days ; self / 24.hours ; end

  # Converts weeks into seconds.
  def weeks ; self * 7.days ; end
  alias_method :week, :weeks
  #def as_weeks ; self / 7.days ; end

  # Converts fortnights into seconds.
  # (A fortnight is 2 weeks)
  def fortnights ; self * 2.weeks ; end
  alias_method :fortnight, :fortnights
  #def as_fortnights ; self / 2.weeks ; end

  # Converts months into seconds.
  # WARNING: This is not exact as it assumes 30 days to a month.
  def months ; self * 30.days ; end
  alias_method :month, :months
  #def as_months ; self / 30.days ; end

  # Converts years into seconds.
  def years ; self * 365.days ; end
  alias_method :year, :years
  #def as_years ; self / 365.days ; end

  # Calculates time _before_ a given time. Default time is now.
  # Reads best with arguments: 10.days.before( Time.now - 1.day )
  def before(time = ::Time.now)
    time - self
  end
  alias_method :until, :before   # Reads best with argument: 10.minutes.until(time)
  alias_method :ago, :before     # Reads best without arguments: 10.minutes.ago

  # Calculates time _after_ a given time. Default time is now.
  # Reads best with argument: 10.minutes.after(time)
  def after(time = ::Time.now)
    time + self
  end
  alias_method :since, :after    # Reads best with argument: 10.minutes.since(time)
  alias_method :from_now, :after # Reads best without arguments: 10.minutes.from_now
  alias_method :later, :after    # Reads best without arguments: 10.minutes.later

  # Works with day in terms of weekdays.
  def weekdays
    Weekdays.new(self)
  end
  alias :weekday :weekdays

end


# The Weekdays class provides useful weekday terminology to Numeric.

class Weekdays
  WEEKDAYS = 1..5 # Monday is wday 1
  ONE_DAY = 60 * 60 * 24

  def initialize(n)
    @n = n
  end

  def ago(time = ::Time.now)
    step :down, time
  end
  alias :until :ago
  alias :before :ago

  def since(time = ::Time.now)
    step :up, time
  end
  alias :from_now :since
  alias :after :since

  private

  def step(direction, original_time)
    result = original_time
    time = ONE_DAY

    compare = direction == :up ? ">" : "<"
    time *= -1 if direction == :down

    @n.times do
      result += time until result.send(compare, original_time) && WEEKDAYS.member?(result.wday)
      original_time = result
    end
    result
  end
end


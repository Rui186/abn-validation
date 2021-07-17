class AbnValidateService
  attr_accessor :original_abn

  def initialize(abn = '')
    @original_abn = abn.chomp
    @abn = abn.gsub(/\s+/, '').split('').map(&:to_i)
  end

  def validate
    return false unless check_length
    update_abn_numbers
    sum = sum_with_weighting_factor
    reminder = calculate_reminder(sum)
    return true if reminder.zero?
  end

  private

  def check_length
    true if @abn.length == 11
  end

  def update_abn_numbers
    @abn[0] = @abn[0] - 1
    @abn
  end

  def sum_with_weighting_factor
    sum = 0
    @abn.each_with_index do |number, index|
      sum += (number * weightings[index])
    end
    sum
  end

  def calculate_reminder(sum)
    sum % modulus
  end

  def weightings
    [10, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19]
  end

  def modulus
    89
  end
end
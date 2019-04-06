# WeightsHelper
module WeightsHelper
  def validate_weights(weights)
    total = 100
    max = 92
    min = 1
    raise "Weights don't add up to 100!" if weights.flatten.sum != total

    raise "At least one weight is greater than #{max}: #{weights}" if weights.any? { |i| i.any? { |j| j > max } }

    raise "At least one weight is less than #{min}: #{weights}" if weights.any? { |i| i.any? { |j| j < min } }

    true
  end

  def read_weights(lookup, key)
    weights_s = lookup.get(key)
    return nil if weights_s.nil?

    # Only get this far if the key existed in the DB.
    weights = YAML.safe_load(weights_s)

    weights if validate_weights(weights)
  end

  def write_weights(lookup, key, weights)
    lookup.set(key, weights.to_yaml) if validate_weights(weights)
  end

  def reinforce_decision(lookup, decision)
    weights = read_weights(lookup, decision[0])
    if weights.nil?
      weights = [
        [6, 6, 6],
        [6, 6, 6],
        [6, 6, 6]
      ]
      weights[decision[1]][decision[2]] = 52
    else
      count = 0
      weights.each_index do |i|
        weights[i].each_index do |j|
          next if (i == decision[1] && j == decision[2]) || weights[i][j] <= 1

          weights[i][j] -= 1
          count += 1
        end
      end
      weights[decision[1]][decision[2]] += count
    end
    write_weights(lookup, decision[0], weights)
  end

  def deinforce_decision(lookup, decision)
    weights = read_weights(lookup, decision[0])
    if weights.nil?
      weights = [
        [12, 12, 12],
        [12, 12, 12],
        [12, 12, 12]
      ]
      weights[decision[1]][decision[2]] = 4
    else
      countdown = 8
      countdown = weights[decision[1]][decision[2]] - 1 if weights[decision[1]][decision[2]] <= countdown
      weights[decision[1]][decision[2]] -= countdown

      weights.each_index do |i|
        weights[i].each_index do |j|
          break if countdown.zero?

          # binding.pry
          # sleep 1
          # puts "countdown: #{countdown}, i: #{i}, j: #{j}, decision: #{decision}, weights: #{weights}"
          next if (i == decision[1] && j == decision[2]) || weights[i][j] >= 92

          weights[i][j] += 1
          countdown -= 1
        end
      end
    end
    write_weights(lookup, decision[0], weights)
  end

  def update_weights(lookup, winner_decisions, loser_decisions)
    winner_decisions.each do |decision|
      reinforce_decision(lookup, decision)
    end

    loser_decisions.each do |decision|
      deinforce_decision(lookup, decision)
    end
  end
end

def mask_to_set(mask, n)
  (0...n).select { |i| (mask & (1 << i)) != 0 }
end

def tsp_bottom_up(distance)
  n = distance.size
  inf = Float::INFINITY

  dp = Array.new(n) { Array.new(1 << n, inf) }
  parent = Array.new(n) { Array.new(1 << n, -1) }

  # Tahap 1: base case
  puts "\nTahap 1:"
  (1...n).each do |i|
    dp[i][1 << i] = distance[i][0]
    puts "f(#{i + 1}, ∅) = c_#{i + 1}1 = #{distance[i][0]}"
  end
  puts

  # Tahapan berikutnya
  last_subset_size = -1

  (1...(1 << n)).each do |mask|
    next if (mask & 1) != 0  # jangan kunjungi kota 1

    count = mask.to_s(2).count("1")

    if count != last_subset_size && count > 1
      puts "Tahap #{count}:\n"
      last_subset_size = count
    end

    next if count <= 1

    (0...n).each do |i|
      next if (mask & (1 << i)) == 0 || i == 0
      subset_str = mask_to_set(mask ^ (1 << i), n).map { |x| x + 1 }.join(", ")
      costs = []

      (0...n).each do |j|
        next if j == i || (mask & (1 << j)) == 0

        prev_mask = mask ^ (1 << i)
        cost = distance[i][j] + dp[j][prev_mask]
        costs << { cost: cost, term: "c_#{i+1}#{j+1} + f(#{j+1}, {#{mask_to_set(prev_mask ^ (1 << j), n).map { |x| x + 1 }.join(', ')}}) = #{distance[i][j]} + #{dp[j][prev_mask]} = #{cost}" }

        if cost < dp[i][mask]
          dp[i][mask] = cost
          parent[i][mask] = j
        end
      end

      puts "f(#{i + 1}, {#{subset_str}}) = min{#{costs.map { |c| c[:term].split('=').first.strip }.join(', ')}}"
      puts "             = min{#{costs.map { |c| c[:term].split('=').last.strip }.join(', ')}}"
      puts "             = #{dp[i][mask]}\n\n"

    end
  end

  # Selesaikan rute
  min_cost = inf
  last_city = -1
  full_mask = (1 << n) - 1

  puts "Perhitungan akhir:"
  terms = []
  sums = []

  (1...n).each do |i|
    cost_dp = dp[i][full_mask ^ 1]
    total = distance[0][i] + cost_dp

    subset_str = mask_to_set(full_mask ^ 1, n).reject { |x| x == 0 }.map { |x| x + 1 }.join(", ")
    terms << "c_1#{i + 1} + f(#{i + 1}, {#{(subset_str.split(", ").map(&:to_i) - [i + 1]).join(", ")}})"
    sums << "#{distance[0][i]} + #{cost_dp} = #{total}"

    if total < min_cost
      min_cost = total
      last_city = i
    end
  end

  puts "f(1, {#{(1...n).map { |i| i + 1 }.join(', ')}}) = min{#{terms.join(', ')}}"
  puts "                = min{#{sums.map { |s| s.split('=').last.strip }.join(', ')}}"
  puts "                = #{min_cost}\n\n"


  # Rekonstruksi rute
  route = [0]
  mask = full_mask ^ 1
  current = last_city
  while current != -1
    route << current
    prev = parent[current][mask]
    mask ^= (1 << current)
    current = prev
  end
  route << 0

  return min_cost, route.reverse
end

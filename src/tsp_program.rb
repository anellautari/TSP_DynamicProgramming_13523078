def tsp(distance)
  n = distance.length
  full_mask = (1 << n) - 1
  memo = Array.new(n) { Hash.new }

  # Basis: dari kota i ke kota 0 tanpa lewat kota lain
  (0...n).each do |i|
    memo[i][1 << i] = distance[i][0] if i != 0
  end

  # Rekursif DP: f(i, S) = min dari semua j di S-{i} (dist(i, j) + f(j, S-{i}))
  dp = ->(pos, visited) do
    return memo[pos][visited] if memo[pos].key?(visited)

    min_cost = Float::INFINITY
    (0...n).each do |next_city|
      next if visited & (1 << next_city) == 0 || next_city == pos

      prev_visited = visited ^ (1 << pos)
      cost = distance[pos][next_city] + dp.call(next_city, prev_visited)
      min_cost = [min_cost, cost].min
    end

    memo[pos][visited] = min_cost
    return min_cost
  end

  # Mencari solusi mulai dari kota 0, dengan semua kota telah dikunjungi
  min_total_cost = Float::INFINITY
  (1...n).each do |i|
    cost = distance[0][i] + dp.call(i, full_mask ^ 1)
    min_total_cost = [min_total_cost, cost].min
  end

  # Rekonstruksi rute
  route = [0]
  visited = full_mask
  current = 0

  while route.length < n
    next_city = nil
    min_cost = Float::INFINITY

    (0...n).each do |i|
      next if i == current || visited & (1 << i) == 0
      cost = distance[current][i] + memo[i][visited ^ (1 << current)].to_f
      if cost < min_cost
        min_cost = cost
        next_city = i
      end
    end

    route << next_city
    visited ^= (1 << current)
    current = next_city
  end

  route << 0  # kembali ke kota awal

  return min_total_cost, route
end

# --- INPUT ---

# puts "Masukkan jumlah kota:"
# n = gets.to_i

# puts "Masukkan matriks jarak (pisahkan dengan spasi per baris):"
# distance = []
# n.times do
#   row = gets.strip.split.map(&:to_i)
#   distance << row
# end

# # --- SOLUSI ---
# min_cost, route = tsp(distance)

# # --- OUTPUT ---
# puts "\nJarak minimum: #{min_cost}"
# puts "Rute: #{route.map { |x| x + 1 }.join(' -> ')}"

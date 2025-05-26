require_relative 'tsp_program'

puts "Masukkan jumlah kota:"

n = gets.to_i
puts "Masukkan matriks jarak antar kota (pisahkan dengan spasi):"
distance = []
n.times do
  row = gets.strip.split.map(&:to_i)
  distance << row
end

min_cost, route = tsp_program(distance)

puts "Rute optimal: #{route.map { |x| x + 1 }.join(' -> ')}"
puts "Biaya/bobot minimum untuk mengunjungi semua kota: #{min_cost}"

require_relative 'tsp_program'

puts "Selamat datang di program TSP!"
puts "Masukkan jumlah kota:"

n = gets.to_i
puts "Masukkan jarak antar kota (dalam format matriks pisahkan dengan spasi per baris):"
distance = []
n.times do
  row = gets.strip.split.map(&:to_i)
  distance << row
end

min_cost, route = tsp(distance)

puts "\nBiaya minimum untuk mengunjungi semua kota: #{min_cost}"
puts "Rute yang harus diambil: #{route.map { |x| x + 1 }.join(' -> ')}"

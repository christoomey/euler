require 'json'

Cell = Struct.new :row, :column
class Matrix
  attr_reader :cells

  def initialize cells
    @cells = cells
  end

  def length
    return @cells.length
  end

  def value_in_cell cell
    @cells[cell.row-1][cell.column-1]
  end

  def column n
    @cells.collect {|row| row[n-1]}
  end

  def row n
    @cells[n-1]
  end

  def right cell
    return if cell.column > 17
    row = self.row cell.row
    return row.slice (cell.column - 1), 4
  end

  def down cell
    return if cell.row > 17
    column = self.column cell.column
    return column.slice (cell.row - 1), 4
  end

  def diagonal_down cell
    return if cell.column > 17
    return if cell.row > 17
    (1..4).collect {|i| self.value_in_cell Cell.new (cell.row - 1 + i), (cell.column - 1 + i)}
  end

  def diagonal_up cell
    return if cell.column > 17
    return if cell.row < 4
    (1..4).collect do |i|
      adjacent_cell = Cell.new (cell.row + 1 - i), (cell.column - 1 + i)
      self.value_in_cell adjacent_cell
    end
  end
end

def main
  matrix = Matrix.new File.open("support/011-adjacent_sum.txt", "r") {|f| JSON.parse f.read}
  dimension = matrix.length
  max = 0
  (1..dimension).each do |row|
    (1..dimension).each do |column|
      cell = Cell.new row, column
      adjacents = []
      adjacents.push matrix.right cell
      adjacents.push matrix.down cell
      adjacents.push matrix.diagonal_down cell
      adjacents.push matrix.diagonal_up cell
      local_max = adjacents.compact.collect {|set| set.inject &:* }.max
      next unless local_max
      max = local_max if local_max > max
    end
  end
  puts max
end

main

class Game
  def initialize
    @board = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
    @player = 1
    @player_symbol = 'X'
    @turns = 9
  end

  private

  attr_accessor :board, :player, :player_symbol, :turns

  def draw_board(board_array)
    puts " #{board_array[0][0]} | #{board_array[0][1]} | #{board_array[0][2]} "
    puts '---+---+---'
    puts " #{board_array[1][0]} | #{board_array[1][1]} | #{board_array[1][2]} "
    puts '---+---+---'
    puts " #{board_array[2][0]} | #{board_array[2][1]} | #{board_array[2][2]} \n\n"
  end

  def return_winner(board_array, current_player, turns_left)
    # check horizontal lines
    board_array.each do |row|
      return "Player #{current_player} wins!" if row[0] == row[1] && row[1] == row[2]
    end

    # check vertical lines
    (0..2).each do |column|
      if board_array[0][column] == board_array[1][column] && board_array[1][column] == board_array[2][column]
        return "Player #{current_player} wins!"
      end
    end

    # check diagonal lines
    if (board_array[0][0] == board_array[1][1] && board_array[1][1] == board_array[2][2]) || (board_array[0][2] == board_array[1][1] && board_array[1][1] == board_array[2][0])
      return "Player #{current_player} wins!"
    end

    "It's a tie!" if turns_left.zero?
  end

  public

  def start_game
    game_over = false

    until game_over
      answer = ''

      until (1..9).include?(answer.to_i)
        draw_board(board)

        puts "Player #{player}, select a number:\n\n"

        answer = gets.chomp
      end

      puts "\n"

      break_loop = false
      board.each_with_index do |row, row_index|
        break if break_loop

        row.each_with_index do |column, column_index|
          next unless answer.to_i == column

          board[row_index][column_index] = player_symbol
          self.turns -= 1

          winner = return_winner(board, player, turns)

          if winner
            draw_board(board)

            puts winner

            game_over = true
          elsif player == 1
            self.player = 2
            self.player_symbol = 'O'
          else
            self.player = 1
            self.player_symbol = 'X'
          end

          break_loop = true
          break
        end
      end
    end
  end
end

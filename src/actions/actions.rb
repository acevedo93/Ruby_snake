require_relative "../model/state"

module Actions
    def self.move_snake(state) 
        next_direction = state.next_direction
        next_position = calc_next_position(state)
        if position_is_food?(state, next_position)
            state = grow_snake_to(state, next_position)
            generate_food(state)        
        elsif position_is_valid?(state, next_position)
            move_snake_to(state, next_position)
        else
            end_game(state)
        end
    end

    private
    def self.generate_food(state)
        new_food = Model::Food.new(rand(state.grid.cols), rand(state.grid.rows))
        state.food = new_food
        puts state.food
        state
    end

    def self.grow_snake_to(state, next_position)
        #todo implement
        new_state = [next_position] + state.snake.positions
        state.snake.positions = new_state
        state
    end
    def self.calc_next_position(state)
        curr_position = state.snake.positions.first
        case state.next_direction
            when :up
                
                return Model::Coord.new(
                    curr_position.row - 1,
                    curr_position.col
                )
            when :down
                return Model::Coord.new(
                    curr_position.row + 1,
                    curr_position.col
                )
            when :left
                return Model::Coord.new(
                    curr_position.row,
                    curr_position.col - 1
                )
            when :right
                return Model::Coord.new(
                    curr_position.row,
                    curr_position.col + 1,
                )
        end 
    end
    def self.position_is_food?(state, next_position)
         result = state.food.row == next_position.row && state.food.col == next_position.col 
    end
    def self.position_is_valid?(state, position)
        is_invalid = ((position.row >= state.grid.rows || position.row < 0) || ( position.col >= state.grid.cols || position.col < 0))
        return false if is_invalid

        #verificar que no choque con la serpiente
        return !(state.snake.positions.include? position)
    end
    def self.move_snake_to(state, next_position)
        new_positions = [next_position] + state.snake.positions[0...-1]
        state.snake.positions = new_positions
        state
    end

    def self.change_direction(state, direction)
        if next_direction_is_valid?(state, direction)
            state.next_direction = direction
        else
            puts "Invalid direction"
            state
        end
        state
    end
    def self.next_direction_is_valid?(state,direction)
        curr_direction = state.next_direction
        case curr_direction
            when Model::Direction::UP
                return true if direction != Model::Direction::DOWN
            when Model::Direction::DOWN
                return true if direction != Model::Direction::UP
            when Model::Direction::LEFT
                return true if direction != Model::Direction::LEFT
            when Model::Direction::RIGHT
                return true if direction != Model::Direction::RIGHT
            return false
        end
    end
    def self.end_game(state)
        state.game_finished = true
        state
    end
end
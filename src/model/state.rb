module Model
    module Direction
        UP = :up
        DOWN = :down
        RIGHT = :right
        LEFT = :left
    end
    # una coordenada tendra una posicion 
    # de fila o de columna 
    class Coord < Struct.new(:row, :col) 
    end
    # Una comida heredara una coordenada
    class Food < Coord
    end
    # la serpiente tenra un array de coordenadas
    class Snake < Struct.new(:positions)
    end

    class Grid < Struct.new(:rows, :cols)
    end

    class State < Struct.new(:snake, :food, :grid, :next_direction, :game_finished)
    end

    def self.initial_state
        Model::State.new(
            Model::Snake.new([
                Model::Coord.new(1, 1),
                Model::Coord.new(0, 1)
            ]),
            Model::Food.new(4, 4),
            Model::Grid.new(12, 12),
            Direction::DOWN,
            false
        )
    end
end
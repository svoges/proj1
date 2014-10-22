class PokemonsController < ApplicationController
  def capture
    @pokemon = Pokemon.find(params[:id])
    @pokemon.trainer_id = current_trainer[:id]
    @pokemon.save
    redirect_to root_path
  end

  def damage
    @pokemon = Pokemon.find(params[:id])
    if @pokemon.health.nil?
      @pokemon.destroy
    else
      @pokemon.health -= 10
    end
    if @pokemon.health <= 0
      @pokemon.destroy
    else
      @pokemon.save
    end
    redirect_to trainer_path(current_trainer[:id])
  end

  def new
    render 'new'
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.health = 100
    @pokemon.level = 1
    @pokemon.trainer_id = current_trainer[:id]
    @pokemon.save
    if not @pokemon.errors.full_messages.empty?
      flash[:error] = @pokemon.errors.full_messages.to_sentence
      redirect_to pokemons_new_path
    else
      redirect_to trainer_path(current_trainer[:id])
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name)
  end

end

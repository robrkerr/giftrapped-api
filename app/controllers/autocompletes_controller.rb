class AutocompletesController < ApplicationController
  
  def show
  	words = auto_complete(params[:term],params[:limit])
    respond_to do |format|
      format.json { render :json => words.to_json }
    end
  end

  private

  def auto_complete term, number
    return [] if term == ""
    words = Spelling.where("label LIKE ?", "#{term}%").limit(number).map { |sp| sp.words }.flatten
    words.map { |w| {
        :label => w.name, 
        :phonetic_label => w.pronunciation.label,
        :num_syllables => w.num_syllables,
        :id => w.id
      }
    }
  end
end
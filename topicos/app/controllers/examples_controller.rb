class ExamplesController < ApplicationController
  layout "welcome"
  def form
    @nombre = params[:nombre_usuario]
  end
end

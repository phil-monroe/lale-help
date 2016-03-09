module CellsHelper

  # simple abstraction layer in case we want to stop using cells
  # FIXME find better method name
  def render_cell(name, args = {}, action = :show)
    cell(name, args.delete(:model), args).call(action)
  end

end
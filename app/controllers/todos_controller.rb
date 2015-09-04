class TodosController < ApplicationController
  helper_method :current_filter

  def index
    @todos = Todo
  end

  def active
    @todos = Todo.active

    set_current_filter(:active)

    render :index
  end

  def completed
    @todos = Todo.completed

    set_current_filter(:completed)

    render :index
  end

  def create
    @todos = Todo
    @todo = Todo.new(todo_params)
    @todo.save

    render :index
  end

  def update
    @todos = Todo
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
    render :index
  end

  def destroy_completed
    @todos = Todo
    @todos_for_destruction = Todo.completed.all

    Todo.completed.destroy_all

    render :index
  end

  def destroy
    @todos = Todo
    @todo = Todo.find(params[:id])
    @todo.destroy

    render :index
  end

  def toggle
    @todos = Todo
    @todo = Todo.find(params[:id])
    @todo.toggle!(:completed)

    render :index
  end

  def toggle_all
    Todo.update_all(completed: params[:completed] ? 't' : 'f')

    @todos = Todo.all

    render :index
  end

private

  def todo_params
    params.require(:todo).permit(:title, :completed)
  end

  def set_current_filter(filter)
    @current_filter = filter
  end

  def current_filter
    @current_filter
  end
end

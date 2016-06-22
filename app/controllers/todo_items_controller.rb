class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create]

	def create
		@todo_item = @todo_list.todo_items.create(todo_item_params)
		redirect_to @todo_list
	end

	def destroy
		@todo_item = @todo_list.todo_items.find(params[:id])
		if @todo_item.destroy
			flash[:success] = "할일을 지웠습니다. ㅠㅠ"
		else
			flash[:error] = "다시 시도해 주세요."
		end
		redirect_to @todo_list
	end

	def complete
		@todo_item.update_attribute(:completed_at, Time.now)
		redirect_to @todo_list, notice: "할일을 완료 했습니다! 축하합니다 *^^*"
	end

	private

	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])
	end 

	def set_todo_item
		@todo_item = @todo_list.todo_items.find(params[:id])
	end

	def todo_item_params
		params[:todo_item].permit(:content)
	end

end

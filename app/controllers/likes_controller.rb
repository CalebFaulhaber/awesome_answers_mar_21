class LikesController < ApplicationController
    #rails g controller likes --no-helper --no-assets --no-controller-specs --no-view-specs --skip-template-engine

    def create
        question = Question.find params[:question_id]
        like = Like.new(question: question, user: current_user)

        if !can?(:like, question)
            flash[:danger] = "You can't like your own question"
        elsif like.save
            flash[:success] = "Question liked!"
        else
            flash[:danger] = like.errors.full_messages.join(', ')
        end
        redirect_to question_path(question)
    end

    def destroy
        like = current_user.likes.find params[:id]

        if !can?(:destroy, like)
            flash[:warning] = "You cannot destroy a like you don't own"
        elsif like.destroy
            flash[:success] = "Question Unliked"
        else
            flash[:warning] = "Could not Unlike Question"
        end
        redirect_to question_path(like.question)
    end
end

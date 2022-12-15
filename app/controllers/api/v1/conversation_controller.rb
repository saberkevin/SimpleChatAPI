module Api
    module V1
        class ConversationController < ApplicationController
            def create
                @conversation = Conversation.new(conversation_params)

                if conversation_params[:message].empty?
                    render @conversation.errors, status: :unprocessable_entity
                elsif @conversation.save
                    render json: @conversation
                else 
                    render json: @conversation.errors, status: :unprocessable_entity
                end

            end

            private
            def conversation_params
                params.require(:conversation).permit(:user_id_from, :user_id_to, :message,:read_status)
            end
        end        
    end
end
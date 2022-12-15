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

            def currentChat
                Conversation.where(:user_id_from => currentChat_params[:user_id_to]).update_all(read_status: true)

                @conversation = Conversation.find_by_sql("SELECT conversations.* FROM conversations WHERE user_id_from IN("+currentChat_params[:user_id_from].to_s+"," +currentChat_params[:user_id_to].to_s+") AND user_id_to IN("+currentChat_params[:user_id_from].to_s+"," +currentChat_params[:user_id_to].to_s+")")
                render json: @conversation
            end



            private
            def currentChat_params
                params.require(:conversation).permit(:user_id_from, :user_id_to)
            end

            private
            def conversation_params
                params.require(:conversation).permit(:user_id_from, :user_id_to, :message,:read_status)
            end
            
        end        
    end
end
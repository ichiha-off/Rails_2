class BooksController < ApplicationController
    def index
        @books = Book.all
        @book = Book.new
    end

    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        @books = Book.all
        if @book.save
            redirect_to books_path
        else
            render :index
        end
    end

    def show
        @book = Book.find(params[:id])
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:update] = "Book was successfully updated."
            redirect_to books_path
        else
            render :edit
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        flash[:delete] = 'Book was successfully destroyed.'
        redirect_to books_path
    end

private
    def book_params
        params.require(:book).permit(:title, :body)  
    end

end

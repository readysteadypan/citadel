module Forums
  class ThreadPresenter < BasePresenter
    presents :thread

    def link
      link_to(thread.title, forums_thread_path(thread))
    end

    def path
      html_escape(PATH_SEP) + safe_join(path_objects, PATH_SEP)
    end

    def to_s
      thread.title
    end

    private

    def path_objects
      present_collection(thread.path).map(&:link)
    end
  end
end

module Impressionist
  module IsImpressionable
    extend ActiveSupport::Concern

    module ClassMethods
      def is_impressionable(options={})
        define_association options.delete( :dependent )
        @impressionist_cache_options = options

        true
      end

      private

      def define_association( dependent = NIL )
        # Don't remove the logs recarding if it is destroyed
        if dependent == :ignore
          has_many(:impressions,
            :as => :impressionable)
        else
          has_many(:impressions,
            :as => :impressionable,
            :dependent => :destroy)
        end
      end
    end

  end
end
class FooterComponent < ApplicationComponent
  erb_template <<~ERB
    <footer class="sticky w-full bottom-0 top-[100vh] bg-white text-center p-4 border-t">
      <p>&copy <%= Date.current.year %> <%= Owner.name %></p>
    </footer>
  ERB
end

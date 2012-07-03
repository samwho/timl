Timl.start :pretty do
  html do
    head do
      script do
        "alert('Wassup!');"
      end
    end

    body do
      table do
        tr do
          th { "Key" }
          th { "Value" }
        end

        tr do
          td { "Foo" }
          td { "Bar" }
        end
      end
    end
  end
end

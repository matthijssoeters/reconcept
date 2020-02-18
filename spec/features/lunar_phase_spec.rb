require 'rails_helper'

feature 'lunar phase' do

  before(:each) do
    visit root_path
  end

  feature 'request 01-02-2020' do
    scenario 'as json' do
      expect(page).to have_text("Reconcept Astronomy")
      expect(page).to have_text("Lunar phase")

      within "#as_json" do
        VCR.use_cassette("lunar_phase_01-02-2020", :match_requests_on => [:method, :host, :headers]) do
          expect(page).to have_text("Select date")
          fill_in "date", with: "2020-02-01"
          click_button "Get lunar phase"
        end
      end

      expect(page).not_to have_text("Reconcept Astronomy")
      expect(page).not_to have_text("Lunar phase")

      expect(page).to have_text("{\"name\":\"Amsterdam\",\"country\":{\"id\":\"nl\",\"name\":\"Netherlands\"},\"latitude\":52.373,\"longitude\":4.894,\"date\":\"2020-02-01\",\"moonphase\":\"waxingcrescent\"}")
    end

    scenario 'as json on page', js: true do
      expect(page).to have_text("Reconcept Astronomy")
      expect(page).to have_text("Lunar phase")

      within "#on_page" do
        VCR.use_cassette("lunar_phase_01-02-2020", :match_requests_on => [:method, :host, :headers]) do
          expect(page).to have_text("Select date")
          fill_in "date", with: "2020-02-01"
          click_button "Get lunar phase"
        end
      end

      expect(page).to have_text("Reconcept Astronomy")
      expect(page).to have_text("Lunar phase")

      expect(page).to have_text("{\"name\":\"Amsterdam\",\"country\":{\"id\":\"nl\",\"name\":\"Netherlands\"},\"latitude\":52.373,\"longitude\":4.894,\"date\":\"2020-02-01\",\"moonphase\":\"waxingcrescent\"}")
    end
  end


  feature 'request 17-02-2020' do
    scenario 'as json' do
      expect(page).to have_text("Reconcept Astronomy")
      expect(page).to have_text("Lunar phase")

      within "#as_json" do
        VCR.use_cassette("lunar_phase_17-02-2020", :match_requests_on => [:method, :host, :headers]) do
          expect(page).to have_text("Select date")
          fill_in "date", with: "2020-02-17"
          click_button "Get lunar phase"
        end
      end

      expect(page).not_to have_text("Reconcept Astronomy")
      expect(page).not_to have_text("Lunar phase")

      expect(page).to have_text("{\"name\":\"Amsterdam\",\"country\":{\"id\":\"nl\",\"name\":\"Netherlands\"},\"latitude\":52.373,\"longitude\":4.894,\"date\":\"2020-02-17\",\"moonphase\":\"waningcrescent\"}")
    end

    scenario 'as json on page', js: true do
      expect(page).to have_text("Reconcept Astronomy")
      expect(page).to have_text("Lunar phase")

      within "#on_page" do
        VCR.use_cassette("lunar_phase_17-02-2020", :match_requests_on => [:method, :host, :headers]) do
          expect(page).to have_text("Select date")
          fill_in "date", with: "2020-02-17"
          click_button "Get lunar phase"
        end
      end

      expect(page).to have_text("Reconcept Astronomy")
      expect(page).to have_text("Lunar phase")

      expect(page).to have_text("{\"name\":\"Amsterdam\",\"country\":{\"id\":\"nl\",\"name\":\"Netherlands\"},\"latitude\":52.373,\"longitude\":4.894,\"date\":\"2020-02-17\",\"moonphase\":\"waningcrescent\"}")
    end
  end

  feature "request expired" do
    scenario 'as json' do
      within "#as_json" do
        VCR.use_cassette("lunar_phase_expired", :match_requests_on => [:method, :host, :headers]) do
          expect(page).to have_text("Select date")
          fill_in "date", with: "2020-02-17"
          click_button "Get lunar phase"
        end
      end

      expect(page).to have_text("Reconcept Astronomy")
      expect(page).to have_text("Lunar phase")
      expect(page).to have_text("Request expired.")

      expect(page).not_to have_text("{\"name\":\"Amsterdam\",\"country\":{\"id\":\"nl\",\"name\":\"Netherlands\"},\"latitude\":52.373,\"longitude\":4.894,\"date\":\"2020-02-17\",\"moonphase\":\"waningcrescent\"}")
    end

    scenario 'as json on page', js: true do
      expect(page).to have_text("Reconcept Astronomy")
      expect(page).to have_text("Lunar phase")

      within "#on_page" do
        VCR.use_cassette("lunar_phase_expired", :match_requests_on => [:method, :host, :headers]) do
          expect(page).to have_text("Select date")
          fill_in "date", with: "2020-02-17"
          click_button "Get lunar phase"
        end
      end

      expect(page).to have_text("Reconcept Astronomy")
      expect(page).to have_text("Lunar phase")
      expect(page).to have_text("Request expired.")

      expect(page).not_to have_text("{\"name\":\"Amsterdam\",\"country\":{\"id\":\"nl\",\"name\":\"Netherlands\"},\"latitude\":52.373,\"longitude\":4.894,\"date\":\"2020-02-17\",\"moonphase\":\"waningcrescent\"}")
    end
  end
end
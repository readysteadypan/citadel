require 'rails_helper'

describe API::V1::LeaguesController, type: :request do
  let(:api_key) { create(:api_key) }
  let(:league) { create(:league) }

  describe 'GET #show' do
    let(:route) { '/api/v1/leagues' }

    it 'succeeds for existing league' do
      get "#{route}/#{league.id}", headers: { 'X-API-Key' => api_key.key }

      json = response.parsed_body
      league_h = json['league']
      expect(league_h).to_not be_nil
      expect(league_h['name']).to eq(league.name)
      expect(league_h['rosters']).to be_empty
      expect(league_h['matches']).to be_empty
      expect(response).to be_successful
    end

    it 'succeeds for non-existent league' do
      get "#{route}/-1", headers: { 'X-API-Key' => api_key.key }

      json = response.parsed_body
      expect(json['status']).to eq(404)
      expect(json['message']).to eq('Record not found')
      expect(response).to be_not_found
    end

    it 'succeeds for hidden league' do
      league.update(status: 'hidden')

      get "#{route}/#{league.id}", headers: { 'X-API-Key' => api_key.key }

      json = response.parsed_body
      expect(json['status']).to eq(404)
      expect(json['message']).to eq('Record not found')
      expect(response).to be_not_found
    end
  end
end

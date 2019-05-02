require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe LaboursController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Labour. As you add validations to Labour, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LaboursController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all labours as @labours" do
      labour = Labour.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:labours)).to eq([labour])
    end
  end

  describe "GET show" do
    it "assigns the requested labour as @labour" do
      labour = Labour.create! valid_attributes
      get :show, {:id => labour.to_param}, valid_session
      expect(assigns(:labour)).to eq(labour)
    end
  end

  describe "GET new" do
    it "assigns a new labour as @labour" do
      get :new, {}, valid_session
      expect(assigns(:labour)).to be_a_new(Labour)
    end
  end

  describe "GET edit" do
    it "assigns the requested labour as @labour" do
      labour = Labour.create! valid_attributes
      get :edit, {:id => labour.to_param}, valid_session
      expect(assigns(:labour)).to eq(labour)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Labour" do
        expect {
          post :create, {:labour => valid_attributes}, valid_session
        }.to change(Labour, :count).by(1)
      end

      it "assigns a newly created labour as @labour" do
        post :create, {:labour => valid_attributes}, valid_session
        expect(assigns(:labour)).to be_a(Labour)
        expect(assigns(:labour)).to be_persisted
      end

      it "redirects to the created labour" do
        post :create, {:labour => valid_attributes}, valid_session
        expect(response).to redirect_to(Labour.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved labour as @labour" do
        post :create, {:labour => invalid_attributes}, valid_session
        expect(assigns(:labour)).to be_a_new(Labour)
      end

      it "re-renders the 'new' template" do
        post :create, {:labour => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested labour" do
        labour = Labour.create! valid_attributes
        put :update, {:id => labour.to_param, :labour => new_attributes}, valid_session
        labour.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested labour as @labour" do
        labour = Labour.create! valid_attributes
        put :update, {:id => labour.to_param, :labour => valid_attributes}, valid_session
        expect(assigns(:labour)).to eq(labour)
      end

      it "redirects to the labour" do
        labour = Labour.create! valid_attributes
        put :update, {:id => labour.to_param, :labour => valid_attributes}, valid_session
        expect(response).to redirect_to(labour)
      end
    end

    describe "with invalid params" do
      it "assigns the labour as @labour" do
        labour = Labour.create! valid_attributes
        put :update, {:id => labour.to_param, :labour => invalid_attributes}, valid_session
        expect(assigns(:labour)).to eq(labour)
      end

      it "re-renders the 'edit' template" do
        labour = Labour.create! valid_attributes
        put :update, {:id => labour.to_param, :labour => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested labour" do
      labour = Labour.create! valid_attributes
      expect {
        delete :destroy, {:id => labour.to_param}, valid_session
      }.to change(Labour, :count).by(-1)
    end

    it "redirects to the labours list" do
      labour = Labour.create! valid_attributes
      delete :destroy, {:id => labour.to_param}, valid_session
      expect(response).to redirect_to(labours_url)
    end
  end

end
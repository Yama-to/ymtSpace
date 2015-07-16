# ymtSpace planning sheet

## ymtSpace

**One of demo-versions of `ProtoSpace`;** an authorized app of we-b Inc.

## Major Functions

1. Share ideas of prototypes of our own products by uploading images and summaries.
2. Communicate with others over prototypes and show regards by putting thumbs up (LIKE).
3. Search for prototypes effectively and continuously by jumping links of tags or ranks.

## Detailed Functions of Each Tables

- `Users` are enabled to...
  1. Sign up

    `=> 'devise/registrations#new'`

  2. Sign in

    `=> 'devise/sessions#new'`

  3. Logout

    `=> 'devise/sessions#destroy'`

  4. Edit

    `=> 'devise/registrations#edit'`

  5. Show profiles & posts

    `=> 'users#show'`

- `Prototypes` & `Thumbnails` are together enabled to...
  1. Input

    `=> 'prototypes#new'`

  2. Save

    `=> 'prototypes#create'`

  3. List

    `=> 'prototypes#index'` & `root_path`

  4. Show details

    `=> 'prototypes#show'`

  5. Edit

    `=> 'prototypes#edit'`

  6. Update

    `=> 'prototypes#update'`

  7. Delete

    `=> 'prototypes#destroy'`

- `Comments` are enabled to...

  1. Input

    `=> 'prototypes#show'`

  2. Save

    `=> 'comments#create'`



- `Likes` are enabled to...

  1. Save & Count

    **`=> undefined`**

- `Tags` are enabled to...

  1. Input

    `=> 'prototypes#new'`

  2. Save

    `=> 'prototypes#create'`

  3. List

    `=> 'tags#index'`

## Associations among Tables

- Users
  1. has_many   `Prototypes`
  2. has_many   `Likes`
  3. has_many   `Comments`
  4. has_one    `Image`

    (as: `parent`)

- Prototypes
  1. has_many   `Comments`
  2. has_many   `Likes`
  3. has_many   `Images`

    (as: `parent`)

  4. has_many   `Tags`

    (through: `Tagging`)

  5. belongs_to `User`

- Images
  1. belongs_to `Parent`

    (polymorphic: `true`)

- Comments
  1. belongs_to `User`
  2. belongs_to `Prototype`

- Likes
  1. belongs_to `User`
  2. belongs_to `Prototype`

- Tags
  1. has_many   `Prototypes`

    (through: `Tagging`)

## Function Minutes

- for functions around user sign in&out

  **gem 'devise'**

  ```bash
  $ rails g devise user
  $ rails g devise:install
  $ rails g devise:views
  ```

- to administrate users' avatars & prototypes' thumbnails
- (with polyomorphic association)

  **gem 'carrierwave'**
  **gem 'rmagick'**

  ```bash
  $ rails g uploader Image
  ```

  ```ruby
  class Image < ActiveRecord::Base
    mount_uploader :image, ImageUploader
    belongs_to :parent, polymorphic: true
  end
  ```

  ```ruby
  class User < ActiveRecord::Base
    has_one :image, as: :parent, dependent: :destroy
  end
  ```

  ```ruby
  class Prototype < ActiveRecord::Base
    has_many :images, as: :parent, dependent: :destroy
  end
  ```

- to set multiple thumbnails at one time for one prototype
- to set user's avatar together when setting profile

  **ActiveRecord::NestedAttributes**

  ```ruby
  class Prototype < ActiveRecord::Base
    accepts_nested_attributes_for :images
  end
  ```

  ```ruby
  class User < ActiveRecord::Base
    accepts_nested_attributes_for :images
  end
  ```
- to count the number of likes linked to each prototypes

  **ActiveRecord::Assosciations :counter_cache**

  ```bash
  $ rails g migration AddCounterToPrototypes likes_count:integer
  ```

  ```ruby
  class AddCounterToPrototypes < ActiveRecord::Migration
    add_column
  end
  ```

  ```bash
  $ rake db:migrate
  ```

  ```ruby
  class Like < ActiveRecord::Base
    belongs_to :prototype, counter_cache: :likes_count
  end
  ```
- for the page of tag index & to search prototypes by tags

  **gem 'acts-as-taggable-on'**

  ```bash
  $ rake acts_as_taggable_on_engine:install:migrations
  $ rake db:migrate
  ```

  ```ruby
  class Prototype < ActiveRecord::Base
    acts_as_taggable_on :tags
  end
  ```
# ymtSpace planning sheet

## ymtSpace

**One of demo-versions of `ProtoSpace`;** an authorized app of we-b Inc.

## Major Functions

1. Share ideas of prototypes of our own products by uploading images and summaries.
2. Communicate with others over prototypes and show regards by putting thums up (LIKE).
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

- `Prototypes` & `Images` are together enabled to...
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
    `=> undefined`

- `Tags` are enabled to...
  1. Input
    `=> 'prototypes#new'`
  2. Save
    `=> 'prototypes#create'`

## Associations among Tables

- Users
  1. has_many   `Prototypes`
  2. has_many   `Likes`
  3. has_many   `Comments`

- Prototypes
  1. has_many   `Images`
  2. has_many   `Comments`
  3. has_many   `Likes`
  4. has_many   `Tags`        (through: `Tagging`)
  5. belongs_to `User`

- Images
  1. belongs_to `Prototype`

- Comments
  1. belongs_to `User`
  2. belongs_to `Prototype`

- Likes
  1. belongs_to `User`
  2. belongs_to `Prototype`

- Tags
  1. has_many   `Prototypes`  (through: `Tagging`)
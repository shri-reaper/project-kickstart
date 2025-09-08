-- Project Kickstart database setup

-- Books donated
create table if not exists books (
  id uuid primary key default uuid_generate_v4(),
  title text,
  author text,
  donated_by uuid references auth.users(id),
  inserted_at timestamp default now()
);

-- Needed books
create table if not exists needed_books (
  id uuid primary key default uuid_generate_v4(),
  title text,
  requester uuid references auth.users(id),
  inserted_at timestamp default now()
);

-- Notes storage
create table if not exists notes (
  id uuid primary key default uuid_generate_v4(),
  title text,
  file_url text,
  uploaded_by uuid references auth.users(id),
  inserted_at timestamp default now()
);

-- Impact counter
create table if not exists impact (
  id serial primary key,
  total_donations int default 0
);

insert into impact (total_donations) values (0);

-- Contact messages
create table if not exists messages (
  id uuid primary key default uuid_generate_v4(),
  name text,
  email text,
  message text,
  inserted_at timestamp default now()
);

-- Enable RLS
alter table books enable row level security;
alter table needed_books enable row level security;
alter table notes enable row level security;
alter table messages enable row level security;

-- Simple policies (any logged in user can read/write)
create policy "Books read" on books for select using (true);
create policy "Books insert" on books for insert with check (auth.uid() = donated_by);

create policy "Needed read" on needed_books for select using (true);
create policy "Needed insert" on needed_books for insert with check (auth.uid() = requester);

create policy "Notes read" on notes for select using (true);
create policy "Notes insert" on notes for insert with check (auth.uid() = uploaded_by);

create policy "Messages read" on messages for select using (true);
create policy "Messages insert" on messages for insert with check (true);

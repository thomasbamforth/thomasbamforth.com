-- ============================================================
-- The Pie League — global leaderboard table for thomasbamforth.com
-- Paste this whole file into: Supabase Dashboard → SQL Editor → Run
-- ============================================================

create table public.pie_scores (
  id         bigint generated always as identity primary key,
  name       text        not null check (char_length(name) between 1 and 20),
  score      integer     not null check (score between 1 and 99999),
  created_at timestamptz not null default now()
);

-- Row Level Security: anonymous visitors may ONLY read scores and
-- add new ones. Nobody can edit or delete rows through the public API.
alter table public.pie_scores enable row level security;

create policy "anyone can read scores"
  on public.pie_scores for select
  using (true);

create policy "anyone can add a score"
  on public.pie_scores for insert
  with check (true);

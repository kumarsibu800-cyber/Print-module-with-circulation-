-- Library Circulation: Supabase (PostgreSQL) setup
-- Paste all of this into Supabase > SQL Editor > New query, and tap Run. Safe to run again.

-- 1. The table that holds each library (one row per library code)
create table if not exists public.library_circulation (
  code       text primary key,
  doc        jsonb not null,
  updated_at timestamptz not null default now()
);

-- 2. Lock the table: the app's public key can't list or read rows directly
alter table public.library_circulation enable row level security;
revoke all on public.library_circulation from anon, authenticated;

-- 3. The only two doors the app uses: read or save ONE library, and only with its secret code
create or replace function public.lc_get(p_code text)
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select doc from public.library_circulation where code = p_code;
$$;

create or replace function public.lc_put(p_code text, p_doc jsonb)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if p_code is null or length(p_code) < 20 then
    raise exception 'library code too short';
  end if;
  if p_doc is null or jsonb_typeof(p_doc) <> 'object' then
    raise exception 'library data missing';
  end if;
  insert into public.library_circulation (code, doc, updated_at)
  values (p_code, p_doc, now())
  on conflict (code) do update set doc = excluded.doc, updated_at = now();
end;
$$;

revoke all on function public.lc_get(text) from public;
revoke all on function public.lc_put(text, jsonb) from public;
grant execute on function public.lc_get(text) to anon, authenticated;
grant execute on function public.lc_put(text, jsonb) to anon, authenticated;

-- 4. Read-only tables to look at in Supabase (Table Editor or SQL). The app doesn't use them.
create or replace view public.lc_borrowers with (security_invoker = true) as
select l.code as library,
       m->>'id' as borrower_id, m->>'name' as name, m->>'type' as type,
       m->>'group' as class_or_group, m->>'phone' as phone, m->>'joined' as joined
from public.library_circulation l,
     jsonb_array_elements(coalesce(l.doc->'members', '[]'::jsonb)) m;

create or replace view public.lc_books with (security_invoker = true) as
select l.code as library,
       (b->>0) as sl, b->>1 as accession_no, b->>2 as title, b->>3 as author,
       b->>5 as call_no, b->>6 as shelf_no
from public.library_circulation l,
     jsonb_array_elements(coalesce(l.doc->'catalogue'->'raw', '[]'::jsonb)) b;

create or replace view public.lc_loans with (security_invoker = true) as
select l.code as library,
       x->>'id' as loan_id, x->>'memberId' as borrower_id, mb->>'name' as borrower,
       bk->>1 as accession_no, bk->>2 as title,
       (x->>'issued')::date as issued, (x->>'due')::date as due,
       nullif(x->>'returned', '')::date as returned,
       x->>'condition' as condition_on_return, x->>'conditionNote' as damage_noted,
       (x->>'fine')::numeric as fine, (x->>'finePaid')::boolean as fine_paid
from public.library_circulation l
cross join lateral jsonb_array_elements(coalesce(l.doc->'loans', '[]'::jsonb)) x
left join lateral (select m from jsonb_array_elements(coalesce(l.doc->'members', '[]'::jsonb)) m
                   where m->>'id' = x->>'memberId' limit 1) mm(mb) on true
left join lateral (select b from jsonb_array_elements(coalesce(l.doc->'catalogue'->'raw', '[]'::jsonb)) b
                   where b->>0 = x->>'sl' limit 1) bb(bk) on true;

revoke all on public.lc_borrowers, public.lc_books, public.lc_loans from anon, authenticated;

-- 5. Daily attendance and hours of study (added in version 25)
create or replace view public.lc_attendance with (security_invoker = true) as
select l.code as library,
       (a->>'date')::date as date, a->>'pid' as person_id, a->>'name' as name,
       a->>'type' as type, a->>'group' as class_or_department,
       nullif(a->>'in', '')::time as time_in, nullif(a->>'out', '')::time as time_out,
       round(extract(epoch from (nullif(a->>'out', '')::time - nullif(a->>'in', '')::time)) / 3600.0, 2) as hours
from public.library_circulation l,
     jsonb_array_elements(coalesce(l.doc->'attendance', '[]'::jsonb)) a;

revoke all on public.lc_attendance from anon, authenticated;

-- GASPAROTTO VIAJES - FUNCIONES SEGURAS DE ADMINISTRACIÓN
-- Pegá todo este bloque en Supabase > SQL Editor > New query > Run

create or replace function public.admin_list_vouchers(p_pin text)
returns setof public."VOUCHERS"
language plpgsql
security definer
set search_path = public
as $$
begin
  if p_pin <> '1530' then
    raise exception 'PIN incorrecto';
  end if;

  return query
  select *
  from public."VOUCHERS"
  order by created_at desc;
end;
$$;

create or replace function public.admin_toggle_importante(
  p_pin text,
  p_id bigint,
  p_importante boolean
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if p_pin <> '1530' then
    raise exception 'PIN incorrecto';
  end if;

  update public."VOUCHERS"
  set importante = p_importante
  where id = p_id;
end;
$$;

create or replace function public.admin_delete_voucher(
  p_pin text,
  p_id bigint
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if p_pin <> '1530' then
    raise exception 'PIN incorrecto';
  end if;

  delete from public."VOUCHERS"
  where id = p_id;
end;
$$;

revoke all on function public.admin_list_vouchers(text) from public;
revoke all on function public.admin_toggle_importante(text,bigint,boolean) from public;
revoke all on function public.admin_delete_voucher(text,bigint) from public;

grant execute on function public.admin_list_vouchers(text) to anon;
grant execute on function public.admin_toggle_importante(text,bigint,boolean) to anon;
grant execute on function public.admin_delete_voucher(text,bigint) to anon;

do $$
declare
   n_of_recs bigint := 10000;
	 random_user_name varchar(30);
	 random_user_id integer;
	 random_amount DECIMAL(10, 2);
	 
   random_varchar_length smallint;
   random_varchar varchar(100);
   random_timestamp timestamp;
   random_int bigint;   
	 random_unit_int bigint; 
   query text; 
begin

	 DROP TABLE IF EXISTS transactions;

	CREATE TABLE transactions (
			transaction_id integer PRIMARY KEY,
			transaction_date DATE,
			user_id INTEGER,
			user_name varchar(30),
			 score INTEGER,
			amount DECIMAL(10, 2),
			transaction_date_ori DATE,
			 user_id_ori INTEGER,
			user_name_ori varchar(30),
			score_ori INTEGER
	);

for idx in 1..n_of_recs loop
				random_int := idx;
				random_timestamp := timestamp '2000-01-01 00:00:00' + random() * (timestamp '2024-01-01 00:00:00' - timestamp '2000-01-01 00:00:00');
				random_user_id := floor(random()*(9))+1;
				random_amount := random()*(1000-1+1)+1;
				random_unit_int :=  floor(random()*(99))+1;
				select first_name || ' ' || last_name from employees where employee_id = random_user_id into random_user_name;
         query := format('insert into transactions values (%s, ''%s'', %s, ''%s'', %s, %s);', random_int, random_timestamp, random_user_id, random_user_name, random_unit_int, random_amount);
         execute query;
      end loop;
      select count(1) from transactions into n_of_recs;
      raise notice 'n_of_recs: %', n_of_recs;
end$$;

update transactions set transaction_date_ori=transaction_date, score_ori=score, user_id_ori=user_id, user_name_ori=user_name;
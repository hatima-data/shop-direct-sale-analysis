create table shop_sales (
			order_id int,
			order_date varchar(50),
			customer_name varchar(100),
			city varchar(100),
			country varchar(100),
			state varchar (100),
			region varchar,
			segment varchar,
			category varchar,
			ship_mode varchar,
			sub_category varchar,
			product_name varchar,
			quantity int,
			cost numeric,
			profit numeric,
			sales numeric
);
select *from shop_sales;
select current_database();
select count(*)from shop_sales;

select
	sum(sales) as umumiy_savdo,
	sum(profit) as umumiy_foyda,
	min(sales) as min_savdo,
	avg(sales) as ortacha_savdo,
	max(sales) as max_savdo
	from shop_sales;

select 
	category,
	sum(sales)as kategoriya_savdosi,
	sum(profit) as kategoriya_foydasi
	from shop_sales
	group by category
	order by kategoriya_savdosi desc;

select 
	customer_name,
	sum(sales) as jami_xarid_summasi
	from shop_sales
	group by customer_name
	order by jami_xarid_summasi desc limit 10;

select
	country,
	state,
	city,
	sum(sales) as shaxarlar_savdosi
	from shop_sales 
	group by country,state,city
	order by shaxarlar_savdosi;

select 
	order_id,
	sales,
	case
		when sales>500 then 'Katta_buyurtma'
		when sales between 100 and 500 then 'Ortacha buyurtma'
		else 'Kichik'
		end as buyurtmalar_turi
		from shop_sales;
select 
	customer_name,
	city,
	category,
	sales
	from shop_sales
	where sales>1000;

select 
	category,
	sum(sales) as jami
	from shop_sales
	group by category
	order by jami desc limit 3;

select
	region,
	sum(sales) as sum_region 
	from shop_sales
	group by region
	order by sum_region desc limit 3;

select
	customer_name,
	count(quantity) as buyurtma_soni
	from shop_sales
	group by customer_name
	order by buyurtma_soni desc limit 5

select 
	count(case when sales>1000 then 1 end)as katta_savdo_soni,
	count(case when sales<=1000 then 1 end) as kichik_savdo_soni
	from shop_sales;
	
select
	category,
	count(case when sales>1000 then 1 end)as kat_katta,
	count(case when sales<=1000 then 1 end) as kat_kichik
	from shop_sales
	group by category;

select 
	ship_mode,
	sum(sales) as yet_berish_summasi
	from shop_sales
	group by ship_mode
	order by yet_berish_summasi desc;

select 
	sub_category,
	sum(sales) as sub_cat_sum
	from shop_sales
	group by sub_category
	having sum(sales)>150000;
	
create view top_sub_cat as(
		select
		sub_category,
		sum(sales) as sub_cat_sum
		from shop_sales
		group by sub_category
		having sum(sales)>150000
)	

select* from top_sub_cat;

select 
	order_id,
	sales
	from shop_sales
	where sales> (select avg(sales) from shop_sales);

select category,sales, 
	row_number()
	over(partition by category  order by sales desc )
	from shop_sales;

select 
	category,
	sales,
	rank()
	over(partition by category order by sales desc)
	from shop_sales;
	

select 
	extract(year from to_date(order_date,'MM/DD/YYYY')) as savdo_yili,
	sum(sales) as jami_savdo
	from shop_sales
	group by extract(year from to_date(order_date,'MM/DD/YYYY'))
	order by savdo_yili;
	
select 
	order_id,
	to_date(order_date,'MM/DD/YYYY') as persed_date,
	sales,
	Sum(sales) over(order by to_date(order_date,'MM/DD/YYYY'),order_id) as cumulative_sales
from shop_sales;

with ranked_sales as (
				select
					category,
					sub_category,
					sales,
					row_number() over(partition by category order by sales desc) as rn
				from shop_sales
)

select 
	category,
	sub_category,
	sales
	from ranked_sales
	where rn<=3;

select
	to_date(order_date, 'MM/DD/YYYY') as savdo_kuni,
	count(order_id)as buyurtmalar_soni,
	sum(sales) as kunlik_jami_savdo
from shop_sales
group by to_date(order_date,'MM/DD/YYYY')
order by savdo_kuni;


		








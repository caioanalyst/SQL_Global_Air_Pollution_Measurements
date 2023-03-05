
# 1- Which pollutants were considered in the research?

select distinct pollutant from cap09.tb_global_qualidade_ar;



# 2- What was the average pollution over time caused by the ground-level pollutant ozone (o3)?

select
	country as pais,
	cast(timestamp as date) as data_coleta,
	round(avg(value) over (partition by country order by cast(timestamp as date)), 2) as media_valor_poluicao
from cap09.tb_global_qualidade_ar
where pollutant = 'o3'
order by country, data_coleta;



# 3- What was the average pollution caused by the ground-level pollutant ozone (o3) per country measured in µg/m³ (micrograms per cubic meter)?

select
	country as pais,
	round(avg(value), 2) as media_poluicao
from cap09.tb_global_qualidade_ar
where pollutant = 'o3'
and unit = 'µg/m³'
group by country
order by media_poluicao asc;



# 4- Considering the previous result, which country had a higher overall o3 pollution index, Italy (IT) or Spain (ES)? Why?

select country as pais,
	round(avg(value), 2) as media_poluicao,
	stddev(value) as desvio_padrao,
	max(value) as valor_maximo,
	min(value) as valor_minimo
from cap09.tb_global_qualidade_ar
where pollutant = 'o3'
and unit = 'µg/m³'
and country in ('IT', 'ES')
group by country
order by media_poluicao asc;



select country as pais,
	round(avg(value), 2) as media_poluicao,
	stddev(value) as desvio_padrao,
	max(value) as valor_maximo,
	min(value) as valor_minimo,
	(stddev(value) / round(avg(value), 2)) * 100 as cv
from cap09.tb_global_qualidade_ar
where pollutant = 'o3'
and unit = 'µg/m³'
and country in ('IT', 'ES')
group by country
order by media_poluicao asc;



# 5- Which locations and countries had an average pollution in 2020 greater than 100 µg/m³ for the pollutant fine particulate matter (pm25)?

select
	coalesce(location, 'Total') as localidade,
	coalesce(country, 'Total') as pais,
	round(avg(value), 2) as media_poluicao
from cap09.tb_global_qualidade_ar
where pollutant = 'pm25'
and year(timestamp) = 2020
group by location, country with rollup
having media_poluicao > 100
order by location, country;
# Cria a tabela
CREATE TABLE cap09.TB_GLOBAL_QUALIDADE_AR (
  `location` text,
  `city` text,
  `country` text,
  `pollutant` text,
  `value` text,
  `timestamp` text,
  `unit` text,
  `source_name` text,
  `latitude` text,
  `longitude` text,
  `averaged_over_in_hours` text);

# Carga de dados via linha de comando

# Conecte no MySQL via linha de comando
/usr/local/mysql/bin/mysql --local-infile=1 -u root -p

# Execute:
SET GLOBAL local_infile = true;

# Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap09/dados/dataset.csv' INTO TABLE `cap09`.`TB_GLOBAL_QUALIDADE_AR` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 LINES;

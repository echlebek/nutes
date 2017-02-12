# Cleans up USDA text files for import.
C=./data_cleanup

# Adjust this as appropriate - you will likely need username, password, db, etc.
PSQL=psql

all: db

data_cleanup:
	go build -o data_cleanup data_cleanup.go

sr26.zip:
	curl -O https://www.ars.usda.gov/ARSUserFiles/80400525/Data/SR/SR28/dnload/sr28asc.zip

sr26: sr26.zip
	mkdir sr26
	tar -C sr26 -xvf sr28asc.zip

data_src.csv: sr26 data_cleanup
	$(C) sr26/DATA_SRC.txt data_src.csv

datsrcln.csv: sr26 data_cleanup
	$(C) sr26/DATSRCLN.txt datsrcln.csv

deriv_cd.csv: sr26 data_cleanup
	$(C) sr26/DERIV_CD.txt deriv_cd.csv

fd_group.csv: sr26 data_cleanup
	$(C) sr26/FD_GROUP.txt fd_group.csv

food_des.csv: sr26 data_cleanup
	$(C) sr26/FOOD_DES.txt food_des.csv

footnote.csv: sr26 data_cleanup
	$(C) sr26/FOOTNOTE.txt footnote.csv

langdesc.csv: sr26 data_cleanup
	$(C) sr26/LANGDESC.txt langdesc.csv

langual.csv: sr26 data_cleanup
	$(C) sr26/LANGUAL.txt langual.csv

nutr_def.csv: sr26 data_cleanup
	$(C) sr26/NUTR_DEF.txt nutr_def.csv

nut_data.csv: sr26 data_cleanup
	$(C) sr26/NUT_DATA.txt nut_data.csv

src_cd.csv: sr26 data_cleanup
	$(C) sr26/SRC_CD.txt src_cd.csv

weight.csv: sr26 data_cleanup
	$(C) sr26/WEIGHT.txt weight.csv

db: data_src.csv langdesc.csv datsrcln.csv langual.csv deriv_cd.csv nut_data.csv fd_group.csv nutr_def.csv food_des.csv src_cd.csv footnote.csv weight.csv schema.sql import.sql
	cat schema.sql | $(PSQL)
	cat import.sql | $(PSQL)

clean:
	rm -rf sr26
	rm -f sr26.zip
	rm -f data_src.csv datsrcln.csv deriv_cd.csv fd_group.csv food_des.csv footnote.csv langdesc.csv langual.csv nutr_def.csv nut_data.csv src_cd.csv weight.csv
	rm -f data_cleanup

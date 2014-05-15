BEGIN;

    SET CONSTRAINTS ALL DEFERRED;

    COPY food_groups FROM '/Users/eric/code/nutr/sr26/fd_group.csv' DELIMITER '	' CSV;
    COPY foods FROM '/Users/eric/code/nutr/sr26/food_des.csv' DELIMITER '	' CSV;
    COPY langua_l_desc FROM '/Users/eric/code/nutr/sr26/langdesc.csv' DELIMITER '	' CSV;
    COPY langua_l_factors FROM '/Users/eric/code/nutr/sr26/langual.csv' DELIMITER '	' CSV;
    COPY nutrients FROM '/Users/eric/code/nutr/sr26/nutr_def.csv' DELIMITER '	' CSV;
    COPY source_codes FROM '/Users/eric/code/nutr/sr26/src_cd.csv' DELIMITER '	' CSV;
    COPY data_derivation_codes FROM '/Users/eric/code/nutr/sr26/deriv_cd.csv' DELIMITER '	' CSV;
    COPY nutrient_data FROM '/Users/eric/code/nutr/sr26/nut_data.csv' DELIMITER '	' CSV;
    COPY weights FROM '/Users/eric/code/nutr/sr26/weight.csv' DELIMITER '	' CSV;
    COPY footnotes FROM '/Users/eric/code/nutr/sr26/footnote.csv' DELIMITER '	' CSV;
    COPY sources_of_data FROM '/Users/eric/code/nutr/sr26/data_src.csv' DELIMITER '	' CSV;
    COPY sources_of_data_assoc FROM '/Users/eric/code/nutr/sr26/datsrcln.csv' DELIMITER '	' CSV;

COMMIT;

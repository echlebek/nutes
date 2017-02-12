BEGIN;

    SET CONSTRAINTS ALL DEFERRED;

    COPY food_groups FROM '/Users/brianglusman/open_pantry/nutes/fd_group.csv' DELIMITER '	' CSV;
    COPY foods FROM '/Users/brianglusman/open_pantry/nutes/food_des.csv' DELIMITER '	' CSV;
    COPY langua_l_desc FROM '/Users/brianglusman/open_pantry/nutes/langdesc.csv' DELIMITER '	' CSV;
    COPY langua_l_factors FROM '/Users/brianglusman/open_pantry/nutes/langual.csv' DELIMITER '	' CSV;
    COPY nutrients FROM '/Users/brianglusman/open_pantry/nutes/nutr_def.csv' DELIMITER '	' CSV;
    COPY source_codes FROM '/Users/brianglusman/open_pantry/nutes/src_cd.csv' DELIMITER '	' CSV;
    COPY data_derivation_codes FROM '/Users/brianglusman/open_pantry/nutes/deriv_cd.csv' DELIMITER '	' CSV;
    COPY nutrient_data FROM '/Users/brianglusman/open_pantry/nutes/nut_data.csv' DELIMITER '	' CSV;
    COPY weights FROM '/Users/brianglusman/open_pantry/nutes/weight.csv' DELIMITER '	' CSV;
    COPY footnotes FROM '/Users/brianglusman/open_pantry/nutes/footnote.csv' DELIMITER '	' CSV;
    COPY sources_of_data FROM '/Users/brianglusman/open_pantry/nutes/data_src.csv' DELIMITER '	' CSV;
    COPY sources_of_data_assoc FROM '/Users/brianglusman/open_pantry/nutes/datsrcln.csv' DELIMITER '	' CSV;

COMMIT;

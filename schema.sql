BEGIN;

CREATE  TABLE food_groups (
    -- 4-digit code identifying a food group. Only the first 2 digits are
    -- currently assigned. In the future, the last 2 digits may be used. Codes
    -- may not be consecutive.
    foodgroup_code text PRIMARY KEY,

    -- Name of food group.
    foodgroup_desc text NOT NULL
);

CREATE  TABLE foods (
    -- 5-digit Nutrient Databank number that uniquely identifies a food item.
    -- If this field is defined as numeric, the leading zero will be lost.
    ndb_no text PRIMARY KEY,

    -- 4-digit code indicating food group to which a food item belongs.
    foodgroup_code text NOT NULL REFERENCES food_groups(foodgroup_code),

    -- 200-character description of food item.
    longdesc text NOT NULL,

    -- 60-character abbreviated description of food item. Generated from the
    -- 200-character description using abbreviations in Appendix A. If short
    -- description is longer than 60 characters, additional abbreviations are
    -- made.
    shortdesc text NOT NULL,

    -- Other names commonly used to describe a food, including local or
    -- regional names for various foods, for example, “soda” or “pop” for
    -- “carbonated beverages.”
    common_name text,

    -- Indicates the company that manufactured the product, when appropriate.
    manufacturer_name text,

    -- Indicates if the food item is used in the USDA Food and Nutrient
    -- Database for Dietary Studies (FNDDS) and thus has a complete nutrient
    -- profile for the 65 FNDDS nutrients.
    survey text,

    -- Description of inedible parts of a food item (refuse), such as seeds
    -- or bone.
    refuse_description text,

    -- Percentage of refuse.
    refuse numeric,

    -- Scientific name of the food item. Given for the least processed form of
    -- the food (usually raw), if applicable.
    scientific_name text,

    -- Factor for converting nitrogen to protein (see p. 12).
    n_factor numeric,

    -- Factor for calculating calories from protein (see p. 13).
    pro_factor numeric,

    -- Factor for calculating calories from fat (see p. 13).
    fat_factor numeric,

    -- Factor for calculating calories from carbohydrate (see p. 13).
    cho_factor numeric
);

CREATE  TABLE langua_l_desc (
    -- The LanguaL factor from the Thesaurus. Only those codes used to factor
    -- the foods contained in the LanguaL Factor file are included in this file
    factor_code text PRIMARY KEY,

    -- The description of the LanguaL Factor Code from the thesaurus
    description text NOT NULL
);

CREATE  TABLE langua_l_factors (
    -- 5-digit Nutrient Databank number that uniquely identifies a food item.
    -- If this field is defined as numeric, the leading zero will be lost.
    ndb_no text REFERENCES foods (ndb_no),

    -- The LanguaL factor from the Thesaurus
    factor_code text REFERENCES langua_l_desc (factor_code),

    PRIMARY KEY(ndb_no, factor_code)
);

CREATE  TABLE nutrients (
    -- Unique 3-digit identifier code for a nutrient.
    nutr_no text PRIMARY KEY,

    -- Units of measure (mg, g, μg, and so on).
    units text NOT NULL,

    -- International Network of Food Data Systems (INFOODS) Tagnames. A unique
    -- abbreviation for a nutrient/food component developed by INFOODS to aid
    -- in the interchange of data.
    tagname text,

    -- Name of nutrient/food component.
    nutr_desc text NOT NULL,

    -- Number of decimal places to which a nutrient value is rounded.
    num_dec integer NOT NULL,

    -- Used to sort nutrient records in the same order as various reports
    -- produced from SR.
    sr_order numeric NOT NULL
);

CREATE  TABLE source_codes (
    -- 2-digit code.
    source_code text PRIMARY KEY,

    -- Description of source code that identifies the type of nutrient data.
    description text NOT NULL
);

CREATE  TABLE data_derivation_codes (
    -- Derivation Code.
    derivation_code text PRIMARY KEY,

    -- Description of derivation code giving specific information on how the
    -- value was determined.
    description text NOT NULL
);

CREATE  TABLE weights (
    -- 5-digit Nutrient Databank number.
    ndb_no text REFERENCES foods (ndb_no),

    -- Sequence number.
    seq text,

    -- Unit modifier (for example, 1 in “1 cup”).
    amount numeric NOT NULL,

    -- Description (for example, cup, diced, and 1-inch pieces).
    msre_desc text NOT NULL,

    -- Gram weight.
    gram_weight numeric NOT NULL,

    -- Number of data points.
    num_data_points numeric,

    -- Standard deviation.
    std_dev numeric,

    PRIMARY KEY(ndb_no, seq)
);

CREATE  TABLE footnotes (
    -- 5-digit Nutrient Databank number.
    ndb_no text REFERENCES foods (ndb_no),

    -- Sequence number. If a given footnote applies to more than one nutrient
    -- number, the same footnote number is used. As a result, this file cannot
    -- be indexed.
    footnote_no TEXT,

    -- Type of footnote:
    --     D = footnote adding information to the food description;
    --     M = footnote adding information to measure description;
    --     N = footnote providing additional information on a nutrient value.
    --         If the Footnt_typ = N, the Nutr_No will also be filled in.
    footnote_type text,

    -- Unique 3-digit identifier code for a nutrient to which footnote applies.
    nutr_no text REFERENCES nutrients (nutr_no),

    -- Footnote text.
    footnote_text text NOT NULL

);

CREATE  TABLE sources_of_data (
    -- Unique number identifying the reference/source.
    datasource_id text PRIMARY KEY,

    -- List of authors for a journal article or name of sponsoring organization
    -- for other documents.
    authors text,

    -- Title of article or name of document, such as a report from a
    -- company or trade association.
    title text NOT NULL,

    -- Year article or document was published.
    year text,

    -- Name of the journal in which the article was published.
    journal text,

    -- Volume number for journal articles, books, or reports; city where
    -- sponsoring organization is located.
    vol_city text,

    -- Issue number for journal article; State where the sponsoring
    -- organization is located.
    issue_state text,

    -- Starting page number of article/document.
    start_page text,

    -- Ending page number of article/document.
    end_page text
);

CREATE  TABLE sources_of_data_assoc (
    -- 5-digit Nutrient Databank number.
    ndb_no text REFERENCES foods (ndb_no),

    -- Unique 3-digit identifier code for a nutrient.
    nutr_no text REFERENCES nutrients (nutr_no),

    -- Unique ID identifying the reference/source.
    datasource_id text REFERENCES sources_of_data (datasource_id),

    PRIMARY KEY(ndb_no, nutr_no, datasource_id)
);

CREATE  TABLE nutrient_data (
    -- 5-digit Nutrient Databank number.
    ndb_no text REFERENCES foods (ndb_no),

    -- Unique 3-digit identifier code for a nutrient.
    nutr_no text REFERENCES nutrients (nutr_no),

    -- Amount in 100 grams, edible portion
    nutrition_value numeric NOT NULL,

    -- Number of data points (previously called Sample_Ct) is the number of
    -- analyses used to calculate the nutrient value. If the number of data
    -- points is 0, the value was calculated or imputed.
    num_data_points numeric NOT NULL,

    -- Standard error of the mean. Null if cannot be calculated. The standard
    -- error is also not given if the number of data points is less than three.
    std_error numeric,

    -- Code indicating type of data.
    source_code text NOT NULL REFERENCES source_codes (source_code),

    -- Data Derivation Code giving specific information on how the value is
    -- determined
    derivation_code text REFERENCES data_derivation_codes (derivation_code),

    -- NDB number of the item used to calculate a missing value. Populated only
    -- for items added or updated starting with SR14.
    ref_ndb_no text REFERENCES foods (ndb_no),

    -- Indicates a vitamin or mineral added for fortification or enrichment.
    -- This field is populated for ready-to-eat breakfast cereals and many
    -- brand-name hot cereals in food group 8.
    add_nutr_mark text,

    -- Number of studies.
    num_studies numeric,

    -- Minimum value.
    min numeric,

    -- Maximum value.
    max numeric,

    -- Degrees of freedom.
    degrees_freedom numeric,

    -- Lower 95% error bound.
    low_error_bound numeric,

    -- Upper 95% error bound.
    upper_error_bound numeric,

    -- Statistical comments. See definitions below.
    stat_comments text,

    -- Indicates when a value was either added to the database or last modified.
    add_mod_date text,

    -- Confidence Code indicating data quality, based on evaluation of sample
    -- plan, sample handling, analytical method, analytical quality control,
    -- and number of samples analyzed. Not included in this release, but is
    -- planned for future releases.
    confidence_code text,

    PRIMARY KEY(ndb_no, nutr_no)
);

COMMIT;

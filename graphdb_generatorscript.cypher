// CONSTRAINT creation

CREATE CONSTRAINT `imp_uniq_media_outlet_id_mo` IF NOT EXISTS
FOR (n: `media_outlet`)
REQUIRE (n.`id_mo`) IS UNIQUE;

:param {
  idsToSkip: []
};

// NODE load
LOAD CSV WITH HEADERS FROM 'file:///1/mo_constant.csv' AS row FIELDTERMINATOR ';'
WITH row

WHERE NOT row.`id_mo` IN $idsToSkip AND NOT toInteger(trim(row.`id_mo`)) IS NULL
CALL {
  WITH row
  MERGE (n: `media_outlet` { `id_mo`: toInteger(trim(row.`id_mo`)) })
  SET n.`id_mo` = toInteger(trim(row.`id_mo`))
  SET n.`mo_title` = row.`mo_title`
  SET n.`id_sector` = toInteger(trim(row.`id_sector`))
  SET n.`type_mo` = toInteger(trim(row.`type_mo`))
  SET n.`mandate` = toInteger(trim(row.`mandate`))
  SET n.`location` = row.`location`
  SET n.`primary_distr_area` = toInteger(trim(row.`primary_distr_area`))
  SET n.`language` = row.`language`
  SET n.`start_date` = datetime(row.`start_date`)
  SET n.`end_date` = datetime(row.`end_date`)
  SET n.`editorial_line_s` = row.`editorial_line_s`
  SET n.`editorial_line_e` = row.`editorial_line_e`
  SET n.`comments` = row.`comments`
} ;

CREATE (:VersionLabel {version:'v5', timestamp: datetime()})


// Relationships of Media Outlets



LOAD CSV WITH HEADERS FROM 'file:///1/rel_succession_11.csv' AS row1 FIELDTERMINATOR ';'
WITH row1
CALL {
  WITH row1
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row1.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row1.`succession`)) })
  MERGE (source)-[r: `succession`]->(target)
};

LOAD CSV WITH HEADERS FROM 'file:///1/rel_amalgamation_12.csv' AS row2 FIELDTERMINATOR ';'
WITH row2
CALL {
  WITH row2
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row2.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row2.`amalgamation`)) })
  MERGE (source)-[r: `amalgamation`]->(target)
}

LOAD CSV WITH HEADERS FROM 'file:///1/rel_new_distribution_area_13.csv' AS row3 FIELDTERMINATOR ';'
WITH row3
CALL {
  WITH row3
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row3.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row3.`new_distribution_area`)) })
  MERGE (source)-[r: `new_distribution_area`]->(target)
};

LOAD CSV WITH HEADERS FROM 'file:///1/rel_new_sector_14.csv' AS row4 FIELDTERMINATOR ';'
WITH row4
CALL {
  WITH row4
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row4.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row4.`new_sector`)) })
  MERGE (source)-[r: `new_sector`]->(target)
};


LOAD CSV WITH HEADERS FROM 'file:///1/rel_interruption_19.csv' AS row5 FIELDTERMINATOR ';'
WITH row5
CALL {
  WITH row5
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row5.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row5.`interruption`)) })
  MERGE (source)-[r: `interruption`]->(target)
};


LOAD CSV WITH HEADERS FROM 'file:///1/rel_split_off_21.csv' AS row6 FIELDTERMINATOR ';'
WITH row6
CALL {
  WITH row6
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row6.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row6.`split_off`)) })
  MERGE (source)-[r: `split_off`]->(target)
};

LOAD CSV WITH HEADERS FROM 'file:///1/rel_merger_23.csv' AS row7 FIELDTERMINATOR ';'
WITH row7
CALL {
  WITH row7
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row7.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row7.`merger`)) })
  MERGE (source)-[r: `merger`]->(target)
};

LOAD CSV WITH HEADERS FROM 'file:///1/rel_offshoot_22.csv' AS row8 FIELDTERMINATOR ';'
WITH row8
CALL {
  WITH row8
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row8.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row8.`Offshoot`)) })
  MERGE (source)-[r: `offshoot`]->(target)
};

LOAD CSV WITH HEADERS FROM 'file:///1/rel_main_media_outlet_31.csv' AS row9 FIELDTERMINATOR ';'
WITH row9
CALL {
  WITH row9
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row9.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row9.`main_media_outlet`)) })
  MERGE (source)-[r: `main_media_outlet`]->(target)
  SET r.start_rel = datetime(trim(row9.`start_rel`))
  SET r.end_rel = datetime(trim(row9.`end_rel`))
};

LOAD CSV WITH HEADERS FROM 'file:///1/rel_editorial_alliance_32.csv' AS row10 FIELDTERMINATOR ';'
WITH row10
CALL {
  WITH row10
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row10.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row10.`editorial_alliance`)) })
  MERGE (source)-[r: `editorial_alliance`]->(target)
  SET r.start_rel = datetime(trim(row10.`start_rel`))
  SET r.end_rel = datetime(trim(row10.`end_rel`))
};

LOAD CSV WITH HEADERS FROM 'file:///1/rel_umbrella_33.csv' AS row11 FIELDTERMINATOR ';'
WITH row11
CALL {
  WITH row11
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row11.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row11.`umbrella`)) })
  MERGE (source)-[r: `umbrella`]->(target)
  SET r.start_rel = datetime(trim(row11.`start_rel`))
  SET r.end_rel = datetime(trim(row11.`end_rel`))
};

LOAD CSV WITH HEADERS FROM 'file:///1/rel_collaboration_34.csv' AS row12 FIELDTERMINATOR ';'
WITH row12
CALL {
  WITH row12
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row12.`id_mo`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row12.`collaboration`)) })
  MERGE (source)-[r: `collaboration`]->(target)
  SET r.start_rel = datetime(trim(row12.`start_rel`))
  SET r.end_rel = datetime(trim(row12.`end_rel`))
};




// jaehrliche Daten



CREATE CONSTRAINT `imp_uniq_media_undertaking_id_mu` IF NOT EXISTS
FOR (n: `media_undertaking`)
REQUIRE (n.`id_undertaking`) IS UNIQUE;
CREATE CONSTRAINT `imp_uniq_media_outlet_id_mo` IF NOT EXISTS
FOR (n: `media_outlet`)
REQUIRE (n.`id_mo`) IS UNIQUE;
CREATE CONSTRAINT `imp_uniq_mo_year_mo_year` IF NOT EXISTS
FOR (n: `mo_year`)
REQUIRE (n.`mo_year`) IS UNIQUE;

:param {
  idsToSkip: []
};

// NODE load

LOAD CSV WITH HEADERS FROM 'file:///1/mo_year.csv'
AS row13 FIELDTERMINATOR ';'
WITH row13
WHERE NOT row13.`id_mu` IN $idsToSkip AND NOT toInteger(trim(row13.`id_mu`)) IS NULL
CALL {
  WITH row13
  MERGE (n: `media_undertaking` { `id_mu`: toInteger(trim(row13.`id_mu`)) })
  SET n.`id_mu` = toInteger(trim(row13.`id_mu`))
} ;

LOAD CSV WITH HEADERS FROM 'file:///1/mo_year.csv'
AS row14 FIELDTERMINATOR ';'
WITH row14
WHERE NOT row14.`id_mo` IN $idsToSkip AND NOT toInteger(trim(row14.`id_mo`)) IS NULL
CALL {
  WITH row14
  MERGE (n: `media_outlet` { `id_mo`: toInteger(trim(row14.`id_mo`)) })
  SET n.`id_mo` = toInteger(trim(row14.`id_mo`))
} ;

LOAD CSV WITH HEADERS FROM 'file:///1/mo_year.csv'
AS row15 FIELDTERMINATOR ';'
WITH row15
WHERE NOT row15.`mo_year` IN $idsToSkip AND NOT toInteger(trim(row15.`mo_year`)) IS NULL
CALL {
 WITH row15
  MERGE (n: `mo_year` { `mo_year`: toInteger(trim(row15.`mo_year`)) })
  SET n.`mo_year` = toInteger(trim(row15.`mo_year`))
  SET n.`id_mo` = toInteger(trim(row15.`id_mo`))
  SET n.`year` = datetime(row15.`year`)
  SET n.`circulation` = toInteger(trim(row15.`circulation`))
  SET n.`circulation_source` = toInteger(trim(row15.`circulation_source`))
  SET n.`uniqueusers` = toInteger(trim(row15.`uniqueusers`))
  SET n.`uniqueusers_source` = toInteger(trim(row15.`uniqueusers_source`))
  SET n.`reach_nat` = toFloat(trim(row15.`reach_nat`))
  SET n.`reach_nat_source` = toInteger(trim(row15.`reach_nat_source`))
  SET n.`reach_reg` = toInteger(trim(row15.`reach_reg`))
  SET n.`reach_reg_source` = toInteger(trim(row15.`reach_reg_source`))
  SET n.`market_share` = toFloat(trim(row15.`market_share`))
  SET n.`market_share_source` = toInteger(trim(row15.`market_share_source`))
  SET n.`comments` = row15.`comments`
};



LOAD CSV WITH HEADERS FROM 'file:///1/mo_year.csv'
AS row16 FIELDTERMINATOR ';'
WITH row16
CALL {
  WITH row16
  MATCH (source: `media_outlet` { `id_mo`: toInteger(trim(row16.`id_mo`)) })
  MATCH (target: `mo_year` { `mo_year`: toInteger(trim(row16.`mo_year`)) })
  MERGE (source)-[r: `per`]->(target)
};

LOAD CSV WITH HEADERS FROM 'file:///1/mo_year.csv'
AS row17 FIELDTERMINATOR ';'
WITH row17
CALL {
  WITH row17
  MATCH (source: `mo_year` { `mo_year`: toInteger(trim(row17.`mo_year`)) })
  MATCH (target: `media_undertaking` { `id_mu`: toInteger(trim(row17.`id_mu`)) })
  MERGE (source)-[r: `ownedinyear`]->(target)
};

LOAD CSV WITH HEADERS FROM 'file:///1/mo_year.csv'
AS row18 FIELDTERMINATOR ';'
WITH row18
CALL {
  WITH row18
  MATCH (source: `media_undertaking` { `id_mu`: toInteger(trim(row18.`id_mu`)) })
  MATCH (target: `media_outlet` { `id_mo`: toInteger(trim(row18.`id_mo`)) })
  MERGE (source)-[r: `owns`]->(target)
};


//  Unternehmensdaten

CREATE CONSTRAINT `imp_uniq_media_company_id_company` IF NOT EXISTS
FOR (n: `media_undertaking`)
REQUIRE (n.`id_mu`) IS UNIQUE;

:param {
  idsToSkip: []
};


LOAD CSV WITH HEADERS FROM   'file:///1/mu_constant.csv'
AS row19 FIELDTERMINATOR ';'
WITH row19
WHERE NOT row19.`id_mu` IN $idsToSkip AND NOT toInteger(trim(row19.`id_mu`)) IS NULL
CALL {
  WITH row19
  MERGE (n: `media_undertaking` { `id_mu`: toInteger(trim(row19.`id_mu`)) })
  SET n.`id_mu` = toInteger(trim(row19.`id_mu`))
  SET n.`mu_title` = row19.`mu_title`
};

// 99 company delete
MATCH (n:media_undertaking{id_mu:99}) DETACH DELETE (n) ;

// Properties fuer Medienunternehmen setzen

MATCH (p:media_undertaking)-[r:owns]-(n:media_outlet)-[r2:per]->(m:mo_year)
WITH r, COLLECT(DISTINCT CASE WHEN (m)-[:ownedinyear]->(p) THEN m.year ELSE null END) AS owningYearsList
UNWIND owningYearsList AS owningYear
WITH r, owningYear
ORDER BY owningYear ASC
WITH r, COLLECT(owningYear) AS sortedOwningYearsList
WITH r, head(sortedOwningYearsList) AS startYear
SET r.start_rel = datetime(startYear)
;
MATCH (p:media_undertaking)-[r:owns]-(n:media_outlet)-[r2:per]->(m:mo_year)
WITH r, COLLECT(DISTINCT CASE WHEN (m)-[:ownedinyear]->(p) THEN m.year ELSE null END) AS owningYearsList
UNWIND owningYearsList AS owningYear
WITH r, owningYear
ORDER BY owningYear ASC
WITH r, COLLECT(owningYear) AS sortedOwningYearsList
WITH r, last(sortedOwningYearsList) AS endYear
SET r.end_rel = datetime(endYear)
;
// Properties der Relationships

MATCH (n:media_outlet)-[r1:succession]-> (m:media_outlet)
SET r1.event_rel = m.start_date
;

MATCH (n:media_outlet)-[r2:amalgamation]-> (m:media_outlet)
SET r2.event_rel = m.start_date
;

MATCH (n:media_outlet)-[r3:new_distribution_area]-> (m:media_outlet)
SET r3.event_rel = m.start_date
;

MATCH (n:media_outlet)-[r4:new_sector]-> (m:media_outlet)
SET r4.event_rel = m.start_date
;

MATCH (n:media_outlet)-[r5:interruption]-> (m:media_outlet)
SET r5.start_rel = n.end_date + duration({days: 1})
SET r5.end_rel = m.start_date - duration({days: 1})
;

MATCH (n:media_outlet)-[r6:offshoot]-> (m:media_outlet)
SET r6.event_rel = m.start_date
;
MATCH (n:media_outlet)-[r7:split_off]-> (m:media_outlet)
SET r7.event_rel= m.start_date
;
MATCH (n:media_outlet)-[r8:merger]-> (m:media_outlet)
SET r8.event_rel = n.end_date

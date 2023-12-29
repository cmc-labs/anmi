dnl generate media analysis graph db 

define(`concat',`$1$2')
define(`POSTFIX',`_l1')
define(`MEDIENANGEBOTE',`medienangebote')
define(`MEDIENANGEBOTE_VERSION',concat(MEDIENANGEBOTE,POSTFIX))

use neo4j

dnl medienangebote nodes:

load csv with headers from 'file:///MEDIENANGEBOTE.csv' as row
with row
create (:MEDIENANGEBOTE_VERSION {
 id_ma: toInteger(row.id_ma), 
 ma_titel: row.ma_titel,
 id_gattung: toInteger(row.id_gattung),
 id_differenzierung:toInteger(row.id_differenzierung),
 mandat: toInteger(row.mandat),
 redaktionsort: row.redaktionsort,
 verbreitungsgebiet: toInteger(row.verbreitungsgebiet),
 sprachen: toInteger(row.sprachen),
 anfang_datum: date(row.anfang_datum),
 ende_datum: date(row.ende_datum),
 letztes_ma: toInteger(row.letztes_ma),
 vorher_ma: toInteger(row.vorher_ma),
 erstes_ma: toInteger(row.erstes_ma),
 nach_ma: toInteger(row.nach_ma),
 ueber_ma: toInteger(row.ueber_ma),
 kommentar: row.kommentar,
 literatur: row.literatur
});

dnl medienangebote_jahre nodes:

load csv with headers from 'file:///MEDIENANGEBOTE_jahre.csv' as row
with row
create (:MEDIENANGEBOTE`'_jahre`'POSTFIX {
 id_ma: toInteger(row.id_ma), 
 jahr: date(row.jahr),
 id_unternehmen: toInteger(row.unternehmen),
 id_redaktionslinie_selbst:row.redaktionslinie_selbst,
 redaktionslinie_extern: row.redaktionslinie_extern,
 auflage: toInteger(row.auflage),
 auflage_quelle: toInteger(row.auflage_quelle),
 uniqueusers: toInteger(row.uniqueusers),
 uniqueusers_quelle: row.uniqueusers_quelle,
 reichweite_nat: toInteger(row.reichweite_nat),
 reichweite_nat_quelle: row.reichweite_nat_quelle,
 reichweite_reg: toInteger(row.reichweite_reg),
 reichweite_reg_quelle: row.reichweite_reg_quelle,
 marktanteil: toInteger(row.marktanteil),
 marktanteil_quelle: row.marktanteil_quelle,
 kommentar: row.kommentar,
 literatur: row.literatur
});


dnl show all edge types

MATCH ()-[r]->()
RETURN DISTINCT type(r) AS RelationshipTypes
ORDER BY RelationshipTypes;


dnl show all node labels

MATCH (n)
RETURN DISTINCT labels(n) AS NodeLabels;


dnl show edges of medienangebote nodes

MATCH (n)-[r]->(m)
RETURN labels(n) AS NodeLabels, labels(m) AS ConnectedNodeLabels, type(r) AS RelationshipType, count(*) AS Count
ORDER BY NodeLabels, ConnectedNodeLabels, RelationshipType
;


dnl show dangling nodes

MATCH (n)
WHERE NOT (n)-->()
RETURN DISTINCT labels(n) AS NodeLabels, COUNT(n) AS Count
ORDER BY NodeLabels; 



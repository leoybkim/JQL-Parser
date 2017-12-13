grammar jql;

parse
 : ( jql_stmt_list )* EOF
 ;

jql_stmt_list 
 : SCOL* jql_stmt ( SCOL+ jql_stmt )* SCOL*
 ;
 
jql_stmt
 : OPEN_PAR* expr ( ( K_AND | K_OR) OPEN_PAR* expr CLOSE_PAR* )* CLOSE_PAR* ordering_term?
 ; 

expr
 : K_NOT* ( field | literal_value ) operator OPEN_PAR* ( literal_value | literal_list | FUNCTION | dates ) (compare_dates)? CLOSE_PAR* 
 ;

ordering_term
 : K_ORDER K_BY literal_value ( K_ASC | K_DESC )? (COMMA literal_value ( K_ASC | K_DESC )? )*
 ;

operator
 : EQ
 | NOT_EQ
 | CONTAINS
 | NOT_CONTAINS
 | LT_EQ 
 | LT 
 | GT 
 | GT_EQ 
 | K_IN 
 | K_NOT K_IN
 | K_IS
 | K_WAS
 | K_IS K_NOT
 | K_WAS K_NOT
 | K_CHANGED K_TO
 ;

literal_value
 : STRING_LITERAL
 | IDENTIFIER
 | state_name
 | field
 | dates
 ;
 
FUNCTION
 : [a-zA-Z]+ '(' (.*? | FUNCTION) ')' 
 ;

literal_list
 : '(' literal_value ( COMMA literal_value )* ')'
 ;

keyword
 : K_AFTER
 | K_AND
 | K_ASC
 | K_BEFORE
 | K_BY
 | K_CHANGED
 | K_DESC
 | K_IN
 | K_IS
 | K_NOT
 | K_NULL
 | K_ON
 | K_OR
 | K_ORDER
 | K_TO
 | K_WAS
 ;

state_name
 : K_EMPTY
 ;
 
field
 : F_AFFECTED_VERSION
 | F_APPROVALS
 | F_ASSIGNEE
 | F_ATTACHMENTS
 | F_CATEGORY
 | F_COMMENT
 | F_COMPONENT
 | F_CREATED
 | F_CREATED_DATE
 | F_CREATOR
 | F_CUSTOM_FIELD
 | F_CUSTOMER_REQUEST_TYPE
 | F_DATE
 | F_DESCRIPTION
 | F_DUE
 | F_DURATION
 | F_ENVIRONMENT
 | F_EPIC_LINK
 | F_FILTER
 | F_FIX_VERSION
 | F_ISSUE
 | F_ISSUE_KEY
 | F_ISSUE_TYPE
 | F_KEY
 | F_LABEL
 | F_LABELS
 | F_LAST_VIEWED
 | F_LEVEL
 | F_NUMBER
 | F_ORGANIZATION
 | F_ORIGINAL_ESTIMATE
 | F_PARENT
 | F_PRIORITY
 | F_PROJECT
 | F_RANK
 | F_REMAINING_ESTIMATE
 | F_REPORTER
 | F_REQUEST_CHANNEL_TYPE
 | F_REQUEST_LAST_ACTIVITY_TIME
 | F_RESOLUTION
 | F_RESOLUTION_DATE
 | F_RESOLVED
 | F_SLA
 | F_SPRINT
 | F_STATUS
 | F_SUMMARY
 | F_TEXT
 | F_TIME_SPENT
 | F_TYPE
 | F_UPDATED
 | F_USER
 | F_VERSION
 | F_VOTER
 | F_VOTES
 | F_WATCHER
 | F_WATCHERS
 | F_WORK_RATIO
 ;

compare_dates : ( K_ON | K_AFTER | K_BEFORE )? dates ; 
dates : DATETIME ;

DATETIME 
 : ('-'|'+')? (NUMBER ('d'|'w'|'y'|'h'|'m')?)+ 
 | ('"' DIGIT DIGIT DIGIT DIGIT '-' DIGIT DIGIT '-' DIGIT DIGIT (DIGIT DIGIT ':' DIGIT DIGIT)? '"')
 | ('\'' DIGIT DIGIT DIGIT DIGIT '-' DIGIT DIGIT '-' DIGIT DIGIT (DIGIT DIGIT ':' DIGIT DIGIT)? '\'')
 | ( DIGIT DIGIT DIGIT DIGIT '-' DIGIT DIGIT '-' DIGIT DIGIT (DIGIT DIGIT ':' DIGIT DIGIT)? )
 ;


NUMBER : DIGIT+ ;

WHITESPACE : ' ' -> skip ;

SCOL : ';';
DOT : '.';
OPEN_PAR : '(';
CLOSE_PAR : ')';
COMMA : ',';
EQ : '=';
STAR : '*';
CONTAINS : '~';
NOT_CONTAINS : '!~';
LT : '<';
LT_EQ : '<=';
GT : '>';
GT_EQ : '>=';
NOT_EQ : '!=';

K_AFTER : A F T E R;
K_AND : A N D;
K_ASC : A S C;
K_BEFORE : B E F O R E;
K_BY : B Y;
K_CHANGED : C H A N G E D;
K_DESC : D E S C;
K_EMPTY : E M P T Y;
K_IN : I N;
K_IS : I S;
K_NOT : N O T;
K_NULL : N U L L;
K_ON : O N;
K_OR : O R;
K_ORDER : O R D E R;
K_TO : T O;
K_WAS : W A S;

F_AFFECTED_VERSION : A F F E C T E D V E R S I O N;
F_APPROVALS : A P P R O V A L S;
F_ASSIGNEE : A S S I G N E E;
F_ATTACHMENTS : A T T A C H M E N T S;
F_CATEGORY : C A T E G O R Y;
F_COMMENT : C O M M E N T;
F_COMPONENT : C O M P O N E N T;
F_CREATED : C R E A T E D;
F_CREATED_DATE : C R E A T E D D A T E;
F_CREATOR : C R E A T O R;
F_CUSTOM_FIELD : C F '[' NUMBER ']';
F_CUSTOMER_REQUEST_TYPE : C U S T O M E R R E Q U E S T T Y P E;
F_DATE : D A T E;
F_DESCRIPTION : D E S C R I P T I O N;
F_DUE : D U E;
F_DURATION : D U R A T I O N;
F_ENVIRONMENT : E N V I R O N M E N T;
F_EPIC_LINK : E P I C L I N K;
F_FILTER : F I L T E R;
F_FIX_VERSION : F I X V E R S I O N;
F_ISSUE : I S S U E;
F_ISSUE_KEY : I S S U E K E Y;
F_ISSUE_TYPE : I S S U E T Y P E;
F_KEY : K E Y;
F_LABEL : L A B E L;
F_LABELS : L A B E L S;
F_LAST_VIEWED : L A S T V I E W E D;
F_LEVEL : L E V E L;
F_NUMBER : N U M B E R;
F_ORGANIZATION : O R G A N I Z A T I O N;
F_ORIGINAL_ESTIMATE : O R I G I N A L E S T I M A T E;
F_PARENT : P A R E N T;
F_PRIORITY : P R I O R I T Y;
F_PROJECT : P R O J E C T;
F_RANK : R A N K;
F_REMAINING_ESTIMATE : R E M A I N I N G E S T I M A T E;
F_REPORTER : R E P O R T E R;
F_REQUEST_CHANNEL_TYPE : R E Q U E S T C H A N  N E L T Y P E;
F_REQUEST_LAST_ACTIVITY_TIME : R E Q U E S T L A S T A C T I V I T Y T I M E;
F_RESOLUTION : R E S O L U T I O N;
F_RESOLUTION_DATE : R E S O L U T I O N D A T E;
F_RESOLVED : R E S O L V E D;
F_SLA : S L A;
F_SPRINT : S P R I N T;
F_STATUS : S T A T U S;
F_SUMMARY : S U M M A R Y;
F_TEXT : T E X T;
F_TIME_SPENT : T I M E S P E N T;
F_TYPE : T Y P E;
F_UPDATED : U P D A T E D;
F_USER : U S E R;
F_VERSION : V E R S I O N;
F_VOTER : V O T E R;
F_VOTES : V O T E S;
F_WATCHER : W A T C H E R;
F_WATCHERS : W A T C H E R S;
F_WORK_RATIO : W  O R K R A T I O;

IDENTIFIER
 : '"' (~'"' | '""')* '"'
 | '`' (~'`' | '``')* '`'
 | '[' ~']'* ']'
 | [a-zA-Z_] [a-zA-Z_0-9.\-]* // TODO check: needs more chars in set
 | '-'
 | [A-Z]+ '-' [0-9]+ // ex) KEY-###
 ;

STRING_LITERAL
 : '\'' ('\\'. | '\'\'' | ~('\'' | '\\'))* '\''
 | '"' ( '\\'. | '""' | ~('"'| '\\') )* '"'
 ;
 
COMMENT
 : '/*' .*? '*/' -> skip
 ;

LINE_COMMENT
 : '//' ~[\r\n]* -> skip
 ;

SPACES
 : [ \u000B\t\r\n] -> channel(HIDDEN)
 ;

fragment DIGIT : [0-9];

fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];
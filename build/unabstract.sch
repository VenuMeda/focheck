<?xml version="1.0" encoding="UTF-8"?><schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2">
    <xsl:key name="flow-name" match="fo:flow | fo:static-content" use="@flow-name"/>
    <xsl:key name="index-key" match="*[exists(@index-key)]" use="@index-key"/>
    <xsl:key name="master-name" match="fo:simple-page-master | fo:page-sequence-master |       axf:spread-page-master" use="@master-name"/>
    <xsl:key name="region-name" match="fo:region-before | fo:region-after |       fo:region-start | fo:region-end |       fo:region-body | axf:spread-region" use="@region-name"/>

    <pattern id="abstract">

  
  <rule abstract="true" id="color-transparent">
    <let name="expression" value="ahf:parser-runner(.)"/>
    <assert test="local-name($expression) = ('Color', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')"><value-of select="name()"/>="<value-of select="."/>" should be Color, 'transparent', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
    <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('transparent', 'inherit'))"><value-of select="name()"/>="<value-of select="."/>" token should be 'transparent' or 'inherit'. Enumeration token is '<value-of select="$expression/@token"/>'.</report>
    <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name()"/>="" should be Color, 'transparent', or 'inherit'.</report>
    <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name()"/>="<value-of select="."/>"</report>
  </rule>

  
  
  
  <rule abstract="true" id="border-style">
    <let name="expression" value="ahf:parser-runner(.)"/>
    <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')"><value-of select="name()"/>="<value-of select="."/>" should be 'none', 'hidden', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', 'inset', 'outset', 'dot-dash', 'dot-dot-dash', 'wave', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
    <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'hidden', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', 'inset', 'outset', 'dot-dash', 'dot-dot-dash', 'wave', 'inherit'))"><value-of select="name()"/>="<value-of select="."/>" token should be 'none', 'hidden', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', 'inset', 'outset', 'dot-dash', 'dot-dot-dash', 'wave', or 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
    <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name()"/>="" should be 'none', 'hidden', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', 'inset', 'outset', 'dot-dash', 'dot-dot-dash', 'wave', or 'inherit'.</report>
    <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name()"/>="<value-of select="."/>"</report>
  </rule>

   
   
   
   <rule abstract="true" id="border-width">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'"><value-of select="name()"/>="<value-of select="."/>" should be 'thin', 'medium', 'thick', 'inherit', or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('thin', 'medium', 'thick', 'inherit'))"><value-of select="name()"/>="<value-of select="."/>" token should be 'thin', 'medium', 'thick', or 'inherit'. Enumeration token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name()"/>="" should be 'thin', 'medium', 'thick', 'inherit', or Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name()"/>="<value-of select="."/>"</report>
   </rule>

</pattern>
    <pattern xmlns:ahf="http://www.antennahouse.com/names/XSLT/Functions/Document" id="fo-fo">

  

  <rule context="fo:basic-link | fo:bookmark">
    
    
    <report test="exists(@internal-destination) and exists(@external-destination)" role="Warning">An '<value-of select="name()"/>' should not have both 'internal-destination' and 'external-destination' properties.  The FO processor may report an error or may use 'internal-destination'.</report>
  </rule>

  <rule context="fo:change-bar-begin">
    
    <report test="exists(@change-bar-class) and not(@change-bar-class = following::fo:change-bar-end/@change-bar-class)" role="Warning">An '<value-of select="name()"/>' that does not form a matching pair with an 'fo:change-bar-end' will assume a matching 'change-bar-end' at the end of the document.</report>
  </rule>

  <rule context="fo:change-bar-end">
    
    <report test="exists(@change-bar-class) and not(@change-bar-class = preceding::fo:change-bar-begin/@change-bar-class)" role="Warning">An '<value-of select="name()"/>' that does not form a matching pair with an 'fo:change-bar-begin' will be ignored.</report>
  </rule>

  <rule context="fo:float">
    
    <report test="exists(ancestor::fo:float) or exists(ancestor::fo:footnote)">An '<value-of select="name()"/>' is not allowed as a descendant of 'fo:float' or 'fo:footnote'.</report>
  </rule>

  <rule context="fo:footnote">
    
    <report test="(for $ancestor in ancestor::fo:* return local-name($ancestor)) = ('float', 'footnote')">An '<value-of select="name()"/>' is not allowed as a descendant of 'fo:float' or 'fo:footnote'.</report>
    
    
    <report test="exists(ancestor::fo:block-container[@absolute-position = ('absolute', 'fixed')])" role="Warning">An 'fo:footnote' that is a descendant of an 'fo:block-container' that generates an absolutely positioned area will be placed as normal block-level areas.</report>
    <report test="exists(descendant::fo:block-container[@absolute-position = ('absolute', 'fixed')])">An 'fo:footnote' is not permitted to have as a descendant an 'fo:block-container' that generates an absolutely positioned area.</report>
    <report test="exists(descendant::fo:*[local-name() = ('float', 'footnote', 'marker')])">An 'fo:footnote' is not permitted to have an 'fo:float', 'fo:footnote', or 'fo:marker' as a descendant.</report>
  </rule>

  <rule context="fo:list-block">
    <assert test="exists((., ancestor::*)/@provisional-distance-between-starts)" role="Warning" sqf:fix="list-block-pdbs-fix">fo:list-block with no 'provisional-distance-between-starts' and no inherited value will use 24pt.</assert>
    <sqf:fix id="list-block-pdbs-fix">
      <sqf:description>
        <sqf:title>Add 'provisional-distance-between-starts'</sqf:title>
      </sqf:description>
      <sqf:add node-type="attribute" target="provisional-distance-between-starts"/>
    </sqf:fix>
    <assert test="exists((., ancestor::*)/@provisional-label-separation)" role="Warning" sqf:fix="list-block-pls-fix">fo:list-block with no 'provisional-label-separation' and no inherited value will use 6pt.</assert>
    <sqf:fix id="list-block-pls-fix">
      <sqf:description>
        <sqf:title>Add 'provisional-label-separation'</sqf:title>
      </sqf:description>
      <sqf:add node-type="attribute" target="provisional-label-separation"/>
    </sqf:fix>
  </rule>

  <rule context="fo:list-item-body[empty(@start-indent)]">
    <report test="true()" id="list-item-body-start-indent" role="Warning" sqf:fix="list-item-body-start-indent-fix">fo:list-item-body with no 'start-indent' will use inherited 'start-indent' value.</report>
    <sqf:fix id="list-item-body-start-indent-fix">
      <sqf:description>
        <sqf:title>Add 'start-indent="body-start()"'</sqf:title>
      </sqf:description>
      <sqf:add node-type="attribute" target="start-indent" select="'body-start()'"/>
    </sqf:fix>
  </rule>

  <rule context="fo:list-item-label[empty(@end-indent)]">
    <report test="true()" id="list-item-label-end-indent" role="Warning" sqf:fix="list-item-label-end-indent-fix">fo:list-item-label with no 'end-indent' will use inherited 'end-indent' value.</report>
    <sqf:fix id="list-item-label-end-indent-fix">
      <sqf:description>
        <sqf:title>Add 'end-indent="label-end()"'</sqf:title>
      </sqf:description>
      <sqf:add node-type="attribute" target="end-indent" select="'label-end()'"/>
    </sqf:fix>
  </rule>

  <rule context="fo:marker">
    
    <assert test="exists(ancestor::fo:flow)">An fo:marker is only permitted as the descendant of an fo:flow.</assert>
    <assert test="empty(ancestor::fo:marker)">An fo:marker is not permitted as a descendant of an fo:marker.</assert>
    <assert test="empty(ancestor::fo:retrieve-marker)">An fo:marker is not permitted as a descendant of an fo:retrieve-marker.</assert>
    <assert test="empty(ancestor::fo:retrieve-table-marker)">An fo:marker is not permitted as a descendant of an fo:retrieve-table-marker.</assert>
  </rule>

  <rule context="fo:retrieve-marker">
    
    <assert test="exists(ancestor::fo:static-content)">An fo:retrieve-marker is only permitted as the descendant of an fo:static-content.</assert>
  </rule>

  <rule context="fo:retrieve-table-marker">
    
    <assert test="exists(ancestor::fo:table-header) or                   exists(ancestor::fo:table-footer) or                   (exists(parent::fo:table) and empty(preceding-sibling::fo:table-body) and empty(following-sibling::fo:table-column))">An fo:retrieve-table-marker is only permitted as the descendant of an fo:table-header or fo:table-footer or as a child of fo:table in a position where fo:table-header or fo:table-footer is permitted.</assert>
  </rule>

  <rule context="fo:root">
    
    <assert id="fo_root-001" test="exists(descendant::fo:page-sequence)">There must be at least one fo:page-sequence descendant of fo:root.</assert>
  </rule>

  <rule context="fo:table-cell">
    <report test="empty(*) and normalize-space() ne ''" role="Warning" sqf:fix="table-cell-empty-fix">fo:table-cell should contain block-level FOs.</report>
    <sqf:fix id="table-cell-empty-fix">
      <let name="text" value="."/>
      <sqf:description>
        <sqf:title>Add 'fo:block' around text</sqf:title>
      </sqf:description>
      <sqf:delete match="node()"/>
      <sqf:add node-type="element" target="fo:block">
	<value-of select="."/>
      </sqf:add>
    </sqf:fix>
  </rule>

  

  <rule context="fo:*/@character | fo:*/@grouping-separator">
    <assert test="string-length(.) = 1" id="character_grouping-separator"><value-of select="name()"/>="<value-of select="."/>" should be a single character.</assert>
  </rule>

  <rule context="fo:*/@column-count | fo:*/@number-columns-spanned">
    <let name="expression" value="ahf:parser-runner(.)"/>
    <report test="local-name($expression) = 'Number' and                   (exists($expression/@is-positive) and $expression/@is-positive eq 'no' or                    $expression/@is-zero = 'yes' or                    exists($expression/@value) and not($expression/@value castable as xs:integer))" id="column-count" role="Warning" sqf:fix="column-count-fix"><value-of select="name()"/>="<value-of select="."/>" should be a positive integer.  A non-positive or non-integer value will be rounded to the nearest integer value greater than or equal to 1.</report>
    <sqf:fix id="column-count-fix">
      <sqf:description>
        <sqf:title>Change the @column-count value</sqf:title>
      </sqf:description>
      <sqf:replace node-type="attribute" target="column-count" select="max((1, round(.)))"/>
    </sqf:fix>
  </rule>

  <rule context="fo:*/@column-width">
    <let name="number-columns-spanned" value="ahf:parser-runner(../@number-columns-spanned)"/>
    <report test="exists(../@number-columns-spanned) and     local-name($number-columns-spanned) = 'Number' and                   (exists($number-columns-spanned/@value) and      number($number-columns-spanned/@value) &gt;= 1.5)" id="column-width" role="Warning"><value-of select="name()"/> is ignored with 'number-columns-spanned' is present and has a value greater than 1.</report>
  </rule>

  <rule context="fo:*/@flow-map-reference">
    
    <report test="empty(/fo:root/fo:layout-master-set/fo:flow-map/@flow-map-name[. eq current()])">flow-map-reference="<value-of select="."/>" does not match any fo:flow-map name.</report>
  </rule>

  <rule context="fo:*/@flow-name">
    
    <assert test="count(../../*/@flow-name[. eq current()]) = 1">flow-name="<value-of select="."/>" must be unique within its fo:page-sequence.</assert>
    <report test="not(. = ('xsl-region-body',          'xsl-region-start',          'xsl-region-end',          'xsl-region-before',          'xsl-region-after',          'xsl-footnote-separator',          'xsl-before-float-separator')) and               empty(key('region-name', .)) and               empty(/fo:root/fo:layout-master-set/fo:flow-map[@flow-map-name = current()/ancestor::fo:page-sequence[1]/@flow-map-reference]/fo:flow-assignment/fo:flow-source-list/fo:flow-name-specifier/@flow-name-reference[. eq current()])" role="Warning">flow-name="<value-of select="."/>" does not match any named or reserved region-name or a flow-name-reference.</report>
  </rule>

  <rule context="fo:*/@flow-name-reference">
    
    <assert test="count(ancestor::fo:flow-map//fo:flow-name-specifier/@flow-name-reference[. eq current()]) = 1">flow-name-reference="<value-of select="., ancestor::fo-flow-map//fo:flow-name-specifier/@flow-name-reference[. eq current()]"/>" must be unique within its fo:flow-map.</assert>
    
    
    <assert test="count(distinct-values(for $fo in key('flow-name', .)[ancestor::fo:page-sequence/@flow-map-reference = current()/ancestor::fo:flow-map/@flow-map-name] return local-name($fo))) = 1" role="Warning">flow-name-reference="<value-of select="."/>" should only be used with all fo:flow or all fo:static-content.</assert>
  </rule>

  <rule context="fo:*/@hyphenation-character">
    <assert test="string-length(.) = 1 or . eq 'inherit'" id="hyphenation-character"><value-of select="name()"/>="<value-of select="."/>" should be a single character or 'inherit'.</assert>
  </rule>

  <rule context="fo:*/@language">
    <let name="expression" value="ahf:parser-runner(.)"/>
    
    
    <assert test="local-name($expression) = ('EnumerationToken', 'ERROR', 'Object')">language="<value-of select="."/>" should be an EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
    <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'inherit') or string-length($expression/@token) = 2 or string-length($expression/@token) = 3)">language="<value-of select="."/>" should be a 3-letter code conforming to a ISO639-2 terminology or bibliographic code or a 2-letter code conforming to a ISO639 2-letter code or 'none' or 'inherit'.</report>
    <report test="local-name($expression) = 'ERROR'">Syntax error: 'language="<value-of select="."/>"'</report>
    
    
    
  </rule>

  <rule context="fo:marker/@marker-class-name">
    
    
    <assert test="count(../../fo:marker[@marker-class-name eq current()]) = 1" role="Warning">marker-class-name="<value-of select="."/>" should be unique among fo:marker with the same parent.</assert>
  </rule>

  <rule context="fo:*/@master-name">
    
    <assert test="count(key('master-name', .)) = 1" role="Warning">master-name="<value-of select="."/>" should be unique.</assert>
  </rule>

  <rule context="fo:*/@master-reference">
    
    <assert test="exists(key('master-name', .))" role="Warning">master-reference="<value-of select="."/>" should refer to a master-name that exists within the document.</assert>
    <report test="count(key('master-name', .)) &gt; 1" role="Warning">master-reference="<value-of select="."/>" refers to multiple master-name within the document.</report>
  </rule>

  <rule context="fo:*/@overflow">
    
    <report test=". eq 'repeat' and ../@absolute-position = ('absolute', 'fixed')" role="Warning">overflow="<value-of select="."/>" on an absolutely-positioned area will be treated as 'auto'.</report>
  </rule>

  <rule context="fo:index-key-reference/@ref-index-key">
    
    <let name="index-key-reference" value="."/>
    <report test="empty(key('index-key', .))" role="Warning">ref-index-key="<value-of select="."/>" does not match any index-key values.</report>
    <report test="exists(key('index-key', .)) and (some $index-hit in key('index-key', .) satisfies $index-hit &gt;&gt; $index-key-reference)" role="Warning">ref-index-key="<value-of select="."/>" occurs before a matching index-key value.</report>
  </rule>

  <rule context="fo:*/@region-name">
    
    <assert test="count(distinct-values(for $fo in key('region-name', .) return local-name($fo))) = 1" role="Warning">region-name="<value-of select="."/>" should only be used with regions of the same class.</assert>
    <assert test="not(. eq 'xsl-region-body') or local-name(..) eq 'region-body'">region-name="<value-of select="."/>" should only be used with fo:region-body.</assert>
    <assert test="not(. eq 'xsl-region-start') or local-name(..) eq 'region-start'">region-name="<value-of select="."/>" should only be used with fo:region-start.</assert>
    <assert test="not(. eq 'xsl-region-end') or local-name(..) eq 'region-end'">region-name="<value-of select="."/>" should only be used with fo:region-end.</assert>
    <assert test="not(. eq 'xsl-region-before') or local-name(..) eq 'region-before'">region-name="<value-of select="."/>" should only be used with fo:region-before.</assert>
    <assert test="not(. eq 'xsl-region-after') or local-name(..) eq 'region-after'">region-name="<value-of select="."/>" should only be used with fo:region-after.</assert>
  </rule>

  <rule context="fo:*/@region-name-reference">
    
    <assert test="count(ancestor::fo:flow-map//fo:region-name-specifier/@region-name-reference[. eq current()]) = 1">region-name-reference="<value-of select="."/>" must be unique within its fo:flow-map.</assert>
  </rule>

  <rule context="fo:*/@span">
    
    <report test="exists(ancestor::fo:static-content)" sqf:fix="span_fix" role="warning">@span has effect only on areas returned by an fo:flow.</report>
    <sqf:fix id="span_fix">
      <sqf:description>
        <sqf:title>Delete @span</sqf:title>
      </sqf:description>
      <sqf:delete/>
    </sqf:fix>
  </rule>

</pattern>
    <pattern xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions" id="fo-property">
   <xsl:include href="file:/E:/Projects/oxygen/focheck-internal/focheck/xsl/parser-runner.xsl"/>

   
   
   
   
   
   <rule context="fo:*/@absolute-position">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">absolute-position="<value-of select="."/>" should be 'auto', 'absolute', 'fixed', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'absolute', 'fixed', 'inherit'))">absolute-position="<value-of select="."/>". Allowed keywords are 'auto', 'absolute', 'fixed', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">absolute-position="" should be 'auto', 'absolute', 'fixed', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: absolute-position="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@active-state">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">active-state="<value-of select="."/>" should be 'link', 'visited', 'active', 'hover', or 'focus'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('link', 'visited', 'active', 'hover', 'focus'))">active-state="<value-of select="."/>". Allowed keywords are 'link', 'visited', 'active', 'hover', and 'focus'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">active-state="" should be 'link', 'visited', 'active', 'hover', or 'focus'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: active-state="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@alignment-adjust">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Percent', 'Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">alignment-adjust="<value-of select="."/>" should be 'auto', 'baseline', 'before-edge', 'text-before-edge', 'middle', 'central', 'after-edge', 'text-after-edge', 'ideographic', 'alphabetic', 'hanging', 'mathematical', 'inherit', Percent, or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'baseline', 'before-edge', 'text-before-edge', 'middle', 'central', 'after-edge', 'text-after-edge', 'ideographic', 'alphabetic', 'hanging', 'mathematical', 'inherit'))">alignment-adjust="<value-of select="."/>". Allowed keywords are 'auto', 'baseline', 'before-edge', 'text-before-edge', 'middle', 'central', 'after-edge', 'text-after-edge', 'ideographic', 'alphabetic', 'hanging', 'mathematical', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">alignment-adjust="" should be 'auto', 'baseline', 'before-edge', 'text-before-edge', 'middle', 'central', 'after-edge', 'text-after-edge', 'ideographic', 'alphabetic', 'hanging', 'mathematical', 'inherit', Percent, or Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: alignment-adjust="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@alignment-baseline">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">alignment-baseline="<value-of select="."/>" should be 'auto', 'baseline', 'before-edge', 'text-before-edge', 'middle', 'central', 'after-edge', 'text-after-edge', 'ideographic', 'alphabetic', 'hanging', 'mathematical', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'baseline', 'before-edge', 'text-before-edge', 'middle', 'central', 'after-edge', 'text-after-edge', 'ideographic', 'alphabetic', 'hanging', 'mathematical', 'inherit'))">alignment-baseline="<value-of select="."/>". Allowed keywords are 'auto', 'baseline', 'before-edge', 'text-before-edge', 'middle', 'central', 'after-edge', 'text-after-edge', 'ideographic', 'alphabetic', 'hanging', 'mathematical', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">alignment-baseline="" should be 'auto', 'baseline', 'before-edge', 'text-before-edge', 'middle', 'central', 'after-edge', 'text-after-edge', 'ideographic', 'alphabetic', 'hanging', 'mathematical', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: alignment-baseline="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@allowed-height-scale">
      <report test=". eq ''" role="Warning">allowed-height-scale="" should be '[ any | &lt;percentage&gt; ]* | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@allowed-width-scale">
      <report test=". eq ''" role="Warning">allowed-width-scale="" should be '[ any | &lt;percentage&gt; ]* | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@auto-restore">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">auto-restore="<value-of select="."/>" should be 'true' or 'false'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('true', 'false'))">auto-restore="<value-of select="."/>". Allowed keywords are 'true' and 'false'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">auto-restore="" should be 'true' or 'false'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: auto-restore="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@background">
      <report test=". eq ''" role="Warning">background="" should be '[&lt;background-color&gt; || &lt;background-image&gt; || &lt;background-repeat&gt; || &lt;background-attachment&gt; || &lt;background-position&gt; ]] | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@background-attachment">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">background-attachment="<value-of select="."/>" should be 'scroll', 'fixed', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('scroll', 'fixed', 'inherit'))">background-attachment="<value-of select="."/>". Allowed keywords are 'scroll', 'fixed', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">background-attachment="" should be 'scroll', 'fixed', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: background-attachment="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@background-color">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Color', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">background-color="<value-of select="."/>" should be Color, 'transparent', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('transparent', 'inherit'))">background-color="<value-of select="."/>". Allowed keywords are 'transparent' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">background-color="" should be Color, 'transparent', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: background-color="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@background-image">
      <report test=". eq ''" role="Warning">background-image="" should be '&lt;uri-specification&gt; | none | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@background-position">
      <report test=". eq ''" role="Warning">background-position="" should be '[ [&lt;percentage&gt; | &lt;length&gt; ]{1,2} | [ [top | center | bottom] || [left | center | right] ] ] | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@background-position-horizontal">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Percent', 'Length', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">background-position-horizontal="<value-of select="."/>" should be Percent, Length, 'left', 'center', 'right', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('left', 'center', 'right', 'inherit'))">background-position-horizontal="<value-of select="."/>". Allowed keywords are 'left', 'center', 'right', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">background-position-horizontal="" should be Percent, Length, 'left', 'center', 'right', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: background-position-horizontal="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@background-position-vertical">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Percent', 'Length', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">background-position-vertical="<value-of select="."/>" should be Percent, Length, 'top', 'center', 'bottom', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('top', 'center', 'bottom', 'inherit'))">background-position-vertical="<value-of select="."/>". Allowed keywords are 'top', 'center', 'bottom', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">background-position-vertical="" should be Percent, Length, 'top', 'center', 'bottom', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: background-position-vertical="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@background-repeat">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">background-repeat="<value-of select="."/>" should be 'repeat', 'repeat-x', 'repeat-y', 'no-repeat', or 'paginate'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('repeat', 'repeat-x', 'repeat-y', 'no-repeat', 'paginate'))">background-repeat="<value-of select="."/>". Allowed keywords are 'repeat', 'repeat-x', 'repeat-y', 'no-repeat', and 'paginate'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">background-repeat="" should be 'repeat', 'repeat-x', 'repeat-y', 'no-repeat', or 'paginate'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: background-repeat="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@baseline-shift">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Percent', 'Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">baseline-shift="<value-of select="."/>" should be 'baseline', 'sub', 'super', 'inherit', Percent, or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('baseline', 'sub', 'super', 'inherit'))">baseline-shift="<value-of select="."/>". Allowed keywords are 'baseline', 'sub', 'super', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">baseline-shift="" should be 'baseline', 'sub', 'super', 'inherit', Percent, or Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: baseline-shift="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@blank-or-not-blank">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">blank-or-not-blank="<value-of select="."/>" should be 'blank', 'not-blank', 'any', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('blank', 'not-blank', 'any', 'inherit'))">blank-or-not-blank="<value-of select="."/>". Allowed keywords are 'blank', 'not-blank', 'any', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">blank-or-not-blank="" should be 'blank', 'not-blank', 'any', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: blank-or-not-blank="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@block-progression-dimension">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">block-progression-dimension="<value-of select="."/>" should be 'auto', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">block-progression-dimension="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">block-progression-dimension="" should be 'auto', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: block-progression-dimension="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border">
      <report test=". eq ''" role="Warning">border="" should be '[ &lt;border-width&gt; || &lt;border-style&gt; || [ &lt;color&gt; | transparent ] ] | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-after-color">
      <extends rule="color-transparent"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-after-precedence">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">border-after-precedence="<value-of select="."/>" should be 'force', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('force', 'inherit'))">border-after-precedence="<value-of select="."/>". Allowed keywords are 'force' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">border-after-precedence="" should be 'force', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: border-after-precedence="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-after-style">
      <extends rule="border-style"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-after-width">
      <extends rule="border-width"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-before-color">
      <extends rule="color-transparent"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-before-precedence">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">border-before-precedence="<value-of select="."/>" should be 'force', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('force', 'inherit'))">border-before-precedence="<value-of select="."/>". Allowed keywords are 'force' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">border-before-precedence="" should be 'force', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: border-before-precedence="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-before-style">
      <extends rule="border-style"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-before-width">
      <extends rule="border-width"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-bottom">
      <report test=". eq ''" role="Warning">border-bottom="" should be '[ &lt;border-width&gt; || &lt;border-style&gt; || [ &lt;color&gt; | transparent ] ] | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-bottom-color">
      <extends rule="color-transparent"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-bottom-style">
      <extends rule="border-style"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-bottom-width">
      <extends rule="border-width"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-collapse">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">border-collapse="<value-of select="."/>" should be 'collapse', 'collapse-with-precedence', 'separate', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('collapse', 'collapse-with-precedence', 'separate', 'inherit'))">border-collapse="<value-of select="."/>". Allowed keywords are 'collapse', 'collapse-with-precedence', 'separate', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">border-collapse="" should be 'collapse', 'collapse-with-precedence', 'separate', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: border-collapse="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-color">
      <report test=". eq ''" role="Warning">border-color="" should be '[ &lt;color&gt; | transparent ]{1,4} | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-end-color">
      <extends rule="color-transparent"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-end-precedence">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">border-end-precedence="<value-of select="."/>" should be 'force', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('force', 'inherit'))">border-end-precedence="<value-of select="."/>". Allowed keywords are 'force' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">border-end-precedence="" should be 'force', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: border-end-precedence="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-end-style">
      <extends rule="border-style"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-end-width">
      <extends rule="border-width"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-left">
      <report test=". eq ''" role="Warning">border-left="" should be '[ &lt;border-width&gt; || &lt;border-style&gt; || [ &lt;color&gt; | transparent ] ] | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-left-color">
      <extends rule="color-transparent"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-left-style">
      <extends rule="border-style"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-left-width">
      <extends rule="border-width"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-right">
      <report test=". eq ''" role="Warning">border-right="" should be '[ &lt;border-width&gt; || &lt;border-style&gt; || [ &lt;color&gt; | transparent ] ] | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-right-color">
      <extends rule="color-transparent"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-right-style">
      <extends rule="border-style"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-right-width">
      <extends rule="border-width"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-separation">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">border-separation="<value-of select="."/>" should be Length or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">border-separation="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">border-separation="" should be Length or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: border-separation="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-spacing">
      <report test=". eq ''" role="Warning">border-spacing="" should be '&lt;length&gt; &lt;length&gt;? | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-start-color">
      <extends rule="color-transparent"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-start-precedence">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">border-start-precedence="<value-of select="."/>" should be 'force', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('force', 'inherit'))">border-start-precedence="<value-of select="."/>". Allowed keywords are 'force' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">border-start-precedence="" should be 'force', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: border-start-precedence="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-start-style">
      <extends rule="border-style"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-start-width">
      <extends rule="border-width"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-style">
      <report test=". eq ''" role="Warning">border-style="" should be '&lt;border-style&gt;{1,4} | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-top">
      <report test=". eq ''" role="Warning">border-top="" should be '[ &lt;border-width&gt; || &lt;border-style&gt; || [ &lt;color&gt; | transparent ] ] | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-top-color">
      <extends rule="color-transparent"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-top-style">
      <extends rule="border-style"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-top-width">
      <extends rule="border-width"/>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@border-width">
      <report test=". eq ''" role="Warning">border-width="" should be '&lt;border-width&gt;{1,4} | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@bottom">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">bottom="<value-of select="."/>" should be Length, Percent, 'auto', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">bottom="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">bottom="" should be Length, Percent, 'auto', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: bottom="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@break-after">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">break-after="<value-of select="."/>" should be 'auto', 'column', 'page', 'even-page', 'odd-page', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'column', 'page', 'even-page', 'odd-page', 'inherit'))">break-after="<value-of select="."/>". Allowed keywords are 'auto', 'column', 'page', 'even-page', 'odd-page', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">break-after="" should be 'auto', 'column', 'page', 'even-page', 'odd-page', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: break-after="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@break-before">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">break-before="<value-of select="."/>" should be 'auto', 'column', 'page', 'even-page', 'odd-page', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'column', 'page', 'even-page', 'odd-page', 'inherit'))">break-before="<value-of select="."/>". Allowed keywords are 'auto', 'column', 'page', 'even-page', 'odd-page', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">break-before="" should be 'auto', 'column', 'page', 'even-page', 'odd-page', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: break-before="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@caption-side">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">caption-side="<value-of select="."/>" should be 'before', 'after', 'start', 'end', 'top', 'bottom', 'left', 'right', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('before', 'after', 'start', 'end', 'top', 'bottom', 'left', 'right', 'inherit'))">caption-side="<value-of select="."/>". Allowed keywords are 'before', 'after', 'start', 'end', 'top', 'bottom', 'left', 'right', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">caption-side="" should be 'before', 'after', 'start', 'end', 'top', 'bottom', 'left', 'right', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: caption-side="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@case-name">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">case-name="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">case-name="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: case-name="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@case-title">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Literal', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">case-title="<value-of select="."/>" should be Literal or EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">case-title="" should be Literal or EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: case-title="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@change-bar-class">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">change-bar-class="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">change-bar-class="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: change-bar-class="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@change-bar-color">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Color', 'EMPTY', 'ERROR', 'Object')">change-bar-color="<value-of select="."/>" should be Color.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">change-bar-color="" should be Color.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: change-bar-color="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@change-bar-offset">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">change-bar-offset="<value-of select="."/>" should be Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">change-bar-offset="" should be Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: change-bar-offset="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@change-bar-placement">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">change-bar-placement="<value-of select="."/>" should be 'start', 'end', 'left', 'right', 'inside', 'outside', or 'alternate'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('start', 'end', 'left', 'right', 'inside', 'outside', 'alternate'))">change-bar-placement="<value-of select="."/>". Allowed keywords are 'start', 'end', 'left', 'right', 'inside', 'outside', and 'alternate'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">change-bar-placement="" should be 'start', 'end', 'left', 'right', 'inside', 'outside', or 'alternate'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: change-bar-placement="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@change-bar-style">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">change-bar-style="<value-of select="."/>" should be 'none', 'hidden', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', 'inset', or 'outset'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'hidden', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', 'inset', 'outset'))">change-bar-style="<value-of select="."/>". Allowed keywords are 'none', 'hidden', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', 'inset', and 'outset'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">change-bar-style="" should be 'none', 'hidden', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', 'inset', or 'outset'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: change-bar-style="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@change-bar-width">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">change-bar-width="<value-of select="."/>" should be 'thin', 'medium', 'thick', or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('thin', 'medium', 'thick'))">change-bar-width="<value-of select="."/>". Allowed keywords are 'thin', 'medium', and 'thick'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">change-bar-width="" should be 'thin', 'medium', 'thick', or Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: change-bar-width="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@character">
      <report test=". eq ''" role="Warning">character="" should be '&lt;character&gt;'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@clear">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">clear="<value-of select="."/>" should be 'start', 'end', 'left', 'right', 'inside', 'outside', 'both', 'none', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('start', 'end', 'left', 'right', 'inside', 'outside', 'both', 'none', 'inherit'))">clear="<value-of select="."/>". Allowed keywords are 'start', 'end', 'left', 'right', 'inside', 'outside', 'both', 'none', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">clear="" should be 'start', 'end', 'left', 'right', 'inside', 'outside', 'both', 'none', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: clear="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@clip">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Function', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">clip="<value-of select="."/>" should be Function, 'auto', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">clip="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">clip="" should be Function, 'auto', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: clip="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@color">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Color', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">color="<value-of select="."/>" should be Color, 'transparent', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('transparent', 'inherit'))">color="<value-of select="."/>". Allowed keywords are 'transparent' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">color="" should be Color, 'transparent', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: color="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@color-profile-name">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">color-profile-name="<value-of select="."/>" should be 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">color-profile-name="" should be 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: color-profile-name="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@column-count">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">column-count="<value-of select="."/>" should be Number or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">column-count="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">column-count="" should be Number or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: column-count="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@column-gap">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">column-gap="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">column-gap="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">column-gap="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: column-gap="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@column-number">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EMPTY', 'ERROR', 'Object')">column-number="<value-of select="."/>" should be Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">column-number="" should be Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: column-number="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@column-width">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">column-width="<value-of select="."/>" should be Length or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">column-width="" should be Length or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: column-width="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@content-height">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">content-height="<value-of select="."/>" should be 'auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', 'inherit'))">content-height="<value-of select="."/>". Allowed keywords are 'auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">content-height="" should be 'auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: content-height="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@content-type">
      <report test=". eq ''" role="Warning">content-type="" should be '&lt;string&gt; | auto'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@content-width">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">content-width="<value-of select="."/>" should be 'auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', 'inherit'))">content-width="<value-of select="."/>". Allowed keywords are 'auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">content-width="" should be 'auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: content-width="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@country">
      <report test=". eq ''" role="Warning">country="" should be 'none | &lt;country&gt; | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@cue">
      <report test=". eq ''" role="Warning">cue="" should be '&lt;cue-before&gt; || &lt;cue-after&gt; | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@destination-placement-offset">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">destination-placement-offset="<value-of select="."/>" should be Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">destination-placement-offset="" should be Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: destination-placement-offset="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@direction">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">direction="<value-of select="."/>" should be 'ltr', 'rtl', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('ltr', 'rtl', 'inherit'))">direction="<value-of select="."/>". Allowed keywords are 'ltr', 'rtl', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">direction="" should be 'ltr', 'rtl', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: direction="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@display-align">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">display-align="<value-of select="."/>" should be 'auto', 'before', 'center', 'after', or 'justify'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'before', 'center', 'after', 'justify'))">display-align="<value-of select="."/>". Allowed keywords are 'auto', 'before', 'center', 'after', and 'justify'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">display-align="" should be 'auto', 'before', 'center', 'after', or 'justify'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: display-align="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@dominant-baseline">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">dominant-baseline="<value-of select="."/>" should be 'auto', 'use-script', 'no-change', 'reset-size', 'ideographic', 'alphabetic', 'hanging', 'mathematical', 'central', 'middle', 'text-after-edge', 'text-before-edge', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'use-script', 'no-change', 'reset-size', 'ideographic', 'alphabetic', 'hanging', 'mathematical', 'central', 'middle', 'text-after-edge', 'text-before-edge', 'inherit'))">dominant-baseline="<value-of select="."/>". Allowed keywords are 'auto', 'use-script', 'no-change', 'reset-size', 'ideographic', 'alphabetic', 'hanging', 'mathematical', 'central', 'middle', 'text-after-edge', 'text-before-edge', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">dominant-baseline="" should be 'auto', 'use-script', 'no-change', 'reset-size', 'ideographic', 'alphabetic', 'hanging', 'mathematical', 'central', 'middle', 'text-after-edge', 'text-before-edge', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: dominant-baseline="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@empty-cells">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">empty-cells="<value-of select="."/>" should be 'show', 'hide', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('show', 'hide', 'inherit'))">empty-cells="<value-of select="."/>". Allowed keywords are 'show', 'hide', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">empty-cells="" should be 'show', 'hide', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: empty-cells="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@end-indent">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">end-indent="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">end-indent="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">end-indent="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: end-indent="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@ends-row">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">ends-row="<value-of select="."/>" should be 'true' or 'false'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('true', 'false'))">ends-row="<value-of select="."/>". Allowed keywords are 'true' and 'false'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">ends-row="" should be 'true' or 'false'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: ends-row="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@extent">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">extent="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">extent="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">extent="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: extent="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@external-destination"/>

   
   
   
   
   
   <rule context="fo:*/@float">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">float="<value-of select="."/>" should be 'before', 'start', 'end', 'left', 'right', 'inside', 'outside', 'none', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('before', 'start', 'end', 'left', 'right', 'inside', 'outside', 'none', 'inherit'))">float="<value-of select="."/>". Allowed keywords are 'before', 'start', 'end', 'left', 'right', 'inside', 'outside', 'none', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">float="" should be 'before', 'start', 'end', 'left', 'right', 'inside', 'outside', 'none', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: float="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@flow-map-name">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">flow-map-name="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">flow-map-name="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: flow-map-name="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@flow-map-reference">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">flow-map-reference="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">flow-map-reference="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: flow-map-reference="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@flow-name">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">flow-name="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">flow-name="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: flow-name="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@flow-name-reference">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">flow-name-reference="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">flow-name-reference="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: flow-name-reference="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@font">
      <report test=". eq ''" role="Warning">font="" should be '[ [ &lt;font-style&gt; || &lt;font-variant&gt; || &lt;font-weight&gt; ]? &lt;font-size&gt; [ / &lt;line-height&gt;]? &lt;font-family&gt; ] | caption | icon | menu | message-box | small-caption | status-bar | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@font-family">
      <report test=". eq ''" role="Warning">font-family="" should be '[[ &lt;family-name&gt; | &lt;generic-family&gt; ],]* [&lt;family-name&gt; | &lt;generic-family&gt;] | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@font-selection-strategy">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">font-selection-strategy="<value-of select="."/>" should be 'auto', 'character-by-character', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'character-by-character', 'inherit'))">font-selection-strategy="<value-of select="."/>". Allowed keywords are 'auto', 'character-by-character', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">font-selection-strategy="" should be 'auto', 'character-by-character', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: font-selection-strategy="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@font-size">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">font-size="<value-of select="."/>" should be 'xx-small', 'x-small', 'small', 'medium', 'large', 'x-large', 'xx-large', 'larger', 'smaller', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('xx-small', 'x-small', 'small', 'medium', 'large', 'x-large', 'xx-large', 'larger', 'smaller', 'inherit'))">font-size="<value-of select="."/>". Allowed keywords are 'xx-small', 'x-small', 'small', 'medium', 'large', 'x-large', 'xx-large', 'larger', 'smaller', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">font-size="" should be 'xx-small', 'x-small', 'small', 'medium', 'large', 'x-large', 'xx-large', 'larger', 'smaller', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: font-size="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@font-size-adjust">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">font-size-adjust="<value-of select="."/>" should be Number, 'none', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'inherit'))">font-size-adjust="<value-of select="."/>". Allowed keywords are 'none' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">font-size-adjust="" should be Number, 'none', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: font-size-adjust="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@font-stretch">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Percent', 'Number', 'EMPTY', 'ERROR', 'Object')">font-stretch="<value-of select="."/>" should be 'normal', 'wider', 'narrower', 'ultra-condensed', 'extra-condensed', 'condensed', 'semi-condensed', 'semi-expanded', 'expanded', 'extra-expanded', 'ultra-expanded', 'inherit', Percent, or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('normal', 'wider', 'narrower', 'ultra-condensed', 'extra-condensed', 'condensed', 'semi-condensed', 'semi-expanded', 'expanded', 'extra-expanded', 'ultra-expanded', 'inherit'))">font-stretch="<value-of select="."/>". Allowed keywords are 'normal', 'wider', 'narrower', 'ultra-condensed', 'extra-condensed', 'condensed', 'semi-condensed', 'semi-expanded', 'expanded', 'extra-expanded', 'ultra-expanded', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">font-stretch="" should be 'normal', 'wider', 'narrower', 'ultra-condensed', 'extra-condensed', 'condensed', 'semi-condensed', 'semi-expanded', 'expanded', 'extra-expanded', 'ultra-expanded', 'inherit', Percent, or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: font-stretch="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@font-style">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">font-style="<value-of select="."/>" should be 'normal', 'italic', 'oblique', 'backslant', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('normal', 'italic', 'oblique', 'backslant', 'inherit'))">font-style="<value-of select="."/>". Allowed keywords are 'normal', 'italic', 'oblique', 'backslant', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">font-style="" should be 'normal', 'italic', 'oblique', 'backslant', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: font-style="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@font-variant">
      <report test=". eq ''" role="Warning">font-variant="" should be 'normal | small-caps | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@font-weight">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">font-weight="<value-of select="."/>" should be 'normal', 'bold', 'bolder', 'lighter', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('normal', 'bold', 'bolder', 'lighter', 'inherit'))">font-weight="<value-of select="."/>". Allowed keywords are 'normal', 'bold', 'bolder', 'lighter', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">font-weight="" should be 'normal', 'bold', 'bolder', 'lighter', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: font-weight="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@force-page-count">
      <report test=". eq ''" role="Warning">force-page-count="" should be 'auto | even | odd | end-on-even | end-on-odd | no-force | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@format">
      <report test=". eq ''" role="Warning">format="" should be '&lt;string&gt;'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@glyph-orientation-horizontal">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Literal', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">glyph-orientation-horizontal="<value-of select="."/>" should be Literal or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">glyph-orientation-horizontal="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">glyph-orientation-horizontal="" should be Literal or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: glyph-orientation-horizontal="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@glyph-orientation-vertical">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Literal', 'EMPTY', 'ERROR', 'Object')">glyph-orientation-vertical="<value-of select="."/>" should be 'auto', 'inherit', or Literal.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">glyph-orientation-vertical="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">glyph-orientation-vertical="" should be 'auto', 'inherit', or Literal.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: glyph-orientation-vertical="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@grouping-separator">
      <report test=". eq ''" role="Warning">grouping-separator="" should be '&lt;character&gt;'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@grouping-size">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EMPTY', 'ERROR', 'Object')">grouping-size="<value-of select="."/>" should be Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">grouping-size="" should be Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: grouping-size="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@height">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">height="<value-of select="."/>" should be Length, Percent, 'auto', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">height="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">height="" should be Length, Percent, 'auto', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: height="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@hyphenate">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">hyphenate="<value-of select="."/>" should be 'false', 'true', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('false', 'true', 'inherit'))">hyphenate="<value-of select="."/>". Allowed keywords are 'false', 'true', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">hyphenate="" should be 'false', 'true', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: hyphenate="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@hyphenation-character">
      <report test=". eq ''" role="Warning">hyphenation-character="" should be '&lt;character&gt; | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@hyphenation-keep">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">hyphenation-keep="<value-of select="."/>" should be 'auto', 'column', 'page', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'column', 'page', 'inherit'))">hyphenation-keep="<value-of select="."/>". Allowed keywords are 'auto', 'column', 'page', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">hyphenation-keep="" should be 'auto', 'column', 'page', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: hyphenation-keep="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@hyphenation-ladder-count">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">hyphenation-ladder-count="<value-of select="."/>" should be 'no-limit', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('no-limit', 'inherit'))">hyphenation-ladder-count="<value-of select="."/>". Allowed keywords are 'no-limit' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">hyphenation-ladder-count="" should be 'no-limit', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: hyphenation-ladder-count="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@hyphenation-push-character-count">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">hyphenation-push-character-count="<value-of select="."/>" should be Number or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">hyphenation-push-character-count="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">hyphenation-push-character-count="" should be Number or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: hyphenation-push-character-count="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@hyphenation-remain-character-count">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">hyphenation-remain-character-count="<value-of select="."/>" should be Number or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">hyphenation-remain-character-count="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">hyphenation-remain-character-count="" should be Number or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: hyphenation-remain-character-count="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@id">
      <report test=". eq ''" role="Warning">id="" should be '&lt;id&gt;'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@index-class">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Literal', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">index-class="<value-of select="."/>" should be Literal or EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'ERROR'">Syntax error: index-class="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@index-key">
      <report test=". eq ''" role="Warning">index-key="" should be '&lt;string&gt;'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@indicate-destination">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">indicate-destination="<value-of select="."/>" should be 'true' or 'false'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('true', 'false'))">indicate-destination="<value-of select="."/>". Allowed keywords are 'true' and 'false'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">indicate-destination="" should be 'true' or 'false'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: indicate-destination="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@initial-page-number">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">initial-page-number="<value-of select="."/>" should be 'auto', 'auto-odd', 'auto-even', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'auto-odd', 'auto-even', 'inherit'))">initial-page-number="<value-of select="."/>". Allowed keywords are 'auto', 'auto-odd', 'auto-even', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">initial-page-number="" should be 'auto', 'auto-odd', 'auto-even', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: initial-page-number="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@inline-progression-dimension">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">inline-progression-dimension="<value-of select="."/>" should be 'auto', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">inline-progression-dimension="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">inline-progression-dimension="" should be 'auto', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: inline-progression-dimension="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@internal-destination"/>

   
   
   
   
   
   <rule context="fo:*/@intrinsic-scale-value">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">intrinsic-scale-value="<value-of select="."/>" should be Percent or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">intrinsic-scale-value="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">intrinsic-scale-value="" should be Percent or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: intrinsic-scale-value="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@intrusion-displace">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">intrusion-displace="<value-of select="."/>" should be 'auto', 'none', 'line', 'indent', 'block', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'none', 'line', 'indent', 'block', 'inherit'))">intrusion-displace="<value-of select="."/>". Allowed keywords are 'auto', 'none', 'line', 'indent', 'block', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">intrusion-displace="" should be 'auto', 'none', 'line', 'indent', 'block', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: intrusion-displace="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@keep-together">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">keep-together="<value-of select="."/>" should be 'auto', 'always', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'always', 'inherit'))">keep-together="<value-of select="."/>". Allowed keywords are 'auto', 'always', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">keep-together="" should be 'auto', 'always', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: keep-together="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@keep-with-next">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">keep-with-next="<value-of select="."/>" should be 'auto', 'always', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'always', 'inherit'))">keep-with-next="<value-of select="."/>". Allowed keywords are 'auto', 'always', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">keep-with-next="" should be 'auto', 'always', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: keep-with-next="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@keep-with-previous">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">keep-with-previous="<value-of select="."/>" should be 'auto', 'always', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'always', 'inherit'))">keep-with-previous="<value-of select="."/>". Allowed keywords are 'auto', 'always', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">keep-with-previous="" should be 'auto', 'always', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: keep-with-previous="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@language">
      <report test=". eq ''" role="Warning">language="" should be 'none | &lt;language&gt; | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@last-line-end-indent">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">last-line-end-indent="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">last-line-end-indent="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">last-line-end-indent="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: last-line-end-indent="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@leader-alignment">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">leader-alignment="<value-of select="."/>" should be 'none', 'reference-area', 'page', 'start', 'center', or 'end'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'reference-area', 'page', 'start', 'center', 'end'))">leader-alignment="<value-of select="."/>". Allowed keywords are 'none', 'reference-area', 'page', 'start', 'center', and 'end'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">leader-alignment="" should be 'none', 'reference-area', 'page', 'start', 'center', or 'end'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: leader-alignment="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@leader-length">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">leader-length="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">leader-length="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">leader-length="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: leader-length="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@leader-pattern">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">leader-pattern="<value-of select="."/>" should be 'space', 'rule', 'dots', 'use-content', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('space', 'rule', 'dots', 'use-content', 'inherit'))">leader-pattern="<value-of select="."/>". Allowed keywords are 'space', 'rule', 'dots', 'use-content', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">leader-pattern="" should be 'space', 'rule', 'dots', 'use-content', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: leader-pattern="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@leader-pattern-width">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">leader-pattern-width="<value-of select="."/>" should be 'use-font-metrics', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('use-font-metrics', 'inherit'))">leader-pattern-width="<value-of select="."/>". Allowed keywords are 'use-font-metrics' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">leader-pattern-width="" should be 'use-font-metrics', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: leader-pattern-width="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@left">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">left="<value-of select="."/>" should be Length, Percent, 'auto', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">left="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">left="" should be Length, Percent, 'auto', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: left="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@letter-spacing">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">letter-spacing="<value-of select="."/>" should be 'normal', 'inherit', or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('normal', 'inherit'))">letter-spacing="<value-of select="."/>". Allowed keywords are 'normal' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">letter-spacing="" should be 'normal', 'inherit', or Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: letter-spacing="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@letter-value">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">letter-value="<value-of select="."/>" should be 'auto', 'alphabetic', or 'traditional'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'alphabetic', 'traditional'))">letter-value="<value-of select="."/>". Allowed keywords are 'auto', 'alphabetic', and 'traditional'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">letter-value="" should be 'auto', 'alphabetic', or 'traditional'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: letter-value="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@line-height">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Number', 'Percent', 'EMPTY', 'ERROR', 'Object')">line-height="<value-of select="."/>" should be 'normal', 'inherit', Length, Number, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('normal', 'inherit'))">line-height="<value-of select="."/>". Allowed keywords are 'normal' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">line-height="" should be 'normal', 'inherit', Length, Number, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: line-height="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@line-height-shift-adjustment">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">line-height-shift-adjustment="<value-of select="."/>" should be 'consider-shifts', 'disregard-shifts', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('consider-shifts', 'disregard-shifts', 'inherit'))">line-height-shift-adjustment="<value-of select="."/>". Allowed keywords are 'consider-shifts', 'disregard-shifts', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">line-height-shift-adjustment="" should be 'consider-shifts', 'disregard-shifts', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: line-height-shift-adjustment="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@line-stacking-strategy">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">line-stacking-strategy="<value-of select="."/>" should be 'line-height', 'font-height', 'max-height', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('line-height', 'font-height', 'max-height', 'inherit'))">line-stacking-strategy="<value-of select="."/>". Allowed keywords are 'line-height', 'font-height', 'max-height', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">line-stacking-strategy="" should be 'line-height', 'font-height', 'max-height', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: line-stacking-strategy="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@linefeed-treatment">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">linefeed-treatment="<value-of select="."/>" should be 'ignore', 'preserve', 'treat-as-space', 'treat-as-zero-width-space', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('ignore', 'preserve', 'treat-as-space', 'treat-as-zero-width-space', 'inherit'))">linefeed-treatment="<value-of select="."/>". Allowed keywords are 'ignore', 'preserve', 'treat-as-space', 'treat-as-zero-width-space', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">linefeed-treatment="" should be 'ignore', 'preserve', 'treat-as-space', 'treat-as-zero-width-space', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: linefeed-treatment="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@margin">
      <report test=". eq ''" role="Warning">margin="" should be '&lt;margin-width&gt;{1,4} | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@margin-bottom">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">margin-bottom="<value-of select="."/>" should be 'auto', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">margin-bottom="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">margin-bottom="" should be 'auto', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: margin-bottom="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@margin-left">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">margin-left="<value-of select="."/>" should be 'auto', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">margin-left="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">margin-left="" should be 'auto', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: margin-left="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@margin-right">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">margin-right="<value-of select="."/>" should be 'auto', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">margin-right="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">margin-right="" should be 'auto', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: margin-right="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@margin-top">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">margin-top="<value-of select="."/>" should be 'auto', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">margin-top="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">margin-top="" should be 'auto', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: margin-top="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@marker-class-name">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">marker-class-name="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">marker-class-name="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: marker-class-name="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@master-name">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">master-name="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">master-name="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: master-name="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@master-reference">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">master-reference="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">master-reference="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: master-reference="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@max-height">
      <report test=". eq ''" role="Warning">max-height="" should be '&lt;length&gt; | &lt;percentage&gt; | none | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@max-width">
      <report test=". eq ''" role="Warning">max-width="" should be '&lt;length&gt; | &lt;percentage&gt; | none | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@maximum-repeats">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">maximum-repeats="<value-of select="."/>" should be Number, 'no-limit', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('no-limit', 'inherit'))">maximum-repeats="<value-of select="."/>". Allowed keywords are 'no-limit' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">maximum-repeats="" should be Number, 'no-limit', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: maximum-repeats="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@media-usage">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">media-usage="<value-of select="."/>" should be 'auto', 'paginate', 'bounded-in-one-dimension', or 'unbounded'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'paginate', 'bounded-in-one-dimension', 'unbounded'))">media-usage="<value-of select="."/>". Allowed keywords are 'auto', 'paginate', 'bounded-in-one-dimension', and 'unbounded'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">media-usage="" should be 'auto', 'paginate', 'bounded-in-one-dimension', or 'unbounded'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: media-usage="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@merge-pages-across-index-key-references">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">merge-pages-across-index-key-references="<value-of select="."/>" should be 'merge' or 'leave-separate'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('merge', 'leave-separate'))">merge-pages-across-index-key-references="<value-of select="."/>". Allowed keywords are 'merge' and 'leave-separate'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">merge-pages-across-index-key-references="" should be 'merge' or 'leave-separate'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: merge-pages-across-index-key-references="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@merge-ranges-across-index-key-references">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">merge-ranges-across-index-key-references="<value-of select="."/>" should be 'merge' or 'leave-separate'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('merge', 'leave-separate'))">merge-ranges-across-index-key-references="<value-of select="."/>". Allowed keywords are 'merge' and 'leave-separate'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">merge-ranges-across-index-key-references="" should be 'merge' or 'leave-separate'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: merge-ranges-across-index-key-references="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@merge-sequential-page-numbers">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">merge-sequential-page-numbers="<value-of select="."/>" should be 'merge' or 'leave-separate'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('merge', 'leave-separate'))">merge-sequential-page-numbers="<value-of select="."/>". Allowed keywords are 'merge' and 'leave-separate'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">merge-sequential-page-numbers="" should be 'merge' or 'leave-separate'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: merge-sequential-page-numbers="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@min-height">
      <report test=". eq ''" role="Warning">min-height="" should be '&lt;length&gt; | &lt;percentage&gt; | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@min-width">
      <report test=". eq ''" role="Warning">min-width="" should be '&lt;length&gt; | &lt;percentage&gt; | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@number-columns-repeated">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EMPTY', 'ERROR', 'Object')">number-columns-repeated="<value-of select="."/>" should be Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">number-columns-repeated="" should be Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: number-columns-repeated="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@number-columns-spanned">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EMPTY', 'ERROR', 'Object')">number-columns-spanned="<value-of select="."/>" should be Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">number-columns-spanned="" should be Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: number-columns-spanned="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@number-rows-spanned">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EMPTY', 'ERROR', 'Object')">number-rows-spanned="<value-of select="."/>" should be Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">number-rows-spanned="" should be Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: number-rows-spanned="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@odd-or-even">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">odd-or-even="<value-of select="."/>" should be 'odd', 'even', 'odd-document', 'even-document', or 'any'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('odd', 'even', 'odd-document', 'even-document', 'any'))">odd-or-even="<value-of select="."/>". Allowed keywords are 'odd', 'even', 'odd-document', 'even-document', and 'any'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">odd-or-even="" should be 'odd', 'even', 'odd-document', 'even-document', or 'any'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: odd-or-even="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@orphans">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">orphans="<value-of select="."/>" should be Number or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">orphans="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">orphans="" should be Number or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: orphans="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@overflow">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">overflow="<value-of select="."/>" should be 'visible', 'hidden', 'scroll', 'error-if-overflow', 'repeat', 'replace', 'condense', or 'auto'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('visible', 'hidden', 'scroll', 'error-if-overflow', 'repeat', 'replace', 'condense', 'auto'))">overflow="<value-of select="."/>". Allowed keywords are 'visible', 'hidden', 'scroll', 'error-if-overflow', 'repeat', 'replace', 'condense', and 'auto'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">overflow="" should be 'visible', 'hidden', 'scroll', 'error-if-overflow', 'repeat', 'replace', 'condense', or 'auto'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: overflow="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@padding">
      <report test=". eq ''" role="Warning">padding="" should be '&lt;padding-width&gt;{1,4} | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@padding-after">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">padding-after="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">padding-after="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">padding-after="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: padding-after="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@padding-before">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">padding-before="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">padding-before="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">padding-before="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: padding-before="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@padding-bottom">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">padding-bottom="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">padding-bottom="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">padding-bottom="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: padding-bottom="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@padding-end">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">padding-end="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">padding-end="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">padding-end="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: padding-end="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@padding-left">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">padding-left="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">padding-left="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">padding-left="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: padding-left="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@padding-right">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">padding-right="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">padding-right="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">padding-right="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: padding-right="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@padding-start">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">padding-start="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">padding-start="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">padding-start="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: padding-start="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@padding-top">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">padding-top="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">padding-top="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">padding-top="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: padding-top="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@page-break-after">
      <report test=". eq ''" role="Warning">page-break-after="" should be 'auto | always | avoid | left | right | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@page-break-before">
      <report test=". eq ''" role="Warning">page-break-before="" should be 'auto | always | avoid | left | right | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@page-break-inside">
      <report test=". eq ''" role="Warning">page-break-inside="" should be 'avoid | auto | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@page-citation-strategy">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">page-citation-strategy="<value-of select="."/>" should be 'all', 'normal', 'non-blank', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('all', 'normal', 'non-blank', 'inherit'))">page-citation-strategy="<value-of select="."/>". Allowed keywords are 'all', 'normal', 'non-blank', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">page-citation-strategy="" should be 'all', 'normal', 'non-blank', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: page-citation-strategy="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@page-height">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">page-height="<value-of select="."/>" should be 'auto', 'indefinite', 'inherit', or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'indefinite', 'inherit'))">page-height="<value-of select="."/>". Allowed keywords are 'auto', 'indefinite', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">page-height="" should be 'auto', 'indefinite', 'inherit', or Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: page-height="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@page-number-treatment">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">page-number-treatment="<value-of select="."/>" should be 'link' or 'no-link'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('link', 'no-link'))">page-number-treatment="<value-of select="."/>". Allowed keywords are 'link' and 'no-link'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">page-number-treatment="" should be 'link' or 'no-link'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: page-number-treatment="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@page-position">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">page-position="<value-of select="."/>" should be 'only', 'first', 'last', 'rest', 'any', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('only', 'first', 'last', 'rest', 'any', 'inherit'))">page-position="<value-of select="."/>". Allowed keywords are 'only', 'first', 'last', 'rest', 'any', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">page-position="" should be 'only', 'first', 'last', 'rest', 'any', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: page-position="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@page-width">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">page-width="<value-of select="."/>" should be 'auto', 'indefinite', 'inherit', or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'indefinite', 'inherit'))">page-width="<value-of select="."/>". Allowed keywords are 'auto', 'indefinite', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">page-width="" should be 'auto', 'indefinite', 'inherit', or Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: page-width="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@pause">
      <report test=". eq ''" role="Warning">pause="" should be '[&lt;time&gt; | &lt;percentage&gt;]{1,2} | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@position">
      <report test=". eq ''" role="Warning">position="" should be 'static | relative | absolute | fixed | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@precedence">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">precedence="<value-of select="."/>" should be 'true', 'false', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('true', 'false', 'inherit'))">precedence="<value-of select="."/>". Allowed keywords are 'true', 'false', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">precedence="" should be 'true', 'false', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: precedence="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@provisional-distance-between-starts">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">provisional-distance-between-starts="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">provisional-distance-between-starts="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">provisional-distance-between-starts="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: provisional-distance-between-starts="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@provisional-label-separation">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">provisional-label-separation="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">provisional-label-separation="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">provisional-label-separation="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: provisional-label-separation="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@ref-id">
      <report test=". eq ''" role="Warning">ref-id="" should be '&lt;idref&gt; | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@ref-index-key">
      <report test=". eq ''" role="Warning">ref-index-key="" should be '&lt;string&gt;'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@reference-orientation">
      <report test=". eq ''" role="Warning">reference-orientation="" should be '0 | 90 | 180 | 270 | -90 | -180 | -270 | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@region-name">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">region-name="<value-of select="."/>" should be 'xsl-region-body', 'xsl-region-start', 'xsl-region-end', 'xsl-region-before', or 'xsl-region-after'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">region-name="" should be 'xsl-region-body', 'xsl-region-start', 'xsl-region-end', 'xsl-region-before', or 'xsl-region-after'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: region-name="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@region-name-reference">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">region-name-reference="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">region-name-reference="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: region-name-reference="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@relative-align">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">relative-align="<value-of select="."/>" should be 'before', 'baseline', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('before', 'baseline', 'inherit'))">relative-align="<value-of select="."/>". Allowed keywords are 'before', 'baseline', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">relative-align="" should be 'before', 'baseline', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: relative-align="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@relative-position">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">relative-position="<value-of select="."/>" should be 'static', 'relative', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('static', 'relative', 'inherit'))">relative-position="<value-of select="."/>". Allowed keywords are 'static', 'relative', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">relative-position="" should be 'static', 'relative', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: relative-position="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@rendering-intent">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">rendering-intent="<value-of select="."/>" should be 'auto', 'perceptual', 'relative-colorimetric', 'saturation', 'absolute-colorimetric', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'perceptual', 'relative-colorimetric', 'saturation', 'absolute-colorimetric', 'inherit'))">rendering-intent="<value-of select="."/>". Allowed keywords are 'auto', 'perceptual', 'relative-colorimetric', 'saturation', 'absolute-colorimetric', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">rendering-intent="" should be 'auto', 'perceptual', 'relative-colorimetric', 'saturation', 'absolute-colorimetric', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: rendering-intent="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@retrieve-boundary">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">retrieve-boundary="<value-of select="."/>" should be 'page', 'page-sequence', or 'document'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('page', 'page-sequence', 'document'))">retrieve-boundary="<value-of select="."/>". Allowed keywords are 'page', 'page-sequence', and 'document'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">retrieve-boundary="" should be 'page', 'page-sequence', or 'document'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: retrieve-boundary="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@retrieve-boundary-within-table">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">retrieve-boundary-within-table="<value-of select="."/>" should be 'table', 'table-fragment', or 'page'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('table', 'table-fragment', 'page'))">retrieve-boundary-within-table="<value-of select="."/>". Allowed keywords are 'table', 'table-fragment', and 'page'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">retrieve-boundary-within-table="" should be 'table', 'table-fragment', or 'page'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: retrieve-boundary-within-table="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@retrieve-class-name">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">retrieve-class-name="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">retrieve-class-name="" should be EnumerationToken.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: retrieve-class-name="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@retrieve-position">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">retrieve-position="<value-of select="."/>" should be 'first-starting-within-page', 'first-including-carryover', 'last-starting-within-page', or 'last-ending-within-page'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('first-starting-within-page', 'first-including-carryover', 'last-starting-within-page', 'last-ending-within-page'))">retrieve-position="<value-of select="."/>". Allowed keywords are 'first-starting-within-page', 'first-including-carryover', 'last-starting-within-page', and 'last-ending-within-page'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">retrieve-position="" should be 'first-starting-within-page', 'first-including-carryover', 'last-starting-within-page', or 'last-ending-within-page'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: retrieve-position="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@retrieve-position-within-table">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">retrieve-position-within-table="<value-of select="."/>" should be 'first-starting', 'first-including-carryover', 'last-starting', or 'last-ending'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('first-starting', 'first-including-carryover', 'last-starting', 'last-ending'))">retrieve-position-within-table="<value-of select="."/>". Allowed keywords are 'first-starting', 'first-including-carryover', 'last-starting', and 'last-ending'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">retrieve-position-within-table="" should be 'first-starting', 'first-including-carryover', 'last-starting', or 'last-ending'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: retrieve-position-within-table="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@right">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">right="<value-of select="."/>" should be Length, Percent, 'auto', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">right="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">right="" should be Length, Percent, 'auto', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: right="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@role">
      <report test=". eq ''" role="Warning">role="" should be '&lt;string&gt; | &lt;uri-specification&gt; | none | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@rule-style">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">rule-style="<value-of select="."/>" should be 'none', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', 'inherit'))">rule-style="<value-of select="."/>". Allowed keywords are 'none', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">rule-style="" should be 'none', 'dotted', 'dashed', 'solid', 'double', 'groove', 'ridge', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: rule-style="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@rule-thickness">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">rule-thickness="<value-of select="."/>" should be Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">rule-thickness="" should be Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: rule-thickness="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@scale-option">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">scale-option="<value-of select="."/>" should be 'width', 'height', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('width', 'height', 'inherit'))">scale-option="<value-of select="."/>". Allowed keywords are 'width', 'height', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">scale-option="" should be 'width', 'height', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: scale-option="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@scaling">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">scaling="<value-of select="."/>" should be 'uniform', 'non-uniform', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('uniform', 'non-uniform', 'inherit'))">scaling="<value-of select="."/>". Allowed keywords are 'uniform', 'non-uniform', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">scaling="" should be 'uniform', 'non-uniform', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: scaling="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@scaling-method">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">scaling-method="<value-of select="."/>" should be 'auto', 'integer-pixels', 'resample-any-method', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'integer-pixels', 'resample-any-method', 'inherit'))">scaling-method="<value-of select="."/>". Allowed keywords are 'auto', 'integer-pixels', 'resample-any-method', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">scaling-method="" should be 'auto', 'integer-pixels', 'resample-any-method', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: scaling-method="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@score-spaces">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">score-spaces="<value-of select="."/>" should be 'true', 'false', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('true', 'false', 'inherit'))">score-spaces="<value-of select="."/>". Allowed keywords are 'true', 'false', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">score-spaces="" should be 'true', 'false', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: score-spaces="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@script">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Literal', 'EMPTY', 'ERROR', 'Object')">script="<value-of select="."/>" should be 'none', 'auto', 'inherit', or Literal.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'auto', 'inherit'))">script="<value-of select="."/>". Allowed keywords are 'none', 'auto', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">script="" should be 'none', 'auto', 'inherit', or Literal.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: script="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@show-destination">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">show-destination="<value-of select="."/>" should be 'replace' or 'new'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('replace', 'new'))">show-destination="<value-of select="."/>". Allowed keywords are 'replace' and 'new'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">show-destination="" should be 'replace' or 'new'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: show-destination="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@size">
      <report test=". eq ''" role="Warning">size="" should be '&lt;length&gt;{1,2} | auto | landscape | portrait | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@source-document">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('URI', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">source-document="<value-of select="."/>" should be URI, 'none', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">source-document="" should be URI, 'none', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: source-document="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@space-after">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">space-after="<value-of select="."/>" should be Length or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">space-after="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">space-after="" should be Length or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: space-after="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@space-before">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">space-before="<value-of select="."/>" should be Length or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">space-before="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">space-before="" should be Length or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: space-before="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@space-end">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">space-end="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">space-end="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">space-end="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: space-end="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@space-start">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">space-start="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">space-start="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">space-start="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: space-start="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@span">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">span="<value-of select="."/>" should be 'none', 'all', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'all', 'inherit'))">span="<value-of select="."/>". Allowed keywords are 'none', 'all', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">span="" should be 'none', 'all', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: span="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@src">
      <report test=". eq ''" role="Warning">src="" should be '&lt;uri-specification&gt; | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@start-indent">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">start-indent="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">start-indent="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">start-indent="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: start-indent="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@starting-state">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">starting-state="<value-of select="."/>" should be 'show' or 'hide'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('show', 'hide'))">starting-state="<value-of select="."/>". Allowed keywords are 'show' and 'hide'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">starting-state="" should be 'show' or 'hide'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: starting-state="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@starts-row">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">starts-row="<value-of select="."/>" should be 'true' or 'false'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('true', 'false'))">starts-row="<value-of select="."/>". Allowed keywords are 'true' and 'false'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">starts-row="" should be 'true' or 'false'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: starts-row="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@suppress-at-line-break">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">suppress-at-line-break="<value-of select="."/>" should be 'auto', 'suppress', 'retain', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'suppress', 'retain', 'inherit'))">suppress-at-line-break="<value-of select="."/>". Allowed keywords are 'auto', 'suppress', 'retain', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">suppress-at-line-break="" should be 'auto', 'suppress', 'retain', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: suppress-at-line-break="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@switch-to">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">switch-to="<value-of select="."/>" should be 'xsl-preceding', 'xsl-following', or 'xsl-any'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">switch-to="" should be 'xsl-preceding', 'xsl-following', or 'xsl-any'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: switch-to="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@table-layout">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">table-layout="<value-of select="."/>" should be 'auto', 'fixed', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'fixed', 'inherit'))">table-layout="<value-of select="."/>". Allowed keywords are 'auto', 'fixed', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">table-layout="" should be 'auto', 'fixed', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: table-layout="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@table-omit-footer-at-break">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">table-omit-footer-at-break="<value-of select="."/>" should be 'true' or 'false'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('true', 'false'))">table-omit-footer-at-break="<value-of select="."/>". Allowed keywords are 'true' and 'false'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">table-omit-footer-at-break="" should be 'true' or 'false'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: table-omit-footer-at-break="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@table-omit-header-at-break">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">table-omit-header-at-break="<value-of select="."/>" should be 'true' or 'false'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('true', 'false'))">table-omit-header-at-break="<value-of select="."/>". Allowed keywords are 'true' and 'false'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">table-omit-header-at-break="" should be 'true' or 'false'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: table-omit-header-at-break="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@target-presentation-context">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'URI', 'EMPTY', 'ERROR', 'Object')">target-presentation-context="<value-of select="."/>" should be 'use-target-processing-context' or URI.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">target-presentation-context="" should be 'use-target-processing-context' or URI.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: target-presentation-context="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@target-processing-context">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'URI', 'EMPTY', 'ERROR', 'Object')">target-processing-context="<value-of select="."/>" should be 'document-root' or URI.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">target-processing-context="" should be 'document-root' or URI.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: target-processing-context="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@target-stylesheet">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'URI', 'EMPTY', 'ERROR', 'Object')">target-stylesheet="<value-of select="."/>" should be 'use-normal-stylesheet' or URI.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">target-stylesheet="" should be 'use-normal-stylesheet' or URI.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: target-stylesheet="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@text-align">
      <report test=". eq ''" role="Warning">text-align="" should be 'start | center | end | justify | inside | outside | left | right | &lt;string&gt; | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@text-align-last">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">text-align-last="<value-of select="."/>" should be 'relative', 'start', 'center', 'end', 'justify', 'inside', 'outside', 'left', 'right', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('relative', 'start', 'center', 'end', 'justify', 'inside', 'outside', 'left', 'right', 'inherit'))">text-align-last="<value-of select="."/>". Allowed keywords are 'relative', 'start', 'center', 'end', 'justify', 'inside', 'outside', 'left', 'right', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">text-align-last="" should be 'relative', 'start', 'center', 'end', 'justify', 'inside', 'outside', 'left', 'right', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: text-align-last="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@text-altitude">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">text-altitude="<value-of select="."/>" should be 'use-font-metrics', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('use-font-metrics', 'inherit'))">text-altitude="<value-of select="."/>". Allowed keywords are 'use-font-metrics' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">text-altitude="" should be 'use-font-metrics', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: text-altitude="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@text-decoration">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">text-decoration="<value-of select="."/>" should be 'none', 'underline', 'no-underline]', 'overline', 'no-overline', 'line-through', 'no-line-through', 'blink', 'no-blink', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'underline', 'no-underline]', 'overline', 'no-overline', 'line-through', 'no-line-through', 'blink', 'no-blink', 'inherit'))">text-decoration="<value-of select="."/>". Allowed keywords are 'none', 'underline', 'no-underline]', 'overline', 'no-overline', 'line-through', 'no-line-through', 'blink', 'no-blink', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">text-decoration="" should be 'none', 'underline', 'no-underline]', 'overline', 'no-overline', 'line-through', 'no-line-through', 'blink', 'no-blink', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: text-decoration="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@text-depth">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">text-depth="<value-of select="."/>" should be 'use-font-metrics', 'inherit', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('use-font-metrics', 'inherit'))">text-depth="<value-of select="."/>". Allowed keywords are 'use-font-metrics' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">text-depth="" should be 'use-font-metrics', 'inherit', Length, or Percent.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: text-depth="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@text-indent">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">text-indent="<value-of select="."/>" should be Length, Percent, or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">text-indent="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">text-indent="" should be Length, Percent, or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: text-indent="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@text-shadow">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Color', 'Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">text-shadow="<value-of select="."/>" should be 'none', 'inherit', Color, or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'inherit'))">text-shadow="<value-of select="."/>". Allowed keywords are 'none' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">text-shadow="" should be 'none', 'inherit', Color, or Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: text-shadow="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@text-transform">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">text-transform="<value-of select="."/>" should be 'capitalize', 'uppercase', 'lowercase', 'none', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('capitalize', 'uppercase', 'lowercase', 'none', 'inherit'))">text-transform="<value-of select="."/>". Allowed keywords are 'capitalize', 'uppercase', 'lowercase', 'none', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">text-transform="" should be 'capitalize', 'uppercase', 'lowercase', 'none', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: text-transform="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@top">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">top="<value-of select="."/>" should be Length, Percent, 'auto', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">top="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">top="" should be Length, Percent, 'auto', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: top="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@treat-as-word-space">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">treat-as-word-space="<value-of select="."/>" should be 'auto', 'true', 'false', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'true', 'false', 'inherit'))">treat-as-word-space="<value-of select="."/>". Allowed keywords are 'auto', 'true', 'false', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">treat-as-word-space="" should be 'auto', 'true', 'false', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: treat-as-word-space="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@unicode-bidi">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">unicode-bidi="<value-of select="."/>" should be 'normal', 'embed', 'bidi-override', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('normal', 'embed', 'bidi-override', 'inherit'))">unicode-bidi="<value-of select="."/>". Allowed keywords are 'normal', 'embed', 'bidi-override', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">unicode-bidi="" should be 'normal', 'embed', 'bidi-override', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: unicode-bidi="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@vertical-align">
      <report test=". eq ''" role="Warning">vertical-align="" should be 'baseline | middle | sub | super | text-top | text-bottom | &lt;percentage&gt; | &lt;length&gt; | top | bottom | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@visibility">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">visibility="<value-of select="."/>" should be 'visible', 'hidden', 'collapse', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('visible', 'hidden', 'collapse', 'inherit'))">visibility="<value-of select="."/>". Allowed keywords are 'visible', 'hidden', 'collapse', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">visibility="" should be 'visible', 'hidden', 'collapse', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: visibility="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@white-space">
      <report test=". eq ''" role="Warning">white-space="" should be 'normal | pre | nowrap | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@white-space-collapse">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">white-space-collapse="<value-of select="."/>" should be 'false', 'true', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('false', 'true', 'inherit'))">white-space-collapse="<value-of select="."/>". Allowed keywords are 'false', 'true', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">white-space-collapse="" should be 'false', 'true', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: white-space-collapse="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@white-space-treatment">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">white-space-treatment="<value-of select="."/>" should be 'ignore', 'preserve', 'ignore-if-before-linefeed', 'ignore-if-after-linefeed', 'ignore-if-surrounding-linefeed', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('ignore', 'preserve', 'ignore-if-before-linefeed', 'ignore-if-after-linefeed', 'ignore-if-surrounding-linefeed', 'inherit'))">white-space-treatment="<value-of select="."/>". Allowed keywords are 'ignore', 'preserve', 'ignore-if-before-linefeed', 'ignore-if-after-linefeed', 'ignore-if-surrounding-linefeed', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">white-space-treatment="" should be 'ignore', 'preserve', 'ignore-if-before-linefeed', 'ignore-if-after-linefeed', 'ignore-if-surrounding-linefeed', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: white-space-treatment="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@widows">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Number', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">widows="<value-of select="."/>" should be Number or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('inherit'))">widows="<value-of select="."/>". Allowed keywords are 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">widows="" should be Number or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: widows="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@width">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('Length', 'Percent', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">width="<value-of select="."/>" should be Length, Percent, 'auto', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">width="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">width="" should be Length, Percent, 'auto', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: width="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@word-spacing">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">word-spacing="<value-of select="."/>" should be 'normal', 'inherit', or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('normal', 'inherit'))">word-spacing="<value-of select="."/>". Allowed keywords are 'normal' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">word-spacing="" should be 'normal', 'inherit', or Length.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: word-spacing="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@wrap-option">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">wrap-option="<value-of select="."/>" should be 'no-wrap', 'wrap', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('no-wrap', 'wrap', 'inherit'))">wrap-option="<value-of select="."/>". Allowed keywords are 'no-wrap', 'wrap', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">wrap-option="" should be 'no-wrap', 'wrap', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: wrap-option="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@writing-mode">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">writing-mode="<value-of select="."/>" should be 'lr-tb', 'rl-tb', 'tb-rl', 'tb-lr', 'bt-lr', 'bt-rl', 'lr-bt', 'rl-bt', 'lr-alternating-rl-bt', 'lr-alternating-rl-tb', 'lr-inverting-rl-bt', 'lr-inverting-rl-tb', 'tb-lr-in-lr-pairs', 'lr', 'rl', 'tb', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('lr-tb', 'rl-tb', 'tb-rl', 'tb-lr', 'bt-lr', 'bt-rl', 'lr-bt', 'rl-bt', 'lr-alternating-rl-bt', 'lr-alternating-rl-tb', 'lr-inverting-rl-bt', 'lr-inverting-rl-tb', 'tb-lr-in-lr-pairs', 'lr', 'rl', 'tb', 'inherit'))">writing-mode="<value-of select="."/>". Allowed keywords are 'lr-tb', 'rl-tb', 'tb-rl', 'tb-lr', 'bt-lr', 'bt-rl', 'lr-bt', 'rl-bt', 'lr-alternating-rl-bt', 'lr-alternating-rl-tb', 'lr-inverting-rl-bt', 'lr-inverting-rl-tb', 'tb-lr-in-lr-pairs', 'lr', 'rl', 'tb', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">writing-mode="" should be 'lr-tb', 'rl-tb', 'tb-rl', 'tb-lr', 'bt-lr', 'bt-rl', 'lr-bt', 'rl-bt', 'lr-alternating-rl-bt', 'lr-alternating-rl-tb', 'lr-inverting-rl-bt', 'lr-inverting-rl-tb', 'tb-lr-in-lr-pairs', 'lr', 'rl', 'tb', or 'inherit'.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: writing-mode="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@xml.lang">
      <report test=". eq ''" role="Warning">xml.lang="" should be '&lt;language-country&gt; | inherit'.</report>
   </rule>

   
   
   
   
   
   <rule context="fo:*/@z-index">
      <let name="expression" value="ahf:parser-runner(.)"/>
      <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR', 'Object')">z-index="<value-of select="."/>" should be 'auto', 'inherit', or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
      <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'inherit'))">z-index="<value-of select="."/>". Allowed keywords are 'auto' and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
      <report test="local-name($expression) = 'EMPTY'" role="Warning">z-index="" should be 'auto', 'inherit', or Number.</report>
      <report test="local-name($expression) = 'ERROR'">Syntax error: z-index="<value-of select="."/>":: <value-of select="$expression"/>
      </report>
   </rule>
</pattern>
    <pattern id="axf-fo">

	
	
        <rule context="axf:custom-property">
	  <assert test="empty((../../axf:document-info, ../axf:document-info)[@name eq 'xmp'])" role="Warning"><value-of select="name()"/>" is ignored when axf:document-info with name="xmp" is present.</assert>
          <assert test="normalize-space(@name) ne ''" role="Warning">name="" should not be empty.</assert>
          <assert test="not(normalize-space(@name) = ('Title', 'Author', 'Subject', 'Keywords', 'Creator', 'Producer', 'CreationDate', 'ModDate', 'Trapped'))">name="<value-of select="@name"/>" cannot be used with <value-of select="name()"/>.</assert>
          <assert test="normalize-space(@value) ne ''" role="Warning">value="" should not be empty.</assert>
        </rule>

	
	
        <rule context="axf:document-info[@name = ('author-title', 'description-writer', 'copyright-status', 'copyright-notice', 'copyright-info-url')]" id="axf-1">
	  <assert test="empty(../axf:document-info[@name eq 'xmp'])" role="Warning">name="<value-of select="@name"/>" is ignored when axf:document-info with name="xmp" is present.</assert>
        </rule>
        <rule context="axf:document-info[@name = 'title']">
	  <assert test="false()" id="axf-3f" sqf:fix="axf-3fix" role="Warning">name="<value-of select="@name"/>" is deprecated.  Please use name="document-title".</assert>
          <sqf:fix id="axf-3fix">
	    <sqf:description>
              <sqf:title>Change the 'title' axf:document-info into 'document-title'</sqf:title>
            </sqf:description>
            <sqf:replace match="@name" node-type="attribute" target="name" select="'document-title'"/>
          </sqf:fix>
        </rule>
</pattern>
    <pattern id="axf-property">

	
	
	
	
	<rule context="fo:*/@axf:annotation-color">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Color', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">axf:annotation-color="<value-of select="."/>" should be Color or 'none'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">annotation-color="" should be Color or 'none'.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: annotation-color="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:annotation-contents">
	  <assert test="normalize-space(../@axf:annotation-type) = ('Text', 'FreeText', 'Stamp', 'FileAttachment') or local-name(..) = 'basic-link'" role="Warning"><value-of select="name(.)"/> should be used only when @axf:annotation-type is 'Text', 'FreeText', 'Stamp', or 'FileAnnotation' or on fo:basic-link.</assert>
	</rule>

	
	
	
	<rule context="fo:*/@axf:assumed-page-number">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Number', 'ERROR', 'Object')">'axf:assumed-page-number should be Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: 'assumed-page-number="<value-of select="."/>"'</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:background-color">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Color', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">axf:background-color="<value-of select="."/>" should be Color or EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name(.)"/>="" should be Color or EnumerationToken.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name(.)"/>="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:background-content-height">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object')">content-height="<value-of select="."/>" should be EnumerationToken, Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', 'inherit'))">content-height="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', or 'inherit'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">content-height="" should be EnumerationToken, Length, or Percent.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: content-height="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:background-content-type">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Literal', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">content-type="<value-of select="."/>" should be Literal or EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))">content-type="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">content-type="" should be Literal or EnumerationToken.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: content-type="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:background-content-width">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object')">content-width="<value-of select="."/>" should be EnumerationToken, Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', 'inherit'))">content-width="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto', 'scale-to-fit', 'scale-down-to-fit', 'scale-up-to-fit', or 'inherit'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">content-width="" should be EnumerationToken, Length, or Percent.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: content-width="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:background-image">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('URI', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">background-image="<value-of select="."/>" should be URI or EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'inherit'))">background-image="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'none' or 'inherit'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">background-image="" should be URI or EnumerationToken.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: background-image="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@background-position">
	  <report test=". eq ''" role="Warning">background-position="" should be '[ [&lt;percentage&gt; | &lt;length&gt; ]{1,2} | [ [top | center | bottom] || [left | center | right] ] ] | inherit'.</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:background-position-horizontal">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Percent', 'Length', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">background-position-horizontal="<value-of select="."/>" should be Percent, Length, or EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('left', 'center', 'right', 'inherit'))">background-position-horizontal="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'left', 'center', 'right', or 'inherit'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">background-position-horizontal="" should be Percent, Length, or EnumerationToken.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: background-position-horizontal="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:background-position-vertical">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Percent', 'Length', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">background-position-vertical="<value-of select="."/>" should be Percent, Length, or EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('top', 'center', 'bottom', 'inherit'))">background-position-vertical="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'top', 'center', or 'bottom'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">background-position-vertical="" should be Percent, Length, or EnumerationToken.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: background-position-vertical="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:background-repeat">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">background-repeat="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('repeat', 'repeat-x', 'repeat-y', 'no-repeat', 'paginate'))">background-repeat="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'repeat', 'repeat-x', 'repeat-y', 'no-repeat', or 'paginate'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">background-repeat="" should be EnumerationToken.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: background-repeat="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:baseline-block-snap">
	  <assert test="exists(../@axf:baseline-grid) and normalize-space(../@axf:baseline-grid) = ('new', 'none')" role="Warning">axf:baseline-block-snap applies only when axf:baseline-grid is 'new' or 'none'.</assert>
	</rule>

	
	
	
	<rule context="fo:*/@axf:outline-color">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Color', 'EnumerationToken', 'ERROR', 'Object')">'axf:outline-color' should be Color or a color name.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: 'axf:outline-color="<value-of select="."/>"'</report>
	</rule>

	
	
	
	<rule context="fo:*/@axf:float">
	  <let name="tokens" value="tokenize(normalize-space(.), '\s+')"/>
	  <assert test="every $token in $tokens satisfies matches($token, '^(after|alternate|auto|auto-move|auto-next|before|bottom|center|column|end|inside|keep|keep-float|left|multicol|next|none|normal|outside|page|right|skip|start|top|wrap)$')">Every token in 'axf:float' should be 'after', 'alternate', 'auto', 'auto-move', 'auto-next', 'before', 'bottom', 'center', 'column', 'end', 'inside', 'keep', 'keep-float', 'left', 'multicol', 'next', 'none', 'normal', 'outside', 'page', 'right', 'skip', 'start', 'top' or 'wrap'.  Value is '<value-of select="."/>'.</assert>
	  <assert test="every $token in $tokens satisfies count($tokens[. eq $token]) = 1">Tokens in 'axf:float' must not be repeated.  Value is '<value-of select="."/>'.</assert>
	</rule>

	
	
	
	<rule context="fo:*/@axf:outline-level">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Number', 'ERROR', 'Object')">'axf:outline-level should be Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: 'outline-level="<value-of select="."/>"'</report>
	</rule>

	
	
	<rule context="fo:*/@axf:background-content-height | fo:*/@axf:background-content-width">
	  <report test="true()" role="Warning"><value-of select="name(.)"/> should not be used with AH Formatter V6.6 or later.  Use axf:background-size with AH Formatter V6.6 or later.</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:background-scaling">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">scaling="<value-of select="."/>" should be EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('uniform', 'non-uniform', 'inherit'))"><value-of select="name(.)"/>="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'uniform', 'non-uniform', or 'inherit'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">scaling="" should be EnumerationToken.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: scaling="<value-of select="."/>"</report>
	</rule>

	
	
	
	<rule context="fo:*/@axf:column-rule-color">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Color', 'EnumerationToken', 'ERROR', 'Object')">'axf:column-rule-color' should be Color or a color name.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: 'axf:column-rule-color="<value-of select="."/>"'</report>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:column-rule-length">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">axf:column-rule-length="<value-of select="."/>" should be Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">axf:column-rule-length="" should be Length, or Percent.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: axf:column-rule-length="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	
	
	
	
	<rule context="fo:*/@axf:field-button-icon |          fo:*/@axf:field-button-icon-down |          fo:*/@axf:field-button-icon-rollover">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('URI', 'EMPTY', 'ERROR', 'Object')">field-button-icon="<value-of select="."/>" should be URI.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="local-name(.)"/>="" should be URI.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="local-name(.)"/>="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:field-font-size">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY')">axf:field-font-size="<value-of select="."/>" should be EnumerationToken or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('font-size', 'auto'))">axf:field-font-size="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'font-size' or 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">axf:field-font-size="" should be EnumerationToken or Length.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: axf:field-font-size="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:hyphenation-zone">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY')">axf:hyphenation-zone="<value-of select="."/>" should be EnumerationToken or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none'))">axf:hyphenation-zone="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'none'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">axf:hyphenation-zone="" should be EnumerationToken or Length.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: axf:hyphenation-zone="<value-of select="."/>"</report>
	  <report test="local-name($expression) = 'Length' and    (exists($expression/@is-positive) and $expression/@is-positive eq 'no' or    $expression/@is-zero = 'yes')" id="axf.hyphenation-zone" role="Warning" sqf:fix="axf.hyphenation-zone-fix">axf:hyphenation-zone="<value-of select="."/>" should be a positive length.</report>
	  <sqf:fix id="axf.hyphenation-zone-fix">
	    <sqf:description>
              <sqf:title>Change the @axf:hyphenation-zone value to 'none'</sqf:title>
	    </sqf:description>
	    <sqf:replace node-type="attribute" target="axf:hyphenation-zone" select="'none'"/>
	  </sqf:fix>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:indent-here">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY')">axf:indent-here="<value-of select="."/>" should be EnumerationToken or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none'))">axf:indent-here="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'none'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">axf:indent-here="" should be EnumerationToken or Length.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: axf:indent-here="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:keep-together-within-dimension">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY')">axf:keep-together-within-dimension="<value-of select="."/>" should be EnumerationToken or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))">axf:keep-together-within-dimension="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">axf:keep-together-within-dimension="" should be EnumerationToken or Length.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: axf:keep-together-within-dimension="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:line-number-background-color">
	  <extends rule="color-transparent"/>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:line-number-color">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Color', 'EMPTY', 'ERROR')"><value-of select="name(.)"/>="<value-of select="."/>" should be a Color or a color name.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name(.)"/>="" should be a Color or a color name.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name(.)"/>="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:line-number-font-size">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'Percent', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">axf:line-number-font-size="<value-of select="."/>" should be 'xx-small', 'x-small', 'small', 'medium', 'large', 'x-large', 'xx-large', 'larger', 'smaller', Length, or Percent.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('xx-small', 'x-small', 'small', 'medium', 'large', 'x-large', 'xx-large', 'larger', 'smaller'))">axf:line-number-font-size="<value-of select="."/>". Allowed keywords are 'xx-small', 'x-small', 'small', 'medium', 'large', 'x-large', 'xx-large', 'larger', and 'smaller'. Token is '<value-of select="$expression/@token"/>'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">axf:line-number-font-size="" should be 'xx-small', 'x-small', 'small', 'medium', 'large', 'x-large', 'xx-large', 'larger', 'smaller', Length, or Percent.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: axf:line-number-font-size="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:line-number-initial">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR')"><value-of select="name(.)"/>="<value-of select="."/>" should be EnumerationToken or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))"><value-of select="name(.)"/>="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name(.)"/>="" should be EnumerationToken or Number.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name(.)"/>="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:line-number-interval">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR')"><value-of select="name(.)"/>="<value-of select="."/>" should be EnumerationToken or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))"><value-of select="name(.)"/>="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name(.)"/>="" should be EnumerationToken or Number.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name(.)"/>="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:line-number-offset">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Length', 'EMPTY', 'ERROR')">axf:line-number-offset="<value-of select="."/>" should be Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">axf:line-number-offset="" should be Length.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: axf:line-number-offset="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:line-number-start">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR')"><value-of select="name(.)"/>="<value-of select="."/>" should be EnumerationToken or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))"><value-of select="name(.)"/>="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name(.)"/>="" should be EnumerationToken or Number.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name(.)"/>="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@text-decoration">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'EMPTY', 'ERROR', 'Object')">text-decoration="<value-of select="."/>" should be 'none', 'underline', 'no-underline]', 'overline', 'no-overline', 'line-through', 'no-line-through', 'blink', 'no-blink', or 'inherit'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'underline', 'no-underline]', 'overline', 'no-overline', 'line-through', 'no-line-through', 'blink', 'no-blink', 'inherit'))">text-decoration="<value-of select="."/>". Allowed keywords are 'none', 'underline', 'no-underline]', 'overline', 'no-overline', 'line-through', 'no-line-through', 'blink', 'no-blink', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">text-decoration="" should be 'none', 'underline', 'no-underline]', 'overline', 'no-overline', 'line-through', 'no-line-through', 'blink', 'no-blink', or 'inherit'.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: text-decoration="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:line-number-width">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY', 'ERROR')"><value-of select="name(.)"/>="<value-of select="."/>" should be EnumerationToken or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))"><value-of select="name(.)"/>="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name(.)"/>="" should be EnumerationToken or Length.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name(.)"/>="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:media-duration">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR')"><value-of select="name(.)"/>="<value-of select="."/>" should be EnumerationToken or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('intrinsic', 'infinity'))"><value-of select="name(.)"/>="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'intrinsic' or 'infinity'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name(.)"/>="" should be EnumerationToken or Number.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name(.)"/>="<value-of select="."/>"</report>
	  <report test="../@axf:media-play-mode = 'once'" role="Warning"><value-of select="name(.)"/> is invalid when axf:media-play-mode="once" is specified.</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:media-play-mode">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Number', 'EMPTY', 'ERROR')"><value-of select="name(.)"/>="<value-of select="."/>" should be EnumerationToken or Number.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('once', 'continuously'))"><value-of select="name(.)"/>="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'once' or 'continuously'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name(.)"/>="" should be EnumerationToken or Number.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name(.)"/>="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:media-skin-color">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Color', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">axf:media-skin-color="<value-of select="."/>" should be Color or 'auto'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))"><value-of select="name(.)"/>="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">media-skin-color="" should be Color or 'auto'.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: media-skin-color="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:media-volume">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Percent', 'Number', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">media-volume="<value-of select="."/>" should be Percent, Number, or EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))">media-volume="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name(.)"/>="" should be Percent, Number, or EnumerationToken.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: media-volume="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	
	
	<rule context="fo:*/@axf:media-window-height |          fo:*/@axf:media-window-width">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY', 'ERROR')"><value-of select="name(.)"/>="<value-of select="."/>" should be EnumerationToken or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))"><value-of select="name(.)"/>="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning"><value-of select="name(.)"/>="" should be EnumerationToken or Length.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: <value-of select="name(.)"/>="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:page-number-prefix">
	  <report test="true()" sqf:fix="axf_page-number-prefix_fix" role="Warning">axf:page-number-prefix: A similar function is provided in XSL 1.1. Please use fo:folio-prefix.</report>
          <sqf:fix id="axf_page-number-prefix_fix">
	    <sqf:description>
              <sqf:title>Change @axf:page-number-prefix into fo:folio-prefix.</sqf:title>
            </sqf:description>
            <sqf:add node-type="element" target="fo:folio-prefix">
	      <value-of select="."/>
	    </sqf:add>
	    <sqf:delete/>
          </sqf:fix>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:poster-content-type">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Literal', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">content-type="<value-of select="."/>" should be Literal or EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))">content-type="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">content-type="" should be Literal or EnumerationToken.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: content-type="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:poster-image">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('URI', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">poster-image="<value-of select="."/>" should be URI or EnumerationToken.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('none', 'auto'))">poster-image="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'none' or 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">poster-image="" should be URI or EnumerationToken.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: poster-image="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:revision-bar-color">
	  <report test="true()" sqf:fix="axf_revision-bar-color_fix" role="Warning">axf:revision-bar-color: A similar function is provided in XSL 1.1. Please use fo:change-bar-begin and fo:change-bar-end.</report>
          <sqf:fix id="axf_revision-bar-color_fix">
	    <sqf:description>
              <sqf:title>Delete @axf:revision-bar-color.</sqf:title>
            </sqf:description>
	    <sqf:delete/>
          </sqf:fix>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:revision-bar-offset">
	  <report test="true()" sqf:fix="axf_revision-bar-offset_fix" role="Warning">axf:revision-bar-offset: A similar function is provided in XSL 1.1. Please use fo:change-bar-begin and fo:change-bar-end.</report>
          <sqf:fix id="axf_revision-bar-offset_fix">
	    <sqf:description>
              <sqf:title>Delete @axf:revision-bar-offset.</sqf:title>
            </sqf:description>
	    <sqf:delete/>
          </sqf:fix>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:revision-bar-position">
	  <report test="true()" sqf:fix="axf_revision-bar-position_fix" role="Warning">axf:revision-bar-position: A similar function is provided in XSL 1.1. Please use fo:change-bar-begin and fo:change-bar-end.</report>
          <sqf:fix id="axf_revision-bar-position_fix">
	    <sqf:description>
              <sqf:title>Delete @axf:revision-bar-position.</sqf:title>
            </sqf:description>
	    <sqf:delete/>
          </sqf:fix>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:revision-bar-style">
	  <report test="true()" sqf:fix="axf_revision-bar-style_fix" role="Warning">axf:revision-bar-style: A similar function is provided in XSL 1.1. Please use fo:change-bar-begin and fo:change-bar-end.</report>
          <sqf:fix id="axf_revision-bar-style_fix">
	    <sqf:description>
              <sqf:title>Delete @axf:revision-bar-style.</sqf:title>
            </sqf:description>
	    <sqf:delete/>
          </sqf:fix>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:revision-bar-width">
	  <report test="true()" sqf:fix="axf_revision-bar-width_fix" role="Warning">axf:revision-bar-width: A similar function is provided in XSL 1.1. Please use fo:change-bar-begin and fo:change-bar-end.</report>
          <sqf:fix id="axf_revision-bar-width_fix">
	    <sqf:description>
              <sqf:title>Delete @axf:revision-bar-width.</sqf:title>
            </sqf:description>
	    <sqf:delete/>
          </sqf:fix>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:suppress-duplicate-page-number">
	  <report test="true()" sqf:fix="axf_suppress-duplicate-page-number_fix" role="Warning">axf:suppress-duplicate-page-number: A similar function is provided in XSL 1.1. Please use merge-*-index-key-references.</report>
          <sqf:fix id="axf_suppress-duplicate-page-number_fix">
	    <sqf:description>
              <sqf:title>Delete @axf:suppress-duplicate-page-number.</sqf:title>
            </sqf:description>
	    <sqf:delete/>
          </sqf:fix>
	</rule>

	
	
	
	
	<rule context="fo:*/@axf:text-line-color">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('Color', 'EnumerationToken', 'EMPTY', 'ERROR', 'Object')">axf:text-line-color="<value-of select="."/>" should be Color or 'auto'.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto'))"><value-of select="name(.)"/>="<value-of select="."/>" enumeration token is '<value-of select="$expression/@token"/>'.  Token should be 'auto'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">text-line-color="" should be Color or 'auto'.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: text-line-color="<value-of select="."/>"</report>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:text-line-style">
	  <extends rule="border-style"/>
	</rule>

	
	
	
	
	
	<rule context="fo:*/@axf:text-line-width">
	  <let name="expression" value="ahf:parser-runner(.)"/>
	  <assert test="local-name($expression) = ('EnumerationToken', 'Length', 'EMPTY', 'ERROR', 'Object') or $expression/@value = '0'">axf:text-line-width="<value-of select="."/>" should be 'auto', 'thin', 'medium', 'thick', 'inherit', or Length.  '<value-of select="."/>' is a <value-of select="local-name($expression)"/>.</assert>
	  <report test="$expression instance of element(EnumerationToken) and not($expression/@token = ('auto', 'thin', 'medium', 'thick', 'inherit'))">axf:text-line-width="<value-of select="."/>". Allowed keywords are 'auto', 'thin', 'medium', 'thick', and 'inherit'. Token is '<value-of select="$expression/@token"/>'.</report>
	  <report test="local-name($expression) = 'EMPTY'" role="Warning">axf:text-line-width="" should be 'auto', 'thin', 'medium', 'thick', 'inherit', or Length.</report>
	  <report test="local-name($expression) = 'ERROR'">Syntax error: axf:text-line-width="<value-of select="."/>"</report>
	</rule>

	
	
	
	<rule context="fo:*/@overflow">
	  <report test=". = ('replace', 'condense') and not(local-name(..) = ('block-container', 'inline-container'))">overflow="<value-of select="."/>" applies only on fo:block-container or fo:inline-container.</report>
	</rule>

</pattern>

    <ns uri="http://www.w3.org/1999/XSL/Format" prefix="fo"/>
    <ns uri="http://www.antennahouse.com/names/XSLT/Functions/Document" prefix="ahf"/>
    <ns uri="http://www.antennahouse.com/names/XSL/Extensions" prefix="axf"/>

    <phase id="fo">
        <active pattern="fo-fo"/>
    </phase>
    <phase id="property">
        <active pattern="fo-property"/>
    </phase>
    <phase id="axf">
        <active pattern="axf-fo"/>
    </phase>
    <phase id="axf-prop">
        <active pattern="axf-property"/>
    </phase>
</schema>
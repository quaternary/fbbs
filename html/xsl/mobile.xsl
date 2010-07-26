<?xml version='1.0' encoding='gb18030'?>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns='http://www.w3.org/1999/xhtml'>
<xsl:import href='showpost.xsl'/>
<xsl:output method='html' encoding='gb18030' doctype-public='-//W3C//DTD HTML 4.01//EN' doctype-system='http://www.w3.org/TR/html4/strict.dtd'/>

<xsl:template name='bbsname'>���¹⻪</xsl:template>

<xsl:template name='timeconvert'>
	<xsl:param name='time'/>
	<xsl:value-of select='concat(substring($time, 1, 10), " ", substring($time, 12, 5))'/>
</xsl:template>

<xsl:template name='time-conv-short'>
	<xsl:param name='time'/>
	<xsl:value-of select='concat(substring($time, 6, 5), " ", substring($time, 12, 5))'/>
</xsl:template>

<xsl:template name='navigation'>
	<xsl:param name='session'/>
	<xsl:variable name='user' select='$session/u'/>
	<xsl:variable name='bbsname'><xsl:call-template name='bbsname'/></xsl:variable>
	<div id='hd'>
		<xsl:if test='$user != ""'><a><xsl:attribute name='href'>qry?u=<xsl:value-of select='$user'/></xsl:attribute><xsl:value-of select='$user'/></a>|</xsl:if>
		<xsl:if test='$user = ""'><a href='login'>��¼</a>|</xsl:if>
		<a href='0an'>����</a>|<a href='top10'>ʮ��</a><xsl:if test='contains($session/p, "l")'>|<a href='mail'>�ż�</a>|<a href='logout'>ע��</a></xsl:if>
	</div>
	<div id='fav'>�ղ� <xsl:for-each select='$session/f/b'><xsl:sort select='translate(., "abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")' order='ascending'/>
	<a><xsl:attribute name='href'>tdoc?<xsl:choose><xsl:when test='@bid'><xsl:value-of select='@bid'/></xsl:when><xsl:otherwise>board=<xsl:value-of select='.'/></xsl:otherwise></xsl:choose></xsl:attribute><xsl:value-of select='.'/></a>
	</xsl:for-each></div>
</xsl:template>

<xsl:template name='foot'>
	<div id='ft'><xsl:call-template name='bbsname'/> &#169;1996-2010</div>
</xsl:template>

<xsl:template name='include-css'>
	<link rel='stylesheet' type='text/css' href='../css/mobile.css'/>
</xsl:template>

<xsl:template name='include-js'>
</xsl:template>

<xsl:template name='page-title'>
	<xsl:variable name='cgi' select='local-name(node()[2])'/>
	<xsl:choose>
		<xsl:when test='bbssec'>�Ƽ�����</xsl:when>
		<xsl:when test='bbsboa'><xsl:choose><xsl:when test='bbsboa/@dir'>����Ŀ¼</xsl:when><xsl:otherwise>����������</xsl:otherwise></xsl:choose></xsl:when>
		<xsl:when test='bbsall'>ȫ��������</xsl:when>
		<xsl:when test='bbssel'>ѡ��������</xsl:when>
		<xsl:when test='bbsdoc'><xsl:value-of select='bbsdoc/brd/@desc'/></xsl:when>
		<xsl:when test='bbscon'>�����Ķ�</xsl:when>
		<xsl:when test='bbstcon'>ͬ���������Ķ�</xsl:when>
		<xsl:when test='bbsqry'>��ѯ����</xsl:when>
		<xsl:when test='bbspst'><xsl:choose><xsl:when test='bbspst/@edit="0"'>����</xsl:when><xsl:otherwise>�޸�</xsl:otherwise></xsl:choose>����</xsl:when>
		<xsl:when test='bbstop10'>����ʮ��</xsl:when>
		<xsl:when test='bbsbfind'>�������²�ѯ</xsl:when>
		<xsl:when test='bbsnewmail'>�������ż�</xsl:when>
		<xsl:when test='bbsmail'>�ż��б�</xsl:when>
		<xsl:when test='bbsmailcon'>�ż��Ķ�</xsl:when>
		<xsl:when test='bbspstmail'>�����Ÿ�</xsl:when>
		<xsl:when test='bbs0an'>���������</xsl:when>
		<xsl:when test='bbsanc'>�����������Ķ�</xsl:when>
		<xsl:when test='bbsfwd'>ת������</xsl:when>
		<xsl:when test='bbsccc'>ת������</xsl:when>
		<xsl:when test='bbsfall'>�趨��ע����</xsl:when>
		<xsl:when test='bbsfadd'>���ӹ�ע����</xsl:when>
		<xsl:when test='bbsovr'>���߹�ע����</xsl:when>
		<xsl:when test='bbsfav'>�ղؼ�</xsl:when>
		<xsl:when test='bbsmybrd'>�趨�ղؼ�</xsl:when>
		<xsl:when test='bbseufile'><xsl:value-of select='bbseufile/@desc'/></xsl:when>
		<xsl:when test='bbsmybrd'>��������</xsl:when>
		<xsl:when test='bbspwd'>�޸�����</xsl:when>
		<xsl:when test='bbsnot'>���滭��</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match='/'>
	<html>
		<head>
			<title><xsl:call-template name='page-title'/> - <xsl:call-template name='bbsname'/></title>
			<meta http-equiv="content-type" content="text/html; charset=gb18030"/>
			<xsl:call-template name='include-css'/>
			<xsl:call-template name='include-js'/>
		</head>
		<body>
			<a name='top'/>
			<xsl:call-template name='navigation'><xsl:with-param name='session' select='node()[2]/session'/></xsl:call-template>
			<div id='main'><xsl:apply-templates/></div>
			<xsl:call-template name='foot'/>
		</body>
	</html>
</xsl:template>

<xsl:template match='bbssec'>
	<xsl:for-each select='sec'>
		<ul class='sec'>
			<li><a><xsl:attribute name='href'>boa?s=<xsl:value-of select='@id'/></xsl:attribute><xsl:value-of select='@id'/>&#160;<xsl:value-of select='@desc'/></a></li>
			<ul class='brd'>
				<xsl:for-each select='brd'>
					<li><a><xsl:attribute name='href'>doc?board=<xsl:value-of select='@name'/></xsl:attribute><xsl:value-of select='@desc'/></a></li>
				</xsl:for-each>
			</ul>
		</ul>
	</xsl:for-each>
</xsl:template>

<xsl:template match='bbsdoc'>
	<h2><a><xsl:attribute name='href'><xsl:value-of select='brd/@link'/>doc?bid=<xsl:value-of select='brd/@bid'/></xsl:attribute><xsl:value-of select='brd/@desc'/>[<xsl:value-of select='brd/@title'/>]<xsl:if test='brd/@link = "g"'>[��ժ]</xsl:if><xsl:if test='brd/@link = "t"'>[����]</xsl:if></a></h2>
	<div class='nav'>
		<a><xsl:attribute name='href'>pst?bid=<xsl:value-of select='brd/@bid'/></xsl:attribute>[����]</a>
		<a href='javascript:location=location'>[ˢ��]</a>
		<xsl:if test='brd/@start > 1'>
			<xsl:variable name='prev'><xsl:choose><xsl:when test='brd/@start - brd/@page &lt; 1'>1</xsl:when><xsl:otherwise><xsl:value-of select='brd/@start - brd/@page'/></xsl:otherwise></xsl:choose></xsl:variable>
			<a><xsl:attribute name='href'><xsl:value-of select='brd/@link'/>doc?bid=<xsl:value-of select='brd/@bid'/>&amp;start=<xsl:value-of select='$prev'/></xsl:attribute>[��ҳ]</a>
		</xsl:if>
		<xsl:if test='brd/@total > brd/@start + brd/@page - 1'>
			<xsl:variable name='next'><xsl:value-of select='brd/@start + brd/@page'/></xsl:variable>
			<a><xsl:attribute name='href'><xsl:value-of select='brd/@link'/>doc?bid=<xsl:value-of select='brd/@bid'/>&amp;start=<xsl:value-of select='$next'/></xsl:attribute>[��ҳ]</a>
		</xsl:if>
		<a><xsl:attribute name='href'>clear?board=<xsl:value-of select='brd/@title'/>&amp;start=<xsl:value-of select='brd/@start'/></xsl:attribute>[���δ��]</a>
		<a><xsl:attribute name='href'>0an?bid=<xsl:value-of select='brd/@bid'/></xsl:attribute>[����]</a>
	</div>
	<ul class='po'>
		<xsl:for-each select='po'><xsl:sort select='@time' order='descending'/><xsl:if test='not(@sticky)'><li>
			<p><a>
				<xsl:attribute name='href'><xsl:value-of select='../brd/@link'/>con?bid=<xsl:value-of select='../brd/@bid'/>&amp;f=<xsl:value-of select='@id'/></xsl:attribute>
				<xsl:variable name='text'><xsl:choose><xsl:when test='substring(., 1, 4) = "Re: "'><xsl:value-of select='substring(., 5)'/></xsl:when><xsl:otherwise><xsl:value-of select='.'/></xsl:otherwise></xsl:choose></xsl:variable>
				<xsl:if test='substring(., 1, 4) = "Re: "'>Re: </xsl:if>
				<xsl:call-template name='ansi-escape'>
					<xsl:with-param name='content'><xsl:value-of select='$text'/></xsl:with-param>
					<xsl:with-param name='fgcolor'>37</xsl:with-param>
					<xsl:with-param name='bgcolor'>ignore</xsl:with-param>
					<xsl:with-param name='ishl'>0</xsl:with-param>
				</xsl:call-template>
			</a></p><p><a class='owner'><xsl:attribute name='href'>qry?u=<xsl:value-of select='@owner'/></xsl:attribute><xsl:value-of select='@owner'/></a><xsl:text> </xsl:text><span class='time'><xsl:call-template name='time-conv-short'><xsl:with-param name='time' select='@time'/></xsl:call-template></span></p>
		</li></xsl:if></xsl:for-each>
	</ul>
</xsl:template>

<xsl:template match='brd'>

</xsl:template>

<xsl:template match='bbscon'>
<div class='post'>
	<div class='pmain'><xsl:call-template name='simple-post'><xsl:with-param name='content' select='po'/></xsl:call-template></div>
	<div class='plink'>
		<xsl:variable name='param'>bid=<xsl:value-of select='@bid'/>&amp;f=<xsl:value-of select='po/@fid'/></xsl:variable>
		<xsl:if test='@link = "con"'><a><xsl:attribute name='href'>pst?<xsl:value-of select='$param'/></xsl:attribute>[�ظ�]</a></xsl:if>
		<a><xsl:attribute name='href'>edit?<xsl:value-of select='$param'/></xsl:attribute>[�޸�]</a>
	</div>
	<div class='nav'>
		<xsl:variable name='baseurl'>con?bid=<xsl:value-of select='@bid'/>&amp;f=<xsl:value-of select='po/@fid'/>&amp;a=</xsl:variable>
		<xsl:if test='not(po/@sticky)'><a><xsl:attribute name='href'><xsl:value-of select='$baseurl'/>p</xsl:attribute>[��ƪ]</a>
		<a><xsl:attribute name='href'><xsl:value-of select='$baseurl'/>n</xsl:attribute>[��ƪ]</a>
		<xsl:if test='po/@reid != f'><a><xsl:attribute name='href'><xsl:value-of select='$baseurl'/>b</xsl:attribute>[ͬ����]</a></xsl:if>
		<a><xsl:attribute name='href'><xsl:value-of select='$baseurl'/>a</xsl:attribute>[ͬ����]</a>
		<xsl:if test='po/@gid'><a><xsl:attribute name='href'>con?bid=<xsl:value-of select='@bid'/>&amp;f=<xsl:value-of select='po/@gid'/></xsl:attribute>[ͬ����]</a></xsl:if>
		<xsl:variable name='gid'><xsl:choose><xsl:when test='po/@gid'><xsl:value-of select='po/@gid'/></xsl:when><xsl:otherwise><xsl:value-of select='po/@fid'/></xsl:otherwise></xsl:choose></xsl:variable>
		<a><xsl:attribute name='href'>tcon?bid=<xsl:value-of select='@bid'/>&amp;f=<xsl:value-of select='$gid'/></xsl:attribute>[չ��]</a>
		<a><xsl:attribute name='href'>tcon?bid=<xsl:value-of select='@bid'/>&amp;g=<xsl:value-of select='$gid'/>&amp;f=<xsl:value-of select='po/@fid'/>&amp;a=n</xsl:attribute>[��չ]</a></xsl:if>
	</div>
</div>
</xsl:template>

<xsl:template match='bbstcon'>
	<xsl:for-each select='po'>
		<div class='post'>
			<div class='pmain'><xsl:call-template name='simple-post'><xsl:with-param name='content' select='.'/></xsl:call-template></div>
			<div class='nav'>
				<xsl:variable name='first'><xsl:value-of select='../po[1]/@fid'/></xsl:variable>
				<xsl:variable name='last'><xsl:value-of select='../po[last()]/@fid'/></xsl:variable>
				<xsl:if test='count(../po) = ../@page'><a><xsl:attribute name='href'>tcon?bid=<xsl:value-of select='../@bid'/>&amp;g=<xsl:value-of select='../@gid'/>&amp;f=<xsl:value-of select='$last'/>&amp;a=n</xsl:attribute>[��һҳ]</a></xsl:if>
				<xsl:if test='$first != ../@gid'><a><xsl:attribute name='href'>tcon?bid=<xsl:value-of select='../@bid'/>&amp;g=<xsl:value-of select='../@gid'/>&amp;f=<xsl:value-of select='$first'/>&amp;a=p</xsl:attribute>[��һҳ]</a></xsl:if>
				<a><xsl:attribute name='href'>pst?bid=<xsl:value-of select='../@bid'/>&amp;f=<xsl:value-of select='@fid'/></xsl:attribute>[�ظ�]</a>
				<a><xsl:attribute name='href'>ccc?bid=<xsl:value-of select='../@bid'/>&amp;f=<xsl:value-of select='@fid'/></xsl:attribute>[ת��]</a>
				<a><xsl:attribute name='href'>tdoc?bid=<xsl:value-of select='../@bid'/></xsl:attribute>[����]</a>
				<a><xsl:attribute name='href'>con?bid=<xsl:value-of select='../@bid'/>&amp;f=<xsl:value-of select='@fid'/></xsl:attribute>[����]</a>
				<a><xsl:attribute name='href'>gdoc?bid=<xsl:value-of select='../@bid'/></xsl:attribute>[��ժ]</a>
				<a><xsl:attribute name='href'>qry?u=<xsl:value-of select='@owner'/></xsl:attribute>[����: <xsl:value-of select='@owner'/>]</a>
			</div>
		</div>
	</xsl:for-each>
</xsl:template>

<xsl:template match='bbsboa'>
	<h2><xsl:value-of select='@title'/></h2>
	<ul><xsl:for-each select='brd'><xsl:sort select='@title'/><li class='brd'>
		<a><xsl:choose>
			<xsl:when test='@dir="1"'><xsl:attribute name='href'>boa?board=<xsl:value-of select='@title'/></xsl:attribute></xsl:when>
			<xsl:otherwise><xsl:attribute name='href'>doc?board=<xsl:value-of select='@title'/></xsl:attribute></xsl:otherwise>
		</xsl:choose>
		<xsl:choose><xsl:when test='@read="0"'>��</xsl:when><xsl:otherwise>��</xsl:otherwise></xsl:choose>
		<xsl:choose><xsl:when test='@dir="1"'>[Ŀ¼]</xsl:when><xsl:otherwise><xsl:value-of select='@cate'/></xsl:otherwise></xsl:choose>
		<xsl:value-of select='@desc'/></a><span class='tt'>[<xsl:value-of select='@title'/>]</span>
	</li></xsl:for-each></ul>
</xsl:template>

<xsl:template match='bbspst'>
	<p>���棺<xsl:value-of select='@brd'/></p>
	<form id='postform' name='postform' method='post'>
		<xsl:attribute name='action'>snd?bid=<xsl:value-of select='@bid'/>&amp;f=<xsl:value-of select='po/@f'/>&amp;e=<xsl:value-of select='@edit'/></xsl:attribute>
		<input type='hidden' id='brd'><xsl:attribute name='value'><xsl:value-of select='@brd'/></xsl:attribute></input>
		<p>���⣺<xsl:choose>
		<xsl:when test='@edit=0'><input class='binput' type='text' name='title' size='27' maxlength='50'>
			<xsl:variable name='retitle'>
				<xsl:choose>
					<xsl:when test='substring(t, 1, 4) = "Re: "'><xsl:value-of select='t'/></xsl:when>
					<xsl:when test='not(t)'></xsl:when>
					<xsl:otherwise><xsl:value-of select='concat("Re: ", t)'/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:attribute name='value'>
				<xsl:call-template name='remove-ansi'>
					<xsl:with-param name='str' select='$retitle'/>
				</xsl:call-template>
			</xsl:attribute>
		</input></xsl:when>
		<xsl:otherwise><xsl:call-template name='remove-ansi'><xsl:with-param name='str' select='t'/></xsl:call-template></xsl:otherwise>
		</xsl:choose></p>
		<p>ǩ����: <input type='radio' name='sig' value='1' checked='checked'/>1 <input type='radio' name='sig' value='2'/>2 <input type='radio' name='sig' value='3'/>3 <input type='radio' name='sig' value='4'/>4 <input type='radio' name='sig' value='5'/>5 <input type='radio' name='sig' value='6'/>6</p>
		<p><textarea class='binput' name='text' rows='10' cols='27' wrap='virtual'>
			<xsl:if test='@edit=0'><xsl:text> &#x0d;&#x0a;</xsl:text></xsl:if>
			<xsl:call-template name='show-quoted'>
				<xsl:with-param name='content' select='po'/>
			</xsl:call-template>
		</textarea></p>
		<input type='submit' value='����' id='btnPost' size='10'/>
		<input type='reset' value='��ԭ' size='10'/>
		<xsl:if test='@edit="0" and @att!=0'><input type='button' name='attach' value='�ϴ�����' onclick='return preUpload() '/></xsl:if>
	</form>
	<xsl:choose>
		<xsl:when test='not(t)'><script type='text/javascript' defer='defer'>addLoadEvent(function(){document.postform.title.focus();})</script></xsl:when>
		<xsl:otherwise><script type='text/javascript' defer='defer'>addLoadEvent(function() {var text = document.postform.text; text.selectionStart = 0; text.selectionEnd = 1; text.focus();})</script></xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
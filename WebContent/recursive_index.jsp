<%@ page import="java.awt.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();
    String projectName = request.getServerName();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    String ref = request.getHeader("REFERER");
%>
<c:set var="webRoot" value="<%=basePath%>"/>
<c:choose>
    <c:when test="${level==1 }">
        <ul class="nav nav-second-level collapse">
        <c:set var="level" value="0" scope="request"></c:set>
    </c:when>
    <c:otherwise>
        <ul class="nav nav-third-level collapse">
    </c:otherwise>
</c:choose>
<c:forEach items="${dataList }" var="data3">
    <li>
        <c:choose>
        <c:when test="${data3.getList('children').isEmpty() }">
        <c:if test="${data3.getString('functionValue')!=null && not empty data3.getString('functionValue')}">
            <c:choose>
                <c:when test="${fn:indexOf(data3.getString('functionValue'), 'javascript:') !=-1}">
                    <a class="" href="${data3.getString('functionValue') }">
                </c:when>
                <c:otherwise>
                    <a class="J_menuItem" href="${webRoot}/${data3.getString('functionValue') }">
                </c:otherwise>
             </c:choose>
        </c:if>
        <c:if test="${data3.getString('functionValue')==null ||empty data3.getString('functionValue')}">
            <a class="J_menuItem" href="${webRoot}/empty.jsp">
        </c:if>
                <span style="display: block;" data-i18n-text="${data3.getString('functionName') }">
							<img src="<%=request.getContextPath()%>/resource/images/right-arrow.png"
                                 style="height: 9px; width: 9px;">
					<c:out value="${data3.getString('functionName') }"></c:out>
                </span>
            </a>
            </c:when>
            <c:otherwise>
            <a href="${data3.getString('functionValue') }" data-i18n-text="${data3.getString('functionName') }">
                <c:out value="${data3.getString('functionName') }"></c:out>
                <span class="fa arrow"></span></a>
            </c:otherwise>
            </c:choose>
            <c:if test="${!(data3.getList('children').isEmpty()) }">
                <c:set var="dataList" value="${data3.getList('children') }" scope="request"/>
                <c:import url="recursive_index.jsp"/>
            </c:if>
    </li>
</c:forEach>
</ul>
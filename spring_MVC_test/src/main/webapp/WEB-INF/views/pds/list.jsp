<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="pdsList" value="${dataMap.pdsList }" />


<head>
<style>
	table th,td{
		text-align:center;
	}
	
</style>
</head>

<body>
   <div class="content-wrapper" >
    <!-- Content Header (Page header) -->
    <section class="content-header">
    	<div class="container-fluid">
    		<div class="row mb-2">
    			<div class="col-sm-6">
	      			<h1>자료실</h1>
	      		</div>	      		
	       		<div class="col-sm-6">
			      <ol class="breadcrumb float-sm-right">
			        <li class="breadcrumb-item"><a href="list.do"><i class="fa fa-dashboard"></i>자료실</a></li>
			        <li class="breadcrumb-item active">리스트</li>		        
			      </ol>
		      	</div>
	     	</div>	     	
      	</div>
    </section>

    <!-- Main content -->
    <section class="content">
		<div class="card">
			<div class="card-header with-border">
				<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow('registForm.do','상세보기',800,700);">자료등록</button>
				<div id="keyword" class="card-tools" style="width:450px;">	
					<div class="input-group row">
						<select class="form-control col-md-3" name="perPageNum" id="perPageNum" onchange="list_go();">
							<option value="10" >정렬개수</option>
					  		<option value="20" ${cri.perPageNum == 20 ? 'selected':''}>20개씩</option>
					  		<option value="50" ${cri.perPageNum == 50 ? 'selected':''}>50개씩</option>
					  		<option value="100" ${cri.perPageNum == 100 ? 'selected':''}>100개씩</option>
						</select>
						<select class="form-control col-md-4" name="searchType" id="searchType">
							<option value="tcw"  ${cri.searchType eq 'tcw' ? 'selected':'' }>전 체</option>
							<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>제 목</option>
							<option value="w" ${cri.searchType eq 'w' ? 'selected':'' }>작성자</option>
							<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>내 용</option>
							<option value="tc" ${cri.searchType eq 'tc' ? 'selected':'' }>제목+내용</option>
							<option value="cw" ${cri.searchType eq 'cw' ? 'selected':'' }>작성자+내용</option>							
							<option value="tcw" ${cri.searchType eq 'tcw' ? 'selected':'' }>작성자+제목+내용</option>
						</select>
										
					<input  class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요." value="${pageMaker.cri.keyword }"/>
						<span class="input-group-append">
							<button class="btn btn-primary" type="button" id="searchBtn" onclick="list_go(1);" 
							data-card-widget="search">
								<i class="fa fa-fw fa-search"></i>
							</button>
						</span>
					</div>						
				</div>			
			</div>
			<div class="card-body">
				<table class="table table-bordered text-center">
					<tr style="font-size:0.95em;">
						<th style="width:10%;">번 호</th>
						<th style="width:50%;">제 목</th>
						<th style="width:5%;">첨부파일</th>
						<th style="width:15%;">작성자</th>
						<th>등록일</th>
						<th style="width:10%;">조회수</th>
					</tr>	
					<c:forEach items="${pdsList }" var="pds">
					<tr>
						<td>${pds.pno }</td>
						<td id="boardTitle" style="text-align:left;max-width: 100px; overflow: hidden; 
												white-space: nowrap; text-overflow: ellipsis;">
						<a href="javascript:OpenWindow('detail.do?pno=${pds.pno }','상세보기',800,700);">
						<span class="col-sm-12">${pds.title }</span>
						</a>
						</td>
							<c:if test="${empty pds.attachList }" >
								<td>X</td>
							</c:if>
							<c:if test="${!empty pds.attachList }" >
								<td><i class="nav-icon fas fa-file"></i></td>
							</c:if>
						<td>${pds.writer }</td>
						<td><fmt:formatDate value="${pds.regDate }" pattern="yyyy-MM-dd"/></td>
						<td>${pds.viewcnt }</td>					
					</tr>
					</c:forEach>	
			</table>				
			</div>
			<div class="card-footer">
				<%@ include file="/WEB-INF/views/common/pagination.jsp" %>				
			</div>
		</div>
    </section>
    <!-- /.content -->
    </div>
</body>






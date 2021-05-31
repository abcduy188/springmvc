<%@include file="/common/taglib.jsp"%>
<c:url var="APIurl" value="/api/product" />
<c:url var="newURL" value="/quan-tri/danh-sach-san-pham" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Danh sách Danh mục</title>
</head>

<body>
	<div class="main-content">
		<form action="<c:url value='/quan-tri/danh-sach-san-pham'/>"
			id="formSubmit" method="get">
			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Trang
								chủ</a></li>
					</ul>
					<!-- /.breadcrumb -->
				</div>
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<c:if test="${not empty message}">
									<div class="alert alert-${alert}">
			  							${message}
									</div>
								</c:if>
							<div class="widget-box table-filter">
								<div class="table-btn-controls">
									<div class="pull-right tableTools-container">
										<div class="dt-buttons btn-overlap btn-group">
											<c:url var="createNewURL"
												value="/quan-tri/san-pham/chinh-sua" />
											<a flag="info"
												class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Thêm bài viết'
												href='${createNewURL}'> <span> <i
													class="fa fa-plus-circle bigger-110 purple"></i>
											</span>
											</a>
											<button id="btnDelete" type="button" onclick="warningBeforeDelete()"
														class="dt-button buttons-html5 btn btn-white btn-primary btn-bold" data-toggle="tooltip" title='Xóa bài viết'>
																<span>
																	<i class="fa fa-trash-o bigger-110 pink"></i>
																</span>
												</button>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>
												<tr>
													<th><input type="checkbox" id="checkAll"></th>
													<th>Tên sản phẩm</th>
													<th>Mô tả</th>
													<th>Hình ảnh</th>
													<th>Mã danh mục</th>
													<th>Tác vụ</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${model.listResult}">

													<tr>
														<td><input type="checkbox" id="checkbox_${item.id}"
															value="${item.id}"></td>
														<td>${item.tensp}</td>
														<td>${item.mota}</td>
														<td><img
															src="<c:url value='/template/img/${item.hinhanh}'/>"
															alt="${item.hinhanh}" height="20px" width="20px"></td>
														<td>${item.categoryCode}</td>
														<td><c:url var="updateNewURL"
																value="/quan-tri/san-pham/chinh-sua">
																<c:param name="id" value="${item.id}" />
															</c:url> <a class="btn btn-sm btn-primary btn-edit"
															data-toggle="tooltip" title="Cập nhật bài viết"
															href='${updateNewURL}'><i
																class="fa fa-pencil-square-o" aria-hidden="true"></i> </a></td>
													</tr>

												</c:forEach>
											</tbody>
										</table>
										<ul class="pagination" id="pagination"></ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		function warningBeforeDelete() {
			swal({
				title: "Xóa sản phẩm?",
				  text: "Bạn có chắc muốn xóa sản phẩm?",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
			}).then(function(isConfirmed) {
						if (isConfirmed) {
							var ids = $('tbody input[type=checkbox]:checked')
									.map(function() {
										return $(this).val();
									}).get();
							deleteProduct(ids);
						}else {
						    swal("Đã hủy thao tác!");
						}
					});
			
		}
		function deleteProduct(data) {
	        $.ajax({
	            url: '${APIurl}',
	            type: 'DELETE',
	            contentType: 'application/json',
	            data: JSON.stringify(data),
	            success: function (result) {
	                window.location.href = "${newURL}?&message=delete_success";
	            },
	            error: function (error) {
	            	window.location.href = "${newURL}?&message=error_system";
	            }
	        });
	    }
	</script>
</body>

</html>
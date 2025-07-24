package controller;

import dao.InsuranceDAO;
import dao.InsTypeDAO;
import entity.Insurance;
import entity.User;
import entity.CarType;
import entity.InsuranceType;
import java.io.IOException;
import java.sql.Date;
import java.util.Vector;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "InsuranceServlet", urlPatterns = {"/insurance"})
public class InsuranceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        InsuranceDAO dao = new InsuranceDAO();
        InsTypeDAO insTypeDAO = new InsTypeDAO();

        String service = request.getParameter("service");
        if (service == null) {
            service = "listInsurance";
        }

        // Lấy user hiện tại từ session
        User currentUser = (User) request.getSession().getAttribute("user");
        if (currentUser == null) {
            // Nếu chưa đăng nhập, chuyển hướng sang trang login
            response.sendRedirect("login.jsp");
            return;
        }
        String role = currentUser.getUserRole();

        // Chỉ manager mới được thêm/sửa/xóa
        boolean canEdit ="manager".equals(role);

        // Hiển thị danh sách bảo hiểm (phân trang)
        if (service.equals("listInsurance")) {
            String keyword = request.getParameter("keyword");
            int page = 1;
            int pageSize = 5;
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            Vector<Insurance> list;
            int totalRecords = 0;
            if (keyword != null && !keyword.trim().isEmpty() && canEdit) {
                // Tìm kiếm theo tên user hoặc loại xe (chỉ admin, manager, maketing)
                list = dao.searchInsuranceByUserOrCarType(keyword.trim());
                totalRecords = list.size();
                page = 1; // Khi tìm kiếm, chỉ hiển thị trang đầu
            } else if (canEdit) {
                // Nếu có quyền, lấy toàn bộ danh sách bảo hiểm
                totalRecords = dao.getTotalInsuranceCount();
                list = dao.getInsuranceByPage(page, pageSize);
            } else {
                // Nếu là user thường, chỉ lấy bảo hiểm của user đó
                list = dao.getInsuranceByUserId(currentUser.getId());
                totalRecords = list.size();
            }
            int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);

            // Truyền thêm danh sách user, car type, insurance type sang JSP
            request.setAttribute("userList", dao.getAllUsers());
            request.setAttribute("carTypeList", dao.getAllCarTypes());
            request.setAttribute("insType", insTypeDAO.getAllInsuranceTypes());

            request.setAttribute("data", list);
            request.setAttribute("role", role);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("Insurance/Insurance.jsp").forward(request, response);
            // Thêm mới bảo hiểm
        } else if (service.equals("addInsurance")) {
            if (!canEdit) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thêm bảo hiểm.");
                return;
            }
            String submit = request.getParameter("submit");
            if (submit == null) {
                // Hiển thị form thêm mới
                Vector<User> userList = dao.getUsersByRole("customer");
                Vector<CarType> carTypeList = dao.getAllCarTypes();
                Vector<InsuranceType> insTypeList = insTypeDAO.getAllInsuranceTypes();
                request.setAttribute("userList", userList);
                request.setAttribute("carType", carTypeList);
                request.setAttribute("insType", insTypeList);
                request.setAttribute("role", role);
                request.getRequestDispatcher("Insurance/addInsurance.jsp").forward(request, response);
            } else {
                // Xử lý dữ liệu gửi lên từ form
                int userId = Integer.parseInt(request.getParameter("userId"));
                int carTypeId = Integer.parseInt(request.getParameter("carTypeId"));
                int insuranceTypeId = Integer.parseInt(request.getParameter("insuranceTypeId"));
                Date startDate = Date.valueOf(request.getParameter("startDate"));
                Date endDate = Date.valueOf(request.getParameter("endDate"));
                //Kiểm tra endDate phải sau startDate
                if (!endDate.after(startDate)) {
                    request.setAttribute("error", "Ngày kết thúc phải sau ngày bắt đầu.");

                    // Lấy lại danh sách để hiển thị form
                    Vector<User> userList = dao.getUsersByRole("customer");
                    Vector<CarType> carTypeList = dao.getAllCarTypes();
                    Vector<InsuranceType> insTypeList = insTypeDAO.getAllInsuranceTypes();
                    request.setAttribute("userList", userList);
                    request.setAttribute("carType", carTypeList);
                    request.setAttribute("insType", insTypeList);
                    request.setAttribute("role", role);

                    // Gửi lại dữ liệu người dùng đã nhập (tùy chọn)
                    request.setAttribute("selectedUserId", userId);
                    request.setAttribute("selectedCarTypeId", carTypeId);
                    request.setAttribute("selectedInsuranceTypeId", insuranceTypeId);
                    request.setAttribute("startDate", startDate.toString());
                    request.setAttribute("endDate", endDate.toString());

                    request.getRequestDispatcher("Insurance/addInsurance.jsp").forward(request, response);
                    return;
                }
                // Tạo đối tượng Insurance và thêm vào database
                Insurance i = new Insurance(userId, carTypeId, insuranceTypeId, startDate, endDate);
                dao.addInsurance(i);
                
                //NOTIFICATION ADD INSURANCE
                

                // Sau khi thêm, hiển thị lại danh sách bảo hiểm
                int page = 1;
                int pageSize = 5;
                int totalRecords = dao.getTotalInsuranceCount();
                int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);
                Vector<Insurance> list = dao.getInsuranceByPage(page, pageSize);

                request.setAttribute("userList", dao.getAllUsers());
                request.setAttribute("carTypeList", dao.getAllCarTypes());
                request.setAttribute("insType", insTypeDAO.getAllInsuranceTypes());

                request.setAttribute("data", list);
                request.setAttribute("role", role);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.getRequestDispatcher("Insurance/Insurance.jsp").forward(request, response);
            }

            // Xóa bảo hiểm
        } else if (service.equals("deleteInsurance")) {
            if (!canEdit) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xóa bảo hiểm.");
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteInsurance(id);

            // Hiển thị lại danh sách bảo hiểm sau khi xóa
            int page = 1;
            int pageSize = 5;
            int totalRecords = dao.getTotalInsuranceCount();
            int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);
            Vector<Insurance> list = dao.getInsuranceByPage(page, pageSize);

            request.setAttribute("userList", dao.getAllUsers());
            request.setAttribute("carTypeList", dao.getAllCarTypes());
            request.setAttribute("insType", insTypeDAO.getAllInsuranceTypes());

            request.setAttribute("data", list);
            request.setAttribute("role", role);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("Insurance/Insurance.jsp").forward(request, response);

            // Sửa bảo hiểm
        } else if (service.equals("updateInsurance")) {
            if (!canEdit) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền sửa bảo hiểm.");
                return;
            }
            String submit = request.getParameter("submit");
            if (submit == null) {
                // Hiển thị form sửa bảo hiểm
                int id = Integer.parseInt(request.getParameter("id"));
                Insurance ins = dao.searchInsurance(id);
                Vector<User> userList = dao.getUsersByRole("customer");
                Vector<CarType> carTypeList = dao.getAllCarTypes();
                Vector<InsuranceType> insTypeList = insTypeDAO.getAllInsuranceTypes();
                request.setAttribute("insurance", ins);
                request.setAttribute("userList", userList);
                request.setAttribute("carType", carTypeList);
                request.setAttribute("insType", insTypeList);
                request.setAttribute("role", role);
                request.getRequestDispatcher("Insurance/updateInsurance.jsp").forward(request, response);
            } else {
                // Xử lý dữ liệu gửi lên từ form sửa
                int id = Integer.parseInt(request.getParameter("id"));
                int userId = Integer.parseInt(request.getParameter("userId"));
                int carTypeId = Integer.parseInt(request.getParameter("carTypeId"));
                int insuranceTypeId = Integer.parseInt(request.getParameter("insuranceTypeId"));
                Date startDate = Date.valueOf(request.getParameter("startDate"));
                Date endDate = Date.valueOf(request.getParameter("endDate"));
                // Kiểm tra endDate phải sau startDate
                if (!endDate.after(startDate)) {
                    request.setAttribute("error", "Ngày kết thúc phải sau ngày bắt đầu.");

                    // Lấy lại dữ liệu để hiển thị lại form
                    Insurance ins = dao.searchInsurance(id);  // Có thể dùng lại object `i` nếu đã tạo
                    Vector<User> userList = dao.getUsersByRole("customer");
                    Vector<CarType> carTypeList = dao.getAllCarTypes();
                    Vector<InsuranceType> insTypeList = insTypeDAO.getAllInsuranceTypes();

                    request.setAttribute("insurance", ins);
                    request.setAttribute("userList", userList);
                    request.setAttribute("carType", carTypeList);
                    request.setAttribute("insType", insTypeList);
                    request.setAttribute("role", role);

                    // Gửi lại giá trị người dùng đã nhập (nếu cần hiển thị lại đúng)
                    request.setAttribute("selectedUserId", userId);
                    request.setAttribute("selectedCarTypeId", carTypeId);
                    request.setAttribute("selectedInsuranceTypeId", insuranceTypeId);
                    request.setAttribute("startDate", startDate.toString());
                    request.setAttribute("endDate", endDate.toString());

                    request.getRequestDispatcher("Insurance/updateInsurance.jsp").forward(request, response);
                    return;
                }
                Insurance i = new Insurance(id, userId, carTypeId, insuranceTypeId, startDate, endDate);
                dao.updateInsurance(i);

                
                // Hiển thị lại danh sách bảo hiểm sau khi cập nhật
                int page = 1;
                int pageSize = 5;
                int totalRecords = dao.getTotalInsuranceCount();
                int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);
                Vector<Insurance> list = dao.getInsuranceByPage(page, pageSize);

                request.setAttribute("userList", dao.getAllUsers());
                request.setAttribute("carTypeList", dao.getAllCarTypes());
                request.setAttribute("insType", insTypeDAO.getAllInsuranceTypes());

                request.setAttribute("data", list);
                request.setAttribute("role", role);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.getRequestDispatcher("Insurance/Insurance.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "InsuranceServlet";
    }
}

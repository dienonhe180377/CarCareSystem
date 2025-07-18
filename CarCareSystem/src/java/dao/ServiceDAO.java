    package dao;

    import entity.Service;
    import entity.Part;
    import java.sql.PreparedStatement;
    import java.sql.ResultSet;
    import java.sql.SQLException;
    import java.util.ArrayList;
    import java.util.List;
    import java.util.Vector;

    public class ServiceDAO extends DBConnection {

        public Vector<Service> getAllService() {
            Vector<Service> listService = new Vector<>();
            String sql = "SELECT id, name, description, price, img FROM Service";
            try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    Service se = new Service(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getDouble("price"),
                            rs.getString("img")
                    );
                    listService.add(se);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return listService;
        }

        public Vector<Service> searchServiceByName(String name) {
            Vector<Service> listService = new Vector<>();
            String sql = "SELECT id, name, description, price, img FROM Service WHERE name LIKE ?";
            try (PreparedStatement ptm = connection.prepareStatement(sql)) {
                ptm.setString(1, "%" + name + "%");
                ResultSet rs = ptm.executeQuery();
                while (rs.next()) {
                    Service se = new Service(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getDouble("price"),
                            rs.getString("img")
                    );
                    listService.add(se);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return listService;
        }

        public int insertServiceAndReturnId(Service se) {
            String sql = "INSERT INTO [dbo].[Service] ([name],[description],[price],[img]) OUTPUT INSERTED.id VALUES (?,?,?,?)";
            try (PreparedStatement ptm = connection.prepareStatement(sql)) {
                ptm.setString(1, se.getName());
                ptm.setString(2, se.getDescription());
                ptm.setDouble(3, se.getPrice());
                ptm.setString(4, se.getImg());
                ResultSet rs = ptm.executeQuery();
                if (rs.next()) return rs.getInt(1);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return -1;
        }

        public void insertPartsForService(int serviceId, List<Integer> partIds) {
            String sql = "INSERT INTO PartsService (serviceId, partId) VALUES (?, ?)";
            try (PreparedStatement ptm = connection.prepareStatement(sql)) {
                for (Integer pid : partIds) {
                    ptm.setInt(1, serviceId);
                    ptm.setInt(2, pid);
                    ptm.addBatch();
                }
                ptm.executeBatch();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        public void updatePartsForService(int serviceId, List<Integer> partIds) {
            String deleteSql = "DELETE FROM PartsService WHERE serviceId = ?";
            try (PreparedStatement ptm = connection.prepareStatement(deleteSql)) {
                ptm.setInt(1, serviceId);
                ptm.executeUpdate();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            insertPartsForService(serviceId, partIds);
        }

        public List<Integer> getPartIdsByServiceId(int serviceId) {
            List<Integer> ids = new ArrayList<>();
            String sql = "SELECT partId FROM PartsService WHERE serviceId = ?";
            try (PreparedStatement ptm = connection.prepareStatement(sql)) {
                ptm.setInt(1, serviceId);
                ResultSet rs = ptm.executeQuery();
                while (rs.next()) ids.add(rs.getInt("partId"));
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return ids;
        }

        public void insertService(Service se) {
            String sql = "INSERT INTO [dbo].[Service] ([name],[description],[price],[img]) VALUES (?,?,?,?)";
            try (PreparedStatement ptm = connection.prepareStatement(sql)) {
                ptm.setString(1, se.getName());
                ptm.setString(2, se.getDescription());
                ptm.setDouble(3, se.getPrice());
                ptm.setString(4, se.getImg());
                ptm.executeUpdate();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        public Service searchService(int id) {
            String sql = "SELECT id, name, description, price, img FROM Service WHERE id=?";
            try (PreparedStatement ptm = connection.prepareStatement(sql)) {
                ptm.setInt(1, id);
                ResultSet rs = ptm.executeQuery();
                if (rs.next()) {
                    Service se = new Service(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getDouble("price"),
                            rs.getString("img")
                    );
                    return se;
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return null;
        }

        public void updateService(Service se) {
            String sql = "UPDATE [dbo].[Service] SET [name] = ?, [description] = ?, [price] = ?, [img] = ? WHERE id=?";
            try (PreparedStatement ptm = connection.prepareStatement(sql)) {
                ptm.setString(1, se.getName());
                ptm.setString(2, se.getDescription());
                ptm.setDouble(3, se.getPrice());
                ptm.setString(4, se.getImg());
                ptm.setInt(5, se.getId());
                ptm.executeUpdate();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

      public void deleteService(int id) {
            // 1. Xóa các UserVoucher liên quan đến Voucher của service này
            String sqlUserVoucher = "DELETE uv FROM UserVoucher uv " +
                                    "JOIN Voucher v ON uv.voucherId = v.id " +
                                    "WHERE v.serviceId = ?";
            try (PreparedStatement ptm = connection.prepareStatement(sqlUserVoucher)) {
                ptm.setInt(1, id);
                ptm.executeUpdate();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            // 2. Xóa các voucher liên quan đến service này
            String sqlVoucher = "DELETE FROM Voucher WHERE serviceId=?";
            try (PreparedStatement ptm = connection.prepareStatement(sqlVoucher)) {
                ptm.setInt(1, id);
                ptm.executeUpdate();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            // 3. Xóa các liên kết phụ tùng (PartsService)
            String sqlPartsService = "DELETE FROM PartsService WHERE serviceId=?";
            try (PreparedStatement ptm = connection.prepareStatement(sqlPartsService)) {
                ptm.setInt(1, id);
                ptm.executeUpdate();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            // 4. Xóa các liên kết với OrderService
            String sqlOrderService = "DELETE FROM OrderService WHERE serviceId=?";
            try (PreparedStatement ptm = connection.prepareStatement(sqlOrderService)) {
                ptm.setInt(1, id);
                ptm.executeUpdate();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            // 5. Xóa service khỏi bảng Service
            String sql = "DELETE FROM [dbo].[Service] WHERE id=?";
            try (PreparedStatement ptm = connection.prepareStatement(sql)) {
                ptm.setInt(1, id);
                ptm.executeUpdate();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        /**
         * Lấy danh sách Part liên quan đến 1 Service
         */
        public Vector<Part> getPartsByServiceId(int serviceId) {
            Vector<Part> parts = new Vector<>();
            String sql = "SELECT p.id, p.name, p.image, p.price "
                    + "FROM Parts p "
                    + "JOIN PartsService ps ON p.id = ps.partId "
                    + "WHERE ps.serviceId = ?";
            try (PreparedStatement ptm = connection.prepareStatement(sql)) {
                ptm.setInt(1, serviceId);
                ResultSet rs = ptm.executeQuery();
                while (rs.next()) {
                    Part part = new Part(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getDouble("price")
                    );
                    parts.add(part);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return parts;
        }

        /**
         * Lấy chi tiết Service và danh sách Part liên quan
         */
        public Service getServiceDetail(int id) {
            Service se = searchService(id);
            if (se != null) {
                Vector<Part> parts = getPartsByServiceId(id);
                se.setParts(new ArrayList<>(parts));
            }
            return se;
        }
        
        // Lay price theo id
        public double getPriceById(int serviceId) throws SQLException {
            String sql = "SELECT price FROM Service WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("price");
            }
            return 0;
        }
    }